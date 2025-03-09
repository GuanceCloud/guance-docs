# Custom Crontab Task

A Crontab expression is a string used to configure scheduled tasks, consisting of five or six fields that represent minutes, hours, day of the month, month, day of the week, and optionally the year. Each field uses numbers and can specify ranges or steps with specific symbols.

You can input Crontab syntax at <<< custom_key.brand_name >>> threshold detection > detection frequency, with the basic format being: minute hour day month week.

## Value Range Explanation

- Minute: 0 - 59, indicating which minute within an hour;

- Hour: 0 - 23, indicating which hour within a day;

- Day: 1 - 31, indicating which day within a month;

- Month: 1 - 12, indicating which month within a year;

- Week: 0 - 7, indicating which day within a week, where 0 or 7 both represent Sunday.



## Special Characters

Including `-` `*` `/` `,`:

- `*`: Can be any value, for example, * * * * * indicates execution every 1 minute;

- `-`: Value range, for example, 0-10 * * * * indicates execution every 1 minute from the 0th to the 10th minute of each hour;

- `/`: Step definition, the number before / indicates the starting minute, and the number after / indicates the interval. For example, */10 * * * * indicates execution every 10 minutes;

- `,`: Multiple values specified, separated by commas. For example, 0,3,12,18 * * * * indicates execution at the 0th, 3rd, 12th, and 18th minute of each hour.



## Crontab Examples

`* * * * *`: Execute the scheduled task every minute

`0 * * * *`: Execute the scheduled task at the 0th minute of every hour

`0 0 * * *`: Execute the scheduled task at 00:00 every day

`0 0 1 * *`: Execute the scheduled task at 00:00 on the 1st day of every month

`0 0 1 1 *`: Execute the scheduled task at 00:00 on January 1st every year

`0 0 * * 0`: Execute the scheduled task at 00:00 every Sunday

`0-10 * * * *`: Execute the scheduled task every minute from the 0th to the 10th minute of every hour

`*/10 * * * *`: Execute the scheduled task every 10 minutes

`0,3,12,18 * * * *`: Execute the scheduled task at the 0th, 3rd, 12th, and 18th minute of every hour