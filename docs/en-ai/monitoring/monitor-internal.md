# Internal Principles of Monitors
---

The execution of monitor checks, due to limitations such as network and system constraints, involves some special processing.

## 1. Detection Trigger Time

The detection frequency configured by users is internally converted into a Crontab expression. The monitor actually starts according to this Crontab expression rather than executing every N minutes after creation or saving.

Assuming the user configures a detection frequency of "5 minutes" for "Monitor A," the corresponding Crontab expression would be `*/5 * * * *`, meaning the actual trigger times are as follows:

| Action                  | Time       |
| ----------------------- | ---------- |
| User creates/saves monitor | `00:00:30` |
| Monitor triggers detection | `00:05:00` |
| Monitor triggers detection | `00:10:00` |
| Monitor triggers detection | `00:15:00` |
| Monitor triggers detection | `00:20:00` |
| ...                     | ...        |

## 2. Detection Range Calibration

Since the platform handles thousands of monitors configured by all users, it is impossible for all detection tasks triggered at the same time point to execute simultaneously; most tasks will enter a queue and wait.

Therefore, most detection processes encounter the situation where <u>they should have been triggered at time T but actually execute several seconds later</u>.

If the actual execution time is directly used as the end time for querying data based on the detection range, there will inevitably be issues of overlapping or incomplete coverage of the detection range, such as:

> Assuming the detection range is 5 minutes:

| Action                | Time       | Detection Range             |
| --------------------- | ---------- | --------------------------- |
| 1. Monitor executes   | `00:05:10` | `00:00:10` ~ `00:05:10`     |
| 2. Monitor executes   | `00:10:05` | `00:05:05` ~ `00:10:05`     |
| 3. Monitor executes   | `00:15:30` | `00:10:30` ~ `00:15:30`     |

In the above scenario, "Action 1" and "Action 2" overlap in the detection range from `00:05:05` ~ `00:05:10`.

Between "Action 2" and "Action 3," data between `00:10:05` ~ `00:10:30` is not covered by the detection.

### Current Solution

To avoid fluctuations in the detection range caused by queuing delays, the detection range (i.e., DQL query data range) of the monitor is calibrated based on its trigger time, such as:

> Assuming the detection range is 5 minutes:

| Action                       | Time       | Detection Range             |
| ---------------------------- | ---------- | --------------------------- |
| Monitor triggers detection (enqueue) | `00:05:00` |                         |
| Monitor executes (dequeue)    | `00:05:10` | `00:00:00` ~ `00:05:00`     |
| Monitor triggers detection (enqueue) | `00:10:00` |                         |
| Monitor executes (dequeue)    | `00:10:30` | `00:05:00` ~ `00:10:00`     |

As can be seen, regardless of how long a detection waits in the queue, its detection range is determined based on the [trigger time] and does not fluctuate based on the actual execution time.

**Note**: The above table is only an illustration of "detection range calibration"; the actual detection range may also be affected by "detection range drift."

## 3. Detection Range Drift

Due to network latency, data landing delays, and other factors, data reporting generally has a delay of several seconds or even tens of seconds. This manifests as newly reported data not being retrievable via DQL queries.

Thus, during detection processing, it is very easy for data within each detection range to be missing, such as:

> Assuming the detection range is 5 minutes

| Action                       | Time                                 | Detection Range             |
| ---------------------------- | ------------------------------------ | --------------------------- |
| Data A reported (not landed)  | `00:09:59`                           |                             |
| Monitor triggers detection   | `00:10:00`                           | `00:05:00` ~ `00:10:00`     |
| Data A lands                 | `00:10:05` (timestamp `00:09:59`)    |                             |
| Monitor triggers detection   | `00:15:00`                           | `00:10:00` ~ `00:15:00`     |

As can be seen, although Data A was reported before the detection execution, it could not be queried by the monitor because it had not yet landed.

Even when Data A eventually lands, since its timestamp is earlier, it cannot be detected by the next round of monitoring.

### Current Solution

