# Page Performance

Continuously optimizing user experience is key to the long-term success of any website. Whether you are an entrepreneur, marketer, or developer, Web Metrics can help you quantify the experience index of your site and identify opportunities for improvement.

## Google Core Web Vitals

[Web Vitals](https://web.dev/vitals/) is a new initiative by Google aimed at providing unified guidance on web quality signals that are essential for delivering outstanding web user experiences.

The metrics that constitute Core Web Vitals will evolve over time. The current metrics for 2020 focus on three aspects of user experience—loading performance, interactivity, and visual stability—and include the following metrics (and their respective thresholds):

![](img/before-send.png)

[Largest Contentful Paint (LCP)](https://web.dev/lcp/): Measures loading performance. To provide a good user experience, LCP should occur within 2.5 seconds of the page first starting to load.

[First Input Delay (FID)](https://web.dev/fid/): Measures interactivity. To provide a good user experience, the page's FID should be 100 milliseconds or less.

[Cumulative Layout Shift (CLS)](https://web.dev/cls/): Measures visual stability. To provide a good user experience, the page's CLS should be kept at 0.1 or less.

To ensure that you meet the recommended target values for most users, a good measurement threshold for each metric is the 75th percentile of page loads, applicable to both mobile and desktop devices.

## Page Collection Metrics

| Metric                            | Type (Unit) | Description                                                                                                                                                                                                                                                |
| --------------------------------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `view.time_spent`                 | number(ns)  | Time spent on the page.                                                                                                                                                                                                                                    |
| `view.loading_time`               | number(ns)  | Time when the page is ready and there are no network requests or DOM changes.<br/>> See [Page Loading Time](./page-performance.md).                                                                                                                        |
| `view.largest_contentful_paint`   | number(ns)  | Largest Contentful Paint, measures loading performance. To provide a good user experience, LCP should occur within 2.5 seconds of the page first starting to load.                                                                                        |
| `view.first_input_delay`          | number(ns)  | First Input Delay, measures interactivity. To provide a good user experience, the page's FID should be 100 milliseconds or less.                                                                                                                           |
| `view.cumulative_layout_shift`    | number(ns)  | Cumulative Layout Shift, measures visual stability. To provide a good user experience, the page's CLS should be kept at 0.1 or less.                                                                                                                       |
| `view.first_contentful_paint`     | number(ns)  | First Contentful Paint (FCP) measures the time from when the page starts loading until any part of the page content is rendered on the screen. "Content" refers to text, images (including background images), `<svg>` elements, or non-white `<canvas>` elements. <br/>> Refer to [w3c](https://www.w3.org/TR/paint-timing/#sec-terminology) |
| `view.first_byte`                 | number(ns)  | Time from requesting the page to receiving the first byte of the response.                                                                                                                                                                                 |
| `view.time_to_interactive`        | number(ns)  | Time from when the page starts loading until it has finished rendering major sub-resources and can respond quickly and reliably to user input.                                                                                                               |
| `view.dom_interactive`            | number(ns)  | Time when the parser finishes parsing the document. For more details, refer to [MDN](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceTiming/domInteractive).                                                                                   |
| `view.dom_content_loaded`         | number(ns)  | Triggered when the pure HTML is fully loaded and parsed without waiting for stylesheets, images, or subframes to complete loading. For more details, refer to [MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Document/DOMContentLoaded_event).           |
| `view.dom_complete`               | number(ns)  | When the page and all sub-resources are ready. For users, the loading spinner stops spinning. For more details, refer to [MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/DOMContentLoaded_event).                                             |
| `view.load_event`                 | number(ns)  | Triggered when the entire page and all dependent resources such as stylesheets and images have completed loading. It differs from `DOMContentLoaded`, which triggers as soon as the page DOM is loaded without waiting for dependent resources. For more details, refer to [MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/load_event). |

## About Single Page Applications (SPA)

For Single Page Applications (SPA), the RUM browser SDK uses the `loading_type` tag to distinguish between `initial_load` and `route_change`. The RUM SDK generates a `view` event with the `loading_type:route_change` tag. RUM uses the [History API](https://developer.mozilla.org/en-US/docs/Web/API/History) to listen for URL changes.

## Loading Time Calculation {#loading-time}

Based on the powerful API capabilities provided by modern browsers, Loading Time monitors the page's DOM changes and network request status.

- Initial Load: Loading Time takes the longer of the two:
  - `loadEventEnd - navigationStart`
  - Time of the first inactive moment - `navigationStart`
- SPA Route Change: Time of the first inactive moment - time of URL change

## Page Activity Status {#page-active}

If any of the following conditions are met, the page is considered *active*:

- The page DOM has changes.
- Static resources are being loaded (such as js, css, etc.).
- There are asynchronous requests.

**Note**:

If there are no events within 100ms, the page is considered inactive.

**Caution**:

In the following cases, the 100-millisecond standard may not accurately determine activity since the last request or DOM change:

- The application collects analytics data by sending requests to the API periodically or after each click.
- The application uses “comet” technology (i.e., streaming or long polling), where requests remain open indefinitely.

To improve the accuracy of activity determination in these cases, you can specify `excludedActivityUrls` configuration to exclude these requests:

```js
window.DATAFLUX_RUM.init({
  excludedActivityUrls: [
    // Exact match
    'https://third-party-analytics-provider.com/endpoint',

    // Regular expression
    /\/comet$/,

    // Function returning true to exclude
    (url) => url === 'https://third-party-analytics-provider.com/endpoint',
  ],
})
```