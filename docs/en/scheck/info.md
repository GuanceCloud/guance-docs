# What is Scheck

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57

In the process of operations and maintenance, one of the most important tasks is to inspect the status of systems, software, logs, etc. Traditional solutions often involve engineers writing shell (bash) scripts to perform similar tasks and using remote script management tools to manage clusters. However, this method can be very risky. System inspection operations often require high-level permissions, typically running with root privileges. If a malicious script is executed, the consequences can be catastrophic. There are two types of malicious scripts in practice: one type involves harmful commands, such as `rm -rf`, and the other involves data theft, such as leaking data via network I/O.

Therefore, Security Checker aims to provide a new, secure scripting method (limiting command execution, restricting local I/O, and restricting network I/O) to ensure all actions are safe and controllable. Security Checker will collect inspection events through unified network models in a logging manner. Additionally, Security Checker will provide a vast, updatable library of rule-based scripts for system, container, network, security, and other inspections. Scheck is the abbreviation for Security Checker.