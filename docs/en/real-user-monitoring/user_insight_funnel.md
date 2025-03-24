# Funnel Analysis
---

Funnel analysis, as a data analysis model, is used to visualize and quantify user conversion across a series of predefined steps. By capturing user session data, it displays user behaviors in key workflows step by step, forming a funnel shape that narrows from wide at the top. The retention and loss of users at each step are clearly visible, helping analysts intuitively monitor the success rate of business processes and identify friction points that may lead to user loss.

**Note**: Only supports workspaces with Doris engine.

## Use Cases

- Webpage Optimization: Analyze the conversion path of users from the homepage to the target page, optimizing the layout and content of pages;
- E-commerce Conversion Improvement: Monitor the conversion rates at each stage of the purchasing process, identifying and improving loss stages to increase purchase completion rates;
- Application Function Enhancement: Evaluate the process users take to complete tasks within an application, optimizing the function experience and enhancing user retention.

## Start Configuration

### 1. Define Conversion Steps

By default, two step types are provided: [View](./explorer/view.md) and [Action](./explorer/action.md).

1. Click the copy button on the right side of the step to directly duplicate and add the current step;
2. You can continue adding steps as needed;
3. You can reset steps as needed;

#### Operators

| Type      | Operator          | Description          |
| ----------- | --------- |--------- |
| View      | is     | i.e., `=` |
|       | not is        | i.e., `≠` |
|       | contains        | i.e., `match` |
|       | matches regex     | i.e., `regex query` |
| Action      | is          |  |
|       | contains        |  |


### 2. Filter User Scope

Determine the `session` data scope through filtering conditions such as city, environment, version, browser, session duration, and the first page path of the session.

Click "More" to search and add more filtering conditions.

<img src="../img/user_insight_funnel.png" width="80%" >

## Funnel Chart

Visually presents end-to-end conversion rates in chart form.

As shown in the figure below, in the RUM application list, out of 10 `sessions`, only 1 `session` performed the `export` action, resulting in a conversion rate of 90% for this behavior.

<img src="../img/user_insight_funnel_1.png" width="80%" >

- For this chart, you can export it to a dashboard/note or save it as a PNG image.
- On the right side of the Session, you can click to jump to the session replay.

> For more details, refer to [Web Session Replay](./session-replay/web/index.md)

## Time-based Conversion Rate

Conversion behaviors can also be presented and judged through time trends.