To solve the above problem, all monitors automatically shift the detection range back by 1 minute when performing detections to avoid querying data that is still in the landing period.

Thus, the previous example becomes:

> Assuming the detection range is 5 minutes

| Action                       | Time                                 | Detection Range                               |
| ---------------------------- | ------------------------------------ | --------------------------------------------- |
| Data A reported (not landed)  | `00:09:59`                           |                                               |
| Monitor triggers detection   | `00:10:00`                           | `00:04:00` ~ `00:09:00` (shifted 1 minute)   |
| Data A lands                 | `00:10:05` (timestamp `00:09:59`)    |                                               |
| Monitor triggers detection   | `00:15:00`                           | `00:09:00` ~ `00:14:00` (shifted 1 minute)   |

As can be seen, Data A, despite having a landing delay, can still be detected in the second round of detection, thus avoiding data loss due to landing delays.

*Note: If the landing delay exceeds 1 minute, this solution will fail, and the detection will not produce the expected results.*

## 4. Data Gap Judgment Logic

Since <<< custom_key.brand_name >>> is a platform based on time series data, unlike asset management software, it does not have a master list of assets. It can only determine what "exists" based on queryable data and cannot identify what "does not exist."

> Suppose I have a box containing pencils and erasers.
>
> I can clearly state, "The box contains pencils and erasers."
>
> But I cannot say, "The box does not contain anything else."
>
> Because I do not know what the box "should contain" (i.e., the asset master list).

Therefore, the "data gap detection" in monitors can only judge data gaps and recoveries based on "edge triggering."

That is, "In the last round of queries, I found X, but in this round, I did not find X, so X has a data gap."

For example:

> Assuming the detection range is 5 minutes

| `00:00:00` ~ `00:05:00` | `00:05:00` ~ `00:10:00` | Judgment Result         |
| ----------------------- | ----------------------- | ---------------------- |
| Data present            |                         | Data gap               |
| Data present            | Data present            | Continuous normal      |
|                         | Data present            | Data re-reported       |
|                         |                         | Continuous data gap (meaningless judgment) |

**Note**: The above table is only an illustration of "data gap judgment logic"; actual detection ranges may be affected by "detection range drift," "detection range," and configurations like "data gap within N consecutive minutes."

## 5. Data Gap / Data Gap Recovery Events

When the monitor detects "data gap" or "data re-reporting," depending on different configurations in the monitor, it may generate "data gap events" or "data gap recovery events."

However, to avoid meaningless repeated alerts, before generating these events, it will check existing events to determine whether to generate corresponding events:

| Last Event                | Current Detection Judgment | Result                      |
| ------------------------- | -------------------------- | --------------------------- |
| No event/data gap recovery event | Data gap              | Generate data gap event     |
| No event/data gap event     | Data re-reported          | Generate data gap recovery event |

Therefore, "data gap events" and "data gap recovery events" always occur in pairs and will not appear consecutively.

## X. Common Issues

### Event Marked Time Does Not Match Event Generation Time

In event details and alert notifications, a time is marked, such as `00:15:00`.

This marked time is always the monitor's "detection trigger time," i.e., the time expressed by the Crontab expression, which must be a multiple of the detection frequency.

> Exception: If you manually click to execute in the monitor list, the event generation time will be the actual execution time.

### Event Marked Time Does Not Match Actual Fault Data Point Time

The marked time in events is always the monitor's "detection trigger time," and due to "detection range drift," the actual fault data point time may indeed fall outside the "detection trigger time - detection range ~ detection trigger time" interval.

Because the actual detection range is "detection trigger time - detection range - drift time ~ detection trigger time - drift time"

This situation is normal.

### Directly Viewing Data in <<< custom_key.brand_name >>> Shows That There Should Be a Fault, but the Monitor Did Not Detect It

The reasons for this issue are as follows:

1. Due to excessive data reporting and landing delays, fault data points cannot be queried when the detection actually executes.
2. During detection execution, a DQL query failure causes the detection to interrupt.

These situations are not within the control of the monitor.