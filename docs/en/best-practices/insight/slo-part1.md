# SLO from Methodology to Practice: Part 1 Establishing Effective SLOs

---

In recent years, organizations have increasingly adopted Service Level Objectives (SLOs) as a fundamental part of their Site Reliability Engineering (SRE) practices. Google pioneered best practices around SLOs — the Google SRE books provide an excellent introduction to this concept. At its core, SLOs are rooted in the idea that service reliability and user happiness should go hand in hand. Setting specific and measurable reliability goals helps organizations strike an appropriate balance between product development and operational work, ultimately leading to positive end-user experiences.

We will learn about SLOs in three parts:

[SLO from Methodology to Practice: Part 1 Establishing Effective SLOs](slo-part1.md)

[SLO from Methodology to Practice: Part 2 SLO Tool Selection](slo-part2.md)

[SLO from Methodology to Practice: Part 3 Best Practices for Managing SLOs with <<< custom_key.brand_name >>>](slo-part3.md)

## Key Terms
Before we proceed, let's first break down some key terms that will be used throughout this series:

- **Service Level Indicators (SLIs)** are metrics used to measure the level of service provided to end users (e.g., availability, latency, throughput).
- **Service Level Objectives (SLOs)** are target service levels, measured by SLIs. They are usually expressed as percentages over a given period.
- **Service Level Agreements (SLAs)** are contractual agreements outlining the level of service end users can expect from a service provider. If these commitments are not met, providers may face significant consequences, which are typically financial in nature (e.g., service credits, subscription extensions).
- **Error Budget** is the acceptable level of unreliability a service can have before it fails to meet its SLO. In short, they represent the difference between 100% reliability and the SLO target. You can think of error budgets like financial budgets—except developers use them to allocate resources toward building new features, redesigning system architectures, or any other product development work.

### Why Are Service Level Objectives Important?
To get buy-in from key stakeholders across the organization, you need them to agree on realistic reliability goals, taking into account business priorities and the projects they wish to undertake. In this section, we'll delve into what matters to end users, developers, and operations engineers, as well as how we should consider their goals and priorities when setting SLOs.

#### End Users
Regardless of the product, end users have expectations regarding the quality of service they receive. They expect the application to be accessible at any given time, load quickly, and return correct data. While you can use support tickets or incident pages to gauge customer dissatisfaction, you shouldn't solely rely on them to make product decisions because they don't fully capture the end-user experience. For example, resolving all trouble tickets doesn't necessarily mean you've achieved the service level your end users expect.

In reality, achieving 100% reliability all the time is impossible. SLOs help you find the right balance between product innovation (which will help you provide greater value to end users but risks breaking things) and reliability (which will satisfy these users). Your error budget determines the level of unreliability development work can withstand before your end users might encounter a drop in service quality.

#### Developers and Operations Engineers
Traditionally, the divide between developers and operations engineers stems from their opposing goals and responsibilities: developers aim to add more features to their services, while operations engineers are responsible for maintaining the stability of those services. SLOs not only drive positive business outcomes but also foster a cultural shift, creating a shared sense of responsibility for application reliability between development and operations teams.

With SLOs and their associated error budgets, teams can objectively decide which projects or initiatives to prioritize. As long as there is remaining error budget, developers can release new features to improve the overall product quality, while operations engineers can focus more on long-term reliability projects such as database maintenance and process automation. However, when the error budget starts to run out, developers will need to slow down or freeze feature work and closely collaborate with the operations team to restabilize the system before violating any SLAs or SLOs. In short, error budgets are a quantifiable way to align the work and goals of developers and operations engineers.


### From SLI to SLO

Now that we've defined some key concepts related to SLOs, it's time to start thinking about how to create them. Understanding how your users experience your product—and which user journeys are most important—is the first step, and the most crucial one, in creating useful SLOs. Here are a few questions you should consider:

- [x] How do your users interact with your application?
- [x] What are their journeys through the application?
- [x] Which parts of your infrastructure do these journeys interact with?
- [x] What do they expect from your system, and what do they want to accomplish?

Throughout this series, assume you work for an e-commerce business and consider how such a business might set SLOs. You need to figure out how your customers interact with the site—and their path from the moment they enter the site until they exit. At a basic level, your customers need to be able to log in, search for items, view detailed information about individual items, add items to their cart, and check out. These critical user journeys are directly tied to user experience, so setting SLOs is important.

