# Internal Principles of Monitor
---

Due to the limitation of network and system, there are some special treatments in the execution of monitor detection.

## 1. Detect Trigger Time

The user-configured detection frequency is actually internally converted to a Crontab expression, and the monitor is actually started according to this Crontab expression instead of executing every N minutes after creation/saving.

Assuming that the user configures the execution frequency of "Monitor A" to be "5 minutes", the corresponding Crontab expression is `*/5 * * * *`, that is, the actual trigger time is as follows:

| Action                | Time       |
| ------------------- | ---------- |
| User Create/Save Monitor | `00:00:30` |
| Monitor trigger detection      | `00:05:00` |
| Monitor trigger detection      | `00:10:00` |
| Monitor trigger detection      | `00:15:00` |
| Monitor trigger detection      | `00:20:00` |
| ...                 | ...        |

## 2. Calibration of Detection Range

Because the platform carries thousands of detectors configured by all users, the detection processing triggered at the same time point cannot be executed at the same time, and most tasks will enter the queue and wait.

Therefore, most detection processing will encounter the situation that "execution should be triggered at T, but it actually executes in T + seconds".

If the actual execution time is directly used as the end time, and the data is queried according to the detection range, there will inevitably be problems such as repeated detection range or incomplete coverage, such as:

> Assuming a detection range of 5 minutes

| Action              | Time       | Detection Range                |
| ----------------- | ---------- | ----------------------- |
| 1. Monitor actual execution | `00:05:10` | `00:00:10` ~ `00:05:10` |
| 2. Monitor actual execution | `00:10:05` | `00:05:05` ~ `00:10:05` |
| 3. Monitor actual execution | `00:15:30` | `00:10:30` ~ `00:15:30` |

As described above, the detection ranges of "Action 1" and "Action 2" overlap from `00:05:05` to `00:05:10`.

Between "Action 2" and "Action 3", the data between `00:10:05` to `00:10:30` is not covered by detection.

### Current Solution

In order to avoid the fluctuation of detection range caused by queuing delay, the detection range of monitor (i.e., DQL query data range) will be calibrated according to its trigger time, such as:

> Assuming a detection range of 5 minutes

| Action                   | Time       | Detection Range                |
| ---------------------- | ---------- | ----------------------- |
| Monitor trigger detection (join the queue) | `00:05:00` |                         |
| Monitor actual execution (out of the queue) | `00:05:10` | `00:00:00` ~ `00:05:00` |
| Monitor trigger detection (join the queue) | `00:10:00` |                         |
| Monitor actual execution (out of the queue) | `00:10:30` | `00:05:00` ~ `00:10:00` |

It can be seen that no matter how long a detection waits after queuing, its detection range is determined according to the "trigger time", and does not fluctuate according to the actual execution time.

*Note: The above table is only a schematic description of "calibration of detection range", and the actual detection range will also be affected by "drift of detection range*

## 3. Detection Range Drift

Due to the influence of network delay and data drop delay, data reporting usually has a delay of several seconds or even tens of seconds. The specific performance is that the newly reported data cannot be obtained through DQL query.

Then, in the detection processing, it is very easy to cause the data in each detection range to be missing, such as:

> Assuming a detection range of 5 minutes

