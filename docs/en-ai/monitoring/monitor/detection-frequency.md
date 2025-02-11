# Custom Crontab Tasks

A Crontab expression is a string used to configure scheduled tasks, consisting of five or six fields that represent minutes, hours, day of the month, month, day of the week, and optionally the year. Each field uses numbers and can include specific symbols to define ranges or steps.

You can input Crontab syntax in Guance > Threshold Detection > Detection Frequency. The basic format is: minute hour day month week.

## Value Range Explanation

- Minute: 0 - 59, indicating the minute within an hour;

- Hour: 0 - 23, indicating the hour within a day;

- Day: 1 - 31, indicating the day within a month;

- Month: 1 - 12, indicating the month within a year;

- Week: 0 - 7, indicating the day within a week, where 0 or 7 both represent Sunday.

## Special Characters

Includes `-` `*` `/` `,`:

- `*`: Can be any value, for example, `* * * * *` means execute every 1 minute;

- `-`: Defines a range of values, for example, `0-10 * * * *` means execute every minute from the 0th to the 10th minute of each hour;

- `/`: Defines step increments, the number before `/` indicates the starting minute, and the number after `/` indicates the interval. For example, `*/10 * * * *` means execute every 10 minutes;

- `,`: Specifies multiple values, separated by commas. For example, `0,3,12,18 * * * *` means execute at the 0th, 3rd, 12th, and 18th minute of each hour.

## Crontab Examples

`* * * * *`: Execute once every minute

`0 * * * *`: Execute once at the 0th minute of every hour

`0 0 * * *`: Execute once at 00:00 every day

`0 0 1 * *`: Execute once at 00:00 on the 1st day of every month

`0 0 1 1 *`: Execute once at 00:00 on January 1st every year

`0 0 * * 0`: Execute once at 00:00 every Sunday

`0-10 * * * *`: Execute every minute from the 0th to the 10th minute of each hour

`*/10 * * * *`: Execute once every 10 minutes

`0,3,12,18 * * * *`: Execute at the 0th, 3rd, 12th, and 18th minute of each hour