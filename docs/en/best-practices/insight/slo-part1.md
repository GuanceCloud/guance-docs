# SLO from Methodology to Practice: Part 1 Establishing Effective SLOs

---

In recent years, organizations have increasingly adopted Service Level Objectives (SLOs) as a fundamental part of their Site Reliability Engineering (SRE) practices. Google pioneered the best practices around SLOs—Google's SRE books provide an excellent introduction to this concept. At its core, SLOs are rooted in the idea that service reliability and user satisfaction should go hand in hand. Setting specific and measurable reliability goals helps organizations strike the right balance between product development and operational efforts, ultimately leading to a positive end-user experience.

We will explore SLOs in three parts:

[SLO from Methodology to Practice: Part 1 Establishing Effective SLOs](slo-part1.md)

[SLO from Methodology to Practice: Part 2 Selecting SLO Tools](slo-part2.md)

[SLO from Methodology to Practice: Part 3 Best Practices for Managing SLOs with <<< custom_key.brand_name >>>](slo-part3.md)

## Key Terminology
Before we proceed, let’s break down some key terms that will be used throughout this series:

- **Service Level Indicator (SLI)** is a metric used to measure the level of service provided to end users (e.g., availability, latency, throughput).
- **Service Level Objective (SLO)** is the target service level, measured by SLIs. They are typically expressed as a percentage over a period of time.
- **Service Level Agreement (SLA)** is a contractual agreement that outlines the level of service end users can expect from a service provider. If these commitments are not met, providers may face significant consequences, which are often financial in nature (e.g., service credits, subscription extensions).
- **Error Budget** is the acceptable level of unreliability a service can have before it fails to meet its SLO. In short, they represent the difference between 100% reliability and the SLO target. You can think of an error budget like a financial budget—but in this case, developers use it to allocate resources for building new features, redesigning system architecture, or any other product development work.

### Who Cares About Service Level Objectives?
To get buy-in from key stakeholders across the organization, you need them to agree on achievable reliability targets, considering business priorities and the projects they wish to undertake. In this section, we will examine what matters to end users, developers, and operations engineers, and how we should consider their goals and priorities when setting SLOs.

#### End Users
Regardless of the product, end users expect a certain quality of service. They want the application to be accessible at any given time, load quickly, and return correct data. While you can use support tickets or incident pages to gauge customer dissatisfaction, you should not rely solely on them for making product decisions because they do not fully capture the end-user experience. For example, resolving all trouble tickets does not necessarily mean you have met the service level expected by your end users.

Achieving 100% reliability at all times is practically impossible. SLOs help you find the right balance between product innovation (which adds more value to your end users but risks disruption) and reliability (which keeps these users satisfied). Your error budget determines the extent of unreliability that development work can afford before your end users encounter a decline in service quality.

#### Developers and Operations Engineers
Traditionally, developers and operations engineers have been at odds due to their opposing goals and responsibilities: developers aim to add more functionality to their services, while operations engineers are responsible for maintaining the stability of these services. SLOs not only drive positive business outcomes but also foster a cultural shift where both development and operations teams share a common sense of responsibility for their application's reliability.

With SLOs and their associated error budgets, teams can objectively decide which projects or initiatives to prioritize. As long as there is remaining error budget, developers can release new features to improve the overall product quality, while operations engineers can focus more on long-term reliability projects such as database maintenance and process automation. However, when the error budget starts to run out, developers will need to slow down or freeze feature work and collaborate closely with the operations team to stabilize the system before violating any SLAs or SLOs. In short, the error budget provides a quantifiable method to align the work and goals of developers and operations engineers.

### From SLI to SLO

Now that we've defined some key concepts related to SLOs, it's time to consider how to create them. Understanding how your users experience your product—and which user journeys are most important—is the first and most crucial step in creating useful SLOs. Here are some questions you should consider:

- [x] How do your users interact with your application?
- [x] What are their journeys through the application?
- [x] Which parts of your infrastructure do these journeys interact with?
- [x] What do they expect from your system, and what do they hope to accomplish?

In this series, assume you work for an e-commerce company and consider how such a company would set up SLOs. You need to figure out how your customers interact with the website—and their path from first entering the site to exiting. At a basic level, your customers need to be able to log in, search for products, view detailed information about individual items, add items to the cart, and check out. These key user journeys are directly related to user experience, so setting SLOs is important.