| Action                   | Time                                 | Detection Range                |
| ---------------------- | ------------------------------------ | ----------------------- |
| Report data A (not yet placed) | `00:09:59`                           |                         |
| Monitor trigger detection         | `00:10:00`                           | `00:05:00` ~ `00:10:00` |
| Report data A (placed)          | `00:10:05` (Data timestamp is `00:09:59`） |                         |
| Monitor trigger detection         | `00:15:00`                           | `00:10:00` ~ `00:15:00` |

It can be seen that although data A has been reported before the detection is executed, it cannot be queried when the monitor detects because it has not been dropped.

At the same time, even if the data A is dropped, the monitor cannot detect the data A in the next round because its data timestamp is earlier.

### Current Solution

In order to solve the above problems, when all monitors perform detection, they will automatically drift the detection range in an earlier direction for 1 minute, so as to avoid querying the data during the drop period.

Then, the above example will become the following situation:

> Assuming a detection range of 5 minutes

| Action                   | Time                                 | Detection Range                            |
| ---------------------- | ------------------------------------ | -------------------------------------- |
| Report data A (not yet placed) | `00:09:59`                           |                                        |
| Monitor trigger detection         | `00:10:00`                           | `00:04:00` ~ `00:09:00`(Drift for 1 min) |
| Report data A (placed)             | `00:10:05` (Data timestamp is `00:09:59`） |                                        |
| Monitor trigger detection         | `00:15:00`                           | `00:09:00` ~ `00:14:00`(Drift for 1 min) |

It can be seen that although the reported data A has drop delay, it can still be detected in the second round of detection, thus avoiding the lack of detection data caused by drop delay.

*Note: If the drop delay exceeds 1 minute, this scheme will fail and the test will not produce the expected effect.*

## 4. No Data Judgment Logic

Because Guance is a platform based on time series data, unlike non-asset management software, there is an asset list summary table. In fact, we can only think of "existence" with queriable data, and we can't know "which objects don't exist".

> Suppose I have a box with pencils and erasers in it.
>
> Well, I can say quite clearly, "There are pencils and erasers in the box,"
>
>  But I can't say "there's nothing in the box".
>
> Because I don't know "what should have been in the box" (that is, the asset summary)

Therefore, the "no data detection" in the monitor can only judge the data interruption and recovery in the way of "edge trigger".

That is, "I found X in the last round of inquiry, but I couldn't find X in this round of inquiry, so the data of X was broken".

Such as:

> Assuming a detection range of 5 minutes

| `00:00:00` ~ `00:05:00` | `00:05:00` ~ `00:10:00` | Check Result                   |
| ----------------------- | ----------------------- | -------------------------- |
| Exist data                 |                         | Data outage                   |
| Exist data                 | Exist data                    | Continued normal                   |
|                         | Exist data                    | Data re-reporting               |
|                         |                         | Persistent lack of data (meaningless judgment) |

*Note: The above table is only a schematic description of "no data judgment logic", and the actual two-time detection range will also be affected by the configuration of "detection range drift", "detection range" and "no data occurs within N consecutive minutes"*

## 5. No Data/No Data Recovery Events

When the monitor finds that there are "data broken files" and "data re-reported", "no data event" or "no data recovery event" may occur according to different configurations of users in the monitor.

However, in order to avoid meaningless repeated alarms, before generating the above events, it will be judged according to the existing events whether it is necessary to generate corresponding events:

| Last Event            | The Check Result of Test | Result               |
| --------------------- | ---------------- | ------------------ |
| No Events/No Data Recovery Events | Data outage         | Generate no data event     |
| No Events/No Data Events     | Data re-reporting     | Generate no data recovery event |

Therefore, "no data events" and "no data recovery events" always appear in pairs, and there will be no continuous "no data events" or continuous "no data recovery events".

## X. FAQ

### The Time Indicated by the Event not Matching the Time When the Event Occurred

Event details, alert notice, will be marked with a time, such as: `00:15:00`.

The marked time here is the monitor's "detection trigger time", that is, the time expressed by Crontab expression, which must be a regular detection frequency multiple.

> Exception: If you manually click Execute in the Monitor list, the corresponding event time is the actual execution time.

### The Time Indicated by the Event not Matching the Actual Fault Data Point Time

The time indicated by the event is the "detection trigger time" of the monitor, and due to the existence of "detection range drift", it is possible that the actual fault data point time is outside the interval of "detection trigger time-detection range ~ detection trigger time".

Because the actual detection range is "detection trigger time-detection range-drift time ~ detection trigger time-drift time"

This situation is normal.

### Looking at the data directly in Guance found that there should be a fault, but the monitor did not detect the fault

The causes of this problem are as follows:

1. Due to the large delay of the reported data entering and dropping, the fault point data cannot be queried when the detection is actually executed.
2. The DQL query fails when the detection is executed, which causes the detection to be interrupted.

This situation is beyond the control of the monitor.
