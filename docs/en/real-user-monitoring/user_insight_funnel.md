# Funnel Analysis
---

Funnel analysis, as a data analysis model, is used to visualize and quantify user conversion through a series of predefined steps. By capturing user session data, it displays user behavior in critical workflows step by step, forming a funnel shape that narrows from wide at the top. The retention and churn of users at each step are clearly visible, helping analysts monitor the success rate of business processes and identify friction points that may lead to user loss.

**Note**: Only supports workspaces using the Doris engine.

## Use Cases

- Webpage Optimization: Analyze the conversion path of users from the homepage to the target page to optimize page layout and content;
- E-commerce Conversion Improvement: Monitor conversion rates at various stages of the purchasing process, identify and improve dropout stages, and increase the completion rate of purchases;
- Application Functionality Improvement: Evaluate the process users follow to complete tasks within the app, optimize the function experience, and enhance user retention.

## Configuration

### :material-numeric-1-circle: Define Conversion Steps

By default, two step types are provided: [View](./explorer/view.md) and [Action](./explorer/action.md).

1. Click the copy button on the right side of the step to directly duplicate and add the current step;
2. Add more steps as needed;
3. Reset steps as needed;

#### Operators

| Type      | Operator          | Description          |
| ----------- | --------- |--------- |
| View      | is     | i.e., `=` |
|       | not is        | i.e., `≠` |
|       | contains        | i.e., `match` |
|       | matches regex     | i.e., `regex query` |
| Action      | is          |  |
|       | contains        |  |

### :material-numeric-2-circle: Filter User Scope

Determine the `session` data range using filtering conditions such as city, environment, version, browser, session duration, and the path of the first page visited.

Click "More" to search and add additional filtering conditions.

![User Insight Funnel](../img/user_insight_funnel.png)

## Funnel Chart

Visualize end-to-end conversion rates in chart form.

As shown in the figure below, in the RUM application list, out of 11 `sessions`, only 1 `session` performed the `export` action, resulting in a conversion rate of 9.09%.

![User Insight Funnel 1](../img/user_insight_funnel_1.png)

For this chart, you can export it to a dashboard/note or save it as a PNG image.

## Time-Based Conversion Rate

Conversion behaviors can also be presented and evaluated through time trends.