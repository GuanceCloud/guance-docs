# Internal Principles of Monitors
---

The execution of monitor detections is subject to limitations such as network and system constraints, leading to some special handling.

## 1. Detection Trigger Time

The detection frequency configured by users is internally converted into a Crontab expression. The monitor starts according to this Crontab expression rather than executing every N minutes after creation or saving.

Assume the user configures a "Monitor A" with an execution frequency of "5 minutes," then the corresponding Crontab expression is `*/5 * * * *`, meaning the actual trigger times are as follows:

| Action                     | Time       |
| -------------------------- | ---------- |
| User creates/saves monitor  | `00:00:30` |
| Monitor triggers detection | `00:05:00` |
| Monitor triggers detection | `00:10:00` |
| Monitor triggers detection | `00:15:00` |
| Monitor triggers detection | `00:20:00` |
| ...                        | ...        |

## 2. Calibration of Detection Range

Since the platform supports thousands of monitors configured by all users, it's not possible for all detections triggered at the same time point to execute simultaneously; most tasks will enter a queue to wait.

Therefore, most detection processes encounter situations where they should have been executed at time T but actually execute several seconds later at T + several seconds.

If the actual execution time is directly used as the end time and data is queried based on the detection range, there will inevitably be overlapping or incomplete coverage issues in the detection range, such as:

> Assuming the detection range is 5 minutes:

| Action                 | Time       | Detection Range                |
| ---------------------- | ---------- | ------------------------------ |
| 1. Monitor executes    | `00:05:10` | `00:00:10` ~ `00:05:10`        |
| 2. Monitor executes    | `00:10:05` | `00:05:05` ~ `00:10:05`        |
| 3. Monitor executes    | `00:15:30` | `00:10:30` ~ `00:15:30`        |

As shown above, the detection ranges of "Action 1" and "Action 2" overlap between `00:05:05` ~ `00:05:10`.

Between "Action 2" and "Action 3", data from `00:10:05` ~ `00:10:30` is not covered by the detection.

### Current Solution

To avoid fluctuations in the detection range due to queuing delays, the detection range (i.e., DQL query data range) of the monitor is calibrated based on its trigger time, like this:

> Assuming the detection range is 5 minutes:

| Action                          | Time       | Detection Range                |
| ------------------------------- | ---------- | ------------------------------ |
| Monitor triggers detection (enqueued) | `00:05:00` |                             |
| Monitor executes (dequeued)      | `00:05:10` | `00:00:00` ~ `00:05:00`        |
| Monitor triggers detection (enqueued) | `00:10:00` |                             |
| Monitor executes (dequeued)      | `00:10:30` | `00:05:00` ~ `00:10:00`        |

It can be seen that regardless of how long a detection waits in the queue, its detection range is determined based on the **trigger time** and does not fluctuate based on the actual execution time.

**Note**: The above table is only illustrative of "detection range calibration"; the actual detection range may also be affected by "detection range drift."

## 3. Detection Range Drift

Due to network latency, data landing delays, etc., data reporting usually has a delay of several seconds or even tens of seconds. This manifests as newly reported data being unavailable through DQL queries.

This can easily lead to missing data within each detection range during the detection process, such as:

> Assuming the detection range is 5 minutes:

| Action                          | Time                                 | Detection Range                |
| ------------------------------- | ------------------------------------ | ------------------------------ |
| Data A reported (not yet landed) | `00:09:59`                           |                               |
| Monitor triggers detection      | `00:10:00`                           | `00:05:00` ~ `00:10:00`        |
| Data A lands                    | `00:10:05` (timestamp `00:09:59`)   |                               |
| Monitor triggers detection      | `00:15:00`                           | `00:10:00` ~ `00:15:00`        |

It can be seen that although Data A was reported before the detection execution, it could not be queried because it had not yet landed.

Even when Data A eventually lands, since its timestamp is earlier, it cannot be detected by the next round of monitoring.

### Current Solution

To solve the above problem, all monitors automatically shift the detection range back by 1 minute when executing detections to avoid querying data during the landing period.

Then, the above example becomes:

> Assuming the detection range is 5 minutes:

| Action                          | Time                                 | Detection Range                               |
| ------------------------------- | ------------------------------------ | --------------------------------------------- |
| Data A reported (not yet landed) | `00:09:59`                           |                                               |
| Monitor triggers detection      | `00:10:00`                           | `00:04:00` ~ `00:09:00` (shifted 1 minute)   |
| Data A lands                    | `00:10:05` (timestamp `00:09:59`)    |                                               |
| Monitor triggers detection      | `00:15:00`                           | `00:09:00` ~ `00:14:00` (shifted 1 minute)   |

It can be seen that although Data A has a landing delay, it can still be detected in the second round of detection, thus avoiding data loss due to landing delays.

*Note: If the landing delay exceeds 1 minute, this solution will fail, and the detection will not produce the expected results.*

## 4. Logic for Data Discontinuity Judgment

Since Guance is a platform based on time series data and does not have an asset list like non-asset management software, it can only consider data as "exist" if it can be queried and cannot determine what "does not exist."

> Suppose I have a box containing pencils and erasers.
>
> Then, I can clearly state, "There are pencils and erasers in the box."
>
> But I cannot say, "What does not exist in the box."
>
> Because I do not know "what should be in the box" (i.e., the asset list).

Therefore, the "data discontinuity detection" in monitors can only judge data discontinuities and recoveries using an "edge-triggered" method.

That is, "In the last round of queries, I found X, but in this round, I cannot find X, so X has a data discontinuity."

For example:

> Assuming the detection range is 5 minutes:

| `00:00:00` ~ `00:05:00` | `00:05:00` ~ `00:10:00` | Judgment Result               |
| ----------------------- | ----------------------- | ----------------------------- |
| Data exists             |                         | Data discontinuity            |
| Data exists             | Data exists             | Continuous normal operation   |
|                         | Data exists             | Data re-reported              |
|                         |                         | Continuous data discontinuity (meaningless judgment) |

**Note**: The above table is only illustrative of "data discontinuity judgment logic"; actual two consecutive detection ranges may be affected by "detection range drift," "detection range," and "continuous N minutes of data discontinuity" configurations.

## 5. Data Discontinuity / Data Discontinuity Recovery Events

When the monitor detects "data discontinuity" or "data re-reporting," depending on the different configurations set by users in the monitor, it may generate "data discontinuity events" or "data discontinuity recovery events."

However, to avoid meaningless repeated alerts, before generating these events, it will judge whether corresponding events already exist to determine if new events need to be generated:

| Last Event                  | Current Detection Result | Outcome                      |
| --------------------------- | ------------------------ | ---------------------------- |
| No event/data discontinuity recovery event | Data discontinuity | Generate data discontinuity event |
| No event/data discontinuity event     | Data re-reported     | Generate data discontinuity recovery event |

Therefore, "data discontinuity events" and "data discontinuity recovery events" always occur in pairs and will not result in consecutive "data discontinuity events" or "data discontinuity recovery events."

## X. Common Issues

### Event Marked Time Does Not Match Event Generation Time

In event details and alert notifications, a time is marked, such as `00:15:00`.

The marked time is always the monitor's "detection trigger time," which is the time expressed by the Crontab expression and must be a multiple of the regular detection frequency.

> Exception: If you manually click to execute in the monitor list, the event time generated corresponds to the actual execution time.

### Event Marked Time Does Not Match Actual Fault Data Point Time

The marked time in events is always the monitor's "detection trigger time," and due to "detection range drift," it is possible that the actual fault data point time falls outside the interval of "detection trigger time - detection range ~ detection trigger time."

Because the actual detection range is "detection trigger time - detection range - drift time ~ detection trigger time - drift time."

This situation is normal.

### Directly Viewing Data in Guance Shows That There Should Be a Fault, But the Monitor Did Not Detect It

The reasons for this issue are as follows:

1. Due to excessive reporting data landing delays, the fault data points were not available for querying during the actual execution of the detection.
2. During the detection execution, the DQL query failed, causing the detection to be interrupted.

This situation is beyond the control of the monitor.