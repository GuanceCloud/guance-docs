# SLO from Methodology to Practice: Part 1 Establishing Effective SLOs

---

In recent years, organizations have increasingly adopted Service Level Objectives (SLOs) as a fundamental part of their Site Reliability Engineering (SRE) practices. Google pioneered best practices around SLOs—Google's SRE books provide an excellent introduction to the concept. At its core, SLOs are rooted in the idea that service reliability and user satisfaction should go hand in hand. Setting specific and measurable reliability goals helps organizations strike the right balance between product development and operational efforts, ultimately leading to a positive end-user experience.

We will explore SLOs through three parts:

[SLO from Methodology to Practice: Part 1 Establishing Effective SLOs](slo-part1.md)

[SLO from Methodology to Practice: Part 2 Selecting SLO Tools](slo-part2.md)

[SLO from Methodology to Practice: Part 3 Best Practices for Managing SLOs with Guance](slo-part3.md)

## Key Terminology
Before we proceed, let’s break down some key terms that will be used throughout this series:

- **Service Level Indicator (SLI)** is a metric used to measure the level of service provided to the end user (e.g., availability, latency, throughput).
- **Service Level Objective (SLO)** is the target service level, measured by SLIs. They are typically expressed as a percentage over a given period.
- **Service Level Agreement (SLA)** is a contractual agreement outlining the level of service that end users can expect from a service provider. If these commitments are not met, providers may face significant consequences, often financial (e.g., service credits, subscription extensions).
- **Error Budget** is the acceptable level of unreliability before a service fails to meet its SLO. In short, it is the difference between 100% reliability and the SLO target. You can think of the error budget like a financial budget—but in this case, developers use it for building new features, redesigning system architecture, or any other product development work.

### Who Benefits from SLOs?
To get buy-in from key stakeholders across the organization, you need them to agree on realistic reliability goals, considering business priorities and the projects they wish to undertake. In this section, we’ll delve into what matters to end users, developers, and operations engineers, and how we should consider their goals and priorities when setting SLOs.

#### End Users
Regardless of the product, end users have expectations about the quality of service they receive. They expect applications to be accessible at any given time, load quickly, and return correct data. While support tickets or incident pages can gauge customer dissatisfaction, you shouldn’t rely solely on them for product decisions because they don’t fully capture the end-user experience. For example, resolving all incidents doesn’t necessarily mean you’ve met the expected service level for your end users.

Achieving 100% reliability all the time is impossible. SLOs help you find the right balance between product innovation (which can add more value for end users but risk breaking things) and reliability (which keeps those users satisfied). Your error budget determines how much unreliability your development work can afford before your end users start experiencing a decline in service quality.

#### Developers and Operations Engineers
Traditionally, there has been a divide between developers and operations engineers due to their opposing goals and responsibilities: developers aim to add more functionality to their services, while operations engineers are responsible for maintaining the stability of those services. SLOs not only drive positive business outcomes but also foster a cultural shift, creating a shared sense of responsibility for application reliability between development and operations teams.

With SLOs and their accompanying error budgets, teams can objectively decide which projects or initiatives to prioritize. As long as there is remaining error budget, developers can release new features to improve overall product quality, while operations engineers can focus on long-term reliability projects such as database maintenance and process automation. However, when the error budget starts running out, developers will need to slow down or freeze feature work and collaborate closely with the operations team to stabilize the system before violating any SLAs or SLOs. In short, the error budget is a quantifiable method to align the work and goals of developers and operations engineers.

### From SLI to SLO

Now that we’ve defined some key concepts related to SLOs, it’s time to consider how to create them. Understanding how your users experience your product—and which user journeys are most important—is the first and most crucial step in creating useful SLOs. Here are a few questions to consider:

- [x] How do your users interact with your application?
- [x] What are their journeys through the application?
- [x] Which parts of your infrastructure do these journeys interact with?
- [x] What do they expect from your system, and what do they want to accomplish?

For the purposes of this series, assume you work in an e-commerce company and consider how such a business would set up SLOs. You need to figure out how your customers interact with the website—and their path from first entering the site to exiting. At a basic level, your customers need to be able to log in, search for products, view detailed information about individual products, add items to their cart, and check out. These critical user journeys are directly related to user experience, so setting SLOs is important.

