# Page Channel Traffic Attraction Best Practices

---

## 1: Background

For marketing, it is crucial to understand the traffic situation of multi-channel campaign landing pages and registration pages. How do we record what the previous page was for this advertisement page? And how do we track the number of visits to this page? How do we record the number of button clicks on a particular page?

## 2: <<< custom_key.brand_name >>> Solution

### 1: How to Analyze Page Source Statistics

**View Attributes**

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| view_id | string | Unique ID generated each time a page is visited |
| is_active | boolean | Indicates whether the user is still active; reference values: true | false |
| view_loading_type | string | Page loading type, <br />reference values: initial_load | route_change<br />route_change refers to SPA page loading mode |
| view_referrer | string | Page source |
| view_url | string | Page URL |
| view_host | string | Domain part of the page URL |
| view_path | string | Path part of the page URL |
| view_path_group | string | Grouped path part of the page URL |
| view_url_query | string | Query part of the page URL |

**From the table above, we can see that in RUM PV, the metric "view_referrer" (page source) has already been collected. We can leverage this for page analysis.**

### 2: How to Track Button Clicks on a Page

**Action Attributes**

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| action_id | string | Unique ID generated when a user performs an operation on the page |
| action_name | string | Operation name |
| action_type | string | Type of operation |

**From the table above, we can see that in RUM PV, the metric "action_name" (button name) has already been collected. We can leverage this for tracking button click counts.**

**For more metrics, see:** [Web Application Data Collection](/real-user-monitoring/web/app-data-collection/)

## 3: Final Visualization

![image.png](../images/page-5.png)

## 4: Implementation Steps

### 1: Integrate RUM based on your actual scenario

Website integration reference: [web-rum integration](/real-user-monitoring/web/app-access/)

APP integration reference: [iOS-rum integration](/real-user-monitoring/ios/app-access/) / [Android-rum integration](/real-user-monitoring/android/app-access/)

Mini-program integration reference: [miniapp-rum integration](/real-user-monitoring/miniapp/app-access/)

### 2: Create Dashboards for Different Scenarios

#### a: Create a Chart Named "Traffic from Page A to Page B"

![image.png](../images/page-1.png)

Explanation by image: Record the number of transitions from the URL entered in field 6 to the URL entered in field 5.

1. In the list, select "User Access"
2. In the list, select "view"
3. In the list, select "count", as this records the count
4. In the list, select "view_referrer", meaning to track the page source
5. As one condition, set `view_url` to the URL of Page B, which is the monitored event page
6. As another condition, set `view_referrer` to the URL of Page A, which is the source page.

**Note: If there are multiple pages like C -> B, just replace the `view_referrer` URL with the URL of Page C, and so on.**

#### b: Create a Chart Named "Button Click Counts on Page A"

![image.png](../images/page-2.png)

Explanation by image: Record the number of button clicks on Page A.

1. In the list, select "User Access"
2. In the list, select "action"
3. In the list, select "count", as this records the count
4. In the list, select "action_name", which is the button name
5. As one condition, set `view_url` to the URL of Page A, which is the page where you want to monitor buttons
6. As another condition, set `action_name` to the displayed name on the page, such as "Manage", "Reset", "+ Add"

![image.png](../images/page-3.png)

**Note: If there are multiple buttons to track, follow the same steps.**

#### c: Create a Map for Geographical Distribution of Visits to Page A - China

![image.png](../images/page-4.png)

Condition here is the URL of Page A.

**Note: World maps are similar to China maps.**

## Summary

After integrating web monitoring, <<< custom_key.brand_name >>> collects a large number of metrics. We can use these metrics to complete monitoring with minimal effort, recording their sources (from which page or which button click) for statistical analysis.