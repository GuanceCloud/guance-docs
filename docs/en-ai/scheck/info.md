# What is Scheck

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57

In operations and maintenance processes, one of the most important tasks is to inspect the status of systems, software, logs, and other elements. Traditional solutions often involve engineers writing shell (bash) scripts to perform these tasks and using remote script management tools for cluster management. However, this method is actually very risky due to the excessive permissions required for system inspection operations, which are often run with root privileges. If a malicious script is executed, the consequences can be catastrophic. In practice, there are two types of malicious scripts: one type involves malicious commands, such as `rm -rf`, and the other involves data theft, such as leaking data through network I/O.

Therefore, Security Checker aims to provide a new type of secure scripting method (limiting command execution, restricting local I/O, and restricting network I/O) to ensure all actions are safe and controllable. Security Checker will collect inspection events via unified network models in log format. Additionally, Security Checker will offer a vast, updatable repository of scripts for inspections, including those for systems, containers, networks, security, and more. Scheck is the abbreviation for Security Checker.