After completing this exercise, you can move on to selecting metrics or SLIs to quantify the service levels you provide during these critical user journeys.

#### Choosing Good SLIs
As your infrastructure becomes more complex, setting external SLOs for each database, message queue, and load balancer becomes increasingly cumbersome. Instead, we recommend organizing your system components into several major categories (e.g., response/request, storage, data pipelines) and specifying SLIs within each category.

When you start choosing SLIs, remember the brief but important saying: “**All SLIs are metrics, but not all metrics make good SLIs.**” This means that while you might track hundreds or thousands of metrics, you should focus on the most important ones: those that best capture the user experience.

You can use the following table (from Google’s SRE books) as a reference.

![image.png](../images/opentelemetry-observable-1.png)

Now, imagine your shoppers are stuck on the checkout page, waiting for a slow payment endpoint to return a response. The longer they wait, the more likely they are to form a negative impression of your business. Besides reputational damage, abandoned shopping carts can have costly consequences. In fact, some of the largest and most successful organizations have found that every second of delay correlates with a significant reduction in revenue. From this example, we see that response latency is a particularly important SLI for online retailers to track to ensure their customers can quickly complete critical business transactions.

Contrast this with a metric that almost certainly would never make a good SLI: CPU utilization. Even if your servers are experiencing spikes in CPU usage—and your infrastructure team is receiving more frequent alerts about high usage—your end users may still be able to check out seamlessly. The point here is that no matter how important a metric is to your internal teams, if its value doesn’t directly impact user satisfaction, it isn’t useful as an SLI.

Once you’ve identified good SLIs, you need to use data from your monitoring systems to measure them. Again, we recommend extracting data from components closest to the user. For example, you can use the payment API to accept and authorize credit card transactions as part of the checkout service. Although many other internal components may constitute this service (e.g., servers, background job processors), they are usually abstracted away from the user’s view. Since SLIs are used to quantify the end-user experience, collecting data solely from the payment endpoint is sufficient because it exposes functionality to the user.

#### Converting SLIs to SLOs
Finally, you need to set target values (or ranges) for your SLIs to convert them into SLOs. You should specify what your best-case and worst-case criteria are—and how long that condition should hold true. For example, an SLO tracking request latency might be “over 30 days, 99% of authentication service requests will have a latency of less than 250 milliseconds.”

When starting to create SLOs, keep the following points in mind.

**Be Realistic**
No matter how tempting it is to set SLOs at 100%, achieving this in practice is virtually impossible. Without considering the error budget, your development team might become overly cautious when trying new features, stifling product growth. A typical industry standard is to set SLO targets at multiple nines (e.g., 99.9% is called “three nines,” 99.95% is called “three-and-a-half nines”).

As a general rule of thumb, your SLOs should be stricter than what you detail in your SLAs. It’s always better to err on the side of caution to ensure you meet your SLAs rather than consistently under-delivering.

**Experiment**
There are no hard and fast rules for perfecting SLOs. Each organization’s SLOs will vary based on the nature of the product, the priorities of the teams managing them, and the expectations of the end users. Remember, you can always continue optimizing the targets until you find the optimal values. For instance, if your team consistently exceeds targets by a wide margin, you might want to tighten these values or leverage unused error budget by investing more in product development. However, if your team continually fails to meet its targets, lowering them to more achievable levels or dedicating more time to stabilizing the product might be wise.

**Keep It Simple**
Lastly, resist the temptation to set too many SLOs or make SLI aggregation overly complex when defining SLO targets. Instead of setting separate SLIs for each cluster, host, or component that constitutes a critical journey, try aggregating them meaningfully into a single SLI. Generally, you should limit SLOs and SLIs to those that are critical to the end-user experience. This helps reduce noise and allows you to focus on what truly matters.

### Now You Know Your SLOs
In this blog post, we explored how selecting the right SLIs and converting them into well-defined SLOs can put your organization on the path to success. By using SLIs to measure the service levels you provide to users—and tracking your performance against actual SLOs—you will be better equipped to make decisions that enhance both feature velocity and system reliability. We have summarized this guide into a simple checklist that you can refer to as you begin creating SLOs and involving more team members.

Continue reading the [next part](slo-part2.md) of this series to learn how technical and business teams can use [Guance](https://guance.com/) to collaborate more effectively by managing SLOs and the rest of their monitoring data.