After completing this exercise, you can move on to selecting metrics or SLIs to quantify the level of service you provide during these critical user journeys.

#### Selecting Good SLIs
As your infrastructure becomes more complex, setting external SLOs for each database, message queue, and load balancer becomes increasingly cumbersome. Instead, we recommend organizing your system components into a few major categories (e.g., response/request, storage, data pipelines) and specifying SLIs within each category.

When you begin selecting SLIs, remember a brief but important statement: “**All SLIs are metrics, but not all metrics are good SLIs.**” This means that while you may track hundreds or thousands of metrics, you should focus on the most important ones: those that best capture the user experience.

You can use the table below (from Google’s SRE book) as a reference.

![image.png](../images/opentelemetry-observable-1.png)

Now, imagine your shopper stuck on the checkout page, waiting for a slow payment endpoint to return a response. The longer they wait, the more likely they are to form a negative impression of your business. Besides damaged reputation, customers abandoning their carts can have costly consequences. In fact, some of the largest and most successful organizations have found that every second of delay correlates with a significant reduction in revenue. From this example, we can see that response latency is a particularly important SLI for online retailers to track to ensure their customers can quickly complete key business transactions.

Contrast this with a metric that almost certainly will never become a good SLI: CPU utilization. Even if your servers are experiencing a spike in CPU usage—and your infrastructure team receives alerts for high usage more frequently—your end users may still be able to check out seamlessly. The point here is that no matter how important a metric is to your internal teams, if its value does not directly impact user satisfaction, then it is useless as an SLI.

Once you identify good SLIs, you need to use data from your monitoring systems to measure them. Again, we recommend extracting data from the components closest to the user. For example, you could use a payment API to accept and authorize credit card transactions as part of the checkout service. Although many other internal components may constitute this service (e.g., servers, background job processors), they are usually abstracted away from the user's view. Since SLIs are used to quantify the end-user experience, collecting data solely from the payment endpoint is sufficient because it exposes functionality to the user.

#### Converting SLIs to SLOs
Finally, you need to set target values (or ranges) for your SLIs to convert them into SLOs. You should specify your best-case and worst-case criteria—and how long that condition should remain valid. For example, an SLO tracking request latency might be "Within 30 days, 99% of authentication service requests will have latency less than 250 milliseconds."

When you start creating SLOs, keep the following points in mind.

**Be Realistic**
No matter how tempting it is to set SLOs at 100%, it is practically impossible to achieve in real-world scenarios. Without considering error budgets, your development team may become overly cautious when trying out new features, stifling your product's growth. A typical industry standard is to set SLO targets at multiple nines (e.g., 99.9% is called "three nines," 99.95% is called "three-and-a-half nines").

As a general rule of thumb, your SLOs should be stricter than what you detail in your SLAs. It's always better to err on the side of caution to ensure you meet your SLAs rather than consistently under-deliver.

**Experiment**
There are no hard and fast rules for perfecting SLOs. Each organization's SLOs will vary based on the nature of the product, the priorities of the teams managing them, and the expectations of end users. Remember, you can always continue to optimize your targets until you find the optimal values. For instance, if your team consistently exceeds targets by a large margin, you may want to tighten these values or leverage unused error budgets by investing more in product development. However, if your team keeps failing to meet its targets, lowering them to more achievable levels or dedicating more time to stabilizing the product might be wise.

**Don’t Overcomplicate It**
Lastly, resist the temptation to set too many SLOs or overcomplicate SLI aggregation when defining SLO targets. Instead of setting separate SLIs for each cluster, host, or component that constitutes a critical journey, try aggregating them meaningfully into a single SLI. Generally, you should limit SLOs and SLIs to those that are critical to your end-user experience. This helps reduce noise and allows you to focus on what truly matters.

### Now You Know Your SLOs
In this blog post, we explored how choosing the right SLIs and converting them into clearly defined SLOs can put your organization on the path to success. By using SLIs to measure the level of service you provide to users—and tracking your performance against actual SLOs—you'll be better equipped to make decisions that enhance both feature velocity and system reliability. We’ve summarized this guide into a simple checklist that you can refer to as you begin creating SLOs and bringing more team members onboard.

Continue reading the [next part of the series](slo-part2.md) to learn how technical and business teams can collaborate more effectively using [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/) by managing SLOs and the rest of their monitoring data.