After completing this exercise, you can move on to selecting metrics or SLIs to quantify the service levels you provide during these critical user journeys.

#### Choosing Good SLIs
As your infrastructure becomes more complex, setting external SLOs for each database, message queue, and load balancer becomes increasingly cumbersome. Instead, we recommend organizing your system components into a few major categories (e.g., response/request, storage, data pipelines) and specifying SLIs within each category.

When you start choosing SLIs, remember a brief but important statement: “**All SLIs are metrics, but not all metrics make good SLIs.**” This means that while you might track hundreds or thousands of metrics, you should focus on the most critical ones: those that best capture the user experience.

You can use the table below (from Google’s SRE book) as a reference.

![image.png](../images/opentelemetry-observable-1.png)

Now, imagine a shopper stuck on the checkout page, waiting for a slow payment endpoint to return a response. The longer they wait, the more likely they are to form a negative impression of your business. Besides reputational damage, abandoned shopping carts can have costly consequences. In fact, some of the largest and most successful organizations have found that every second of delay correlates with a significant reduction in revenue. From this example, we see that response latency is a particularly important SLI for online retailers to track to ensure their customers can complete critical business transactions quickly.

Contrast this with a metric that almost certainly would never make a good SLI: CPU utilization. Even if your servers are experiencing spikes in CPU usage—and your infrastructure team receives more frequent alerts about high usage—your end users may still be able to check out seamlessly. The point here is that no matter how important a metric is to your internal teams, if its value does not directly impact user satisfaction, it is not useful as an SLI.

Once you identify good SLIs, you need to use data from your monitoring system to measure them. Again, we recommend extracting data from components closest to the user. For example, you can use the payment API to accept and authorize credit card transactions as part of the checkout service. Although many other internal components may constitute this service (e.g., servers, background job processors), they are usually abstracted away from the user’s view. Since SLIs are used to quantify the end-user experience, collecting data solely from the payment endpoint is sufficient as it exposes functionality to the user.

#### Converting SLIs to SLOs
Finally, you need to set target values (or ranges) for your SLIs to convert them into SLOs. You should specify your best-case and worst-case criteria—and how long those conditions should hold true. For example, an SLO tracking request latency might be “over 30 days, 99% of authentication service requests will have a latency of less than 250 milliseconds.”

When starting to create SLOs, keep the following points in mind.

**Be Realistic**
No matter how tempting it is to set SLOs at 100%, it is practically impossible to achieve in practice. Without considering the error budget, your development team may become overly cautious when trying new features, stifling your product’s growth. Typical industry standards set SLO targets at multiple nines (e.g., 99.9% is called “three nines,” 99.95% is called “three-and-a-half nines”).

As a general rule of thumb, your SLOs should be stricter than what you detail in your SLAs. It’s always better to err on the side of caution to ensure you meet your SLAs rather than consistently under-delivering.

**Experiment**
There are no hard and fast rules for perfecting SLOs. Each organization’s SLOs will vary based on the nature of the product, the priorities of the teams managing them, and the expectations of end users. Remember, you can always continue to optimize targets until you find the optimal values. For instance, if your team consistently exceeds targets by a wide margin, you might want to tighten these values or leverage unused error budget by investing more in product development. Conversely, if your team consistently fails to meet its targets, lowering them to more achievable levels or dedicating more time to stabilizing the product might be wise.

**Don’t Overcomplicate It**
Lastly, resist the temptation to set too many SLOs or make SLI aggregations overly complex. Instead of setting separate SLIs for each cluster, host, or component that constitutes a critical journey, try to aggregate them meaningfully into single SLIs. Generally, you should limit SLOs and SLIs to only those that are critical to the end-user experience. This helps eliminate noise and allows you to focus on what truly matters.

### Now You Know Your SLOs
In this blog post, we explored how choosing the right SLIs and converting them into well-defined SLOs can put your organization on the path to success. By using SLIs to measure the level of service you provide to users—and tracking your performance against actual SLOs—you will be better equipped to make decisions that enhance both feature velocity and system reliability. We have summarized this guide into a simple checklist that you can refer to as you start creating SLOs and involving more team members.

Continue reading the [next part of this series](slo-part2.md) to learn how technical and business teams can collaborate more effectively using [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/) by managing SLOs and the rest of their monitoring data.