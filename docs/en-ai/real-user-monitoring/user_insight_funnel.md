# Funnel Analysis
---

Funnel analysis is a data analysis model used to visualize and quantify user conversion through a series of predefined steps. By capturing user session data, it breaks down user behavior in key workflows into steps, forming a funnel shape that narrows from wide at the top. The retention and churn of users at each step are clearly visible, helping analysts monitor the success rate of business processes and identify friction points that may lead to user churn.

**Note**: Only supports workspaces using the Doris engine.

## Application Scenarios

- Web Browsing Optimization: Analyze the conversion path of users from the homepage to the target page, optimizing page layout and content;
- E-commerce Conversion Improvement: Monitor the conversion rates at each stage of the purchase process, identifying and improving drop-off points to increase completion rates;
- Application Functionality Enhancement: Evaluate the workflow users follow to complete tasks within the app, optimizing functionality and enhancing user retention.

## Getting Started with Configuration

### :material-numeric-1-circle: Define Conversion Steps

By default, two step types are provided: [View](./explorer/view.md) and [Action](./explorer/action.md).

1. Click the copy button on the right side of a step to duplicate and add the current step;
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

Determine the `session` data range using filtering conditions such as city, environment, version, browser, session duration, and the first page path of the session.

Click "More" to search and add additional filtering conditions.

![User Analysis Funnel](../img/user_insight_funnel.png)

## Funnel Chart

Visualizes end-to-end conversion rates in chart form.

As shown below, in the RUM application list, out of 11 `sessions`, only 1 `session` performed the `export` action, resulting in a conversion rate of 9.09%.

![User Analysis Funnel Example](../img/user_insight_funnel_1.png)

This chart can be exported to a dashboard/note or saved as a PNG image.

## Time-based Conversion Rate

Conversion behaviors can also be presented and evaluated through time trends.