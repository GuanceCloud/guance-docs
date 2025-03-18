# Event Levels
---

| Name | <div style="width: 150px"> Corresponding `df_status` Value </div> | Description |
| --- | --- | --- |
| Information | info | If the detected metrics do not meet any of the trigger conditions for "Critical", "Error", "Warning", "OK", or "No Data", it indicates that there is no anomaly in the detection result. In this case, an "Information" event is triggered. |
| Warning | warning | Warning |
| Error | error | Error |
| Critical | critical | Critical |
| No Data | nodata | No Data |
| Recovery | ok | If any of the three abnormal events "Critical", "Error", or "Warning" were previously triggered during detection, and based on the N consecutive detections configured on the frontend, no "Critical", "Error", or "Warning" events occur within the detection period, it is considered recovered, and a normal recovery event is generated. |
| No Data Recovery | ok | If a data interruption anomaly event was previously triggered due to data reporting cessation, and new data is reported again, it is judged as recovered, generating a data interruption recovery event. |
| No Data Considered Recovered | ok | If a data interruption occurs in the detected data, this situation is considered normal, and a recovery event is generated. |
| Manual Recovery | ok | An OK event triggered by the user manually clicking to recover. |