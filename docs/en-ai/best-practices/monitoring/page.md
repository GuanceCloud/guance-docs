# Best Practices for Observability in Channel Traffic Acquisition

---

## I: Background

For marketing, it is crucial to understand the traffic acquisition situation of multi-channel campaign landing pages and registration pages. How do we record what the previous page was for this advertisement page? And how many times has this page been visited? How do we record the number of button clicks on a specific page?

## II: Guance Solution

### 1: How to Analyze Page Origin Statistics

【View Attributes】

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| view_id | string | A unique ID generated each time a page is visited |
| is_active | boolean | Indicates whether the user is still active; reference values: true &#124; false |
| view_loading_type | string | Type of page loading,<br />reference values: initial_load &#124; route_change<br />route_change refers to SPA page loading mode |
| view_referrer | string | Referring page |
| view_url | string | Page URL |
| view_host | string | Domain part of the page URL |
| view_path | string | Path part of the page URL |
| view_path_group | string | Grouped path part of the page URL |
| view_url_query | string | Query part of the page URL |

**As shown above, in RUM, the metric "view_referrer" (referring page) is already captured. We can use this data for page analysis**

### 2: How to Track Button Clicks on Pages

【Action Attributes】

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| action_id | string | A unique ID generated when a user performs an action on the page |
| action_name | string | Action name |
| action_type | string | Type of action |

**As shown above, in RUM, the metric "action_name" (button name) is already captured. We can use this data to analyze button click counts**

_**For more metrics, see:**_[Web Application Data Collection](/real-user-monitoring/web/app-data-collection/)

## III: Final Visualization

![image.png](../images/page-5.png)

## IV: Implementation Steps

### 1: Integrate RUM based on your actual needs

Website integration reference: [web-RUM Integration](/real-user-monitoring/web/app-access/)

APP integration reference: [iOS-RUM Integration](/real-user-monitoring/ios/app-access/) / [Android-RUM Integration](/real-user-monitoring/android/app-access/)

Mini-program integration reference: [Mini-program-RUM Integration](/real-user-monitoring/miniapp/app-access/)

### 2: Create a New Dashboard for the Scenario

#### a: Create a new chart titled "Traffic from Page A to Page B" (where B is the campaign page)

![image.png](../images/page-1.png)

Explanation: Record the number of transitions from the URL specified in field 6 to the URL specified in field 5.

1: In the list, select "User Analysis"

2: In the list, select "View"

3: In the list, select "count", as this records the count, so we need to use count

4: In the list, select "view_referrer", which means tracking the referring page

5: One condition is setting `view_url` to the URL of Page B, i.e., the monitored campaign page URL

6: Another condition is setting `view_referrer` to the URL of Page A, i.e., the source URL.

_**Note: If there are multiple pages like C->B, etc., simply replace the `view_referrer` URL with the URL of Page C, and so on.**_

#### b: Create a new chart titled "Button Clicks on Page A"

![image.png](../images/page-2.png)

Explanation: Record the number of button clicks on Page A

1: In the list, select "User Analysis"

2: In the list, select "Action"

3: In the list, select "count", as this records the count, so we need to use count

4: In the list, select "action_name", which refers to the button name

5: One condition is setting `view_url` to the URL of Page A, i.e., the page where the button is located

6: Another condition is setting `action_name` to the name displayed on the page, such as "Manage", "Reset", "+ Add"

![image.png](../images/page-3.png)

_**Note: If you need to track multiple buttons, follow the same process.**_

#### c: Create a map titled "Geographical Distribution of Visits to Page A - China"

![image.png](../images/page-4.png)

The condition here is the URL of Page A.

_**Note: The world map is similar to the China map.**_

## Summary
After integrating web monitoring, Guance captures a large number of metrics. We can use these metrics to monitor and record their origins (from which page or button click) with minimal effort for statistical analysis.