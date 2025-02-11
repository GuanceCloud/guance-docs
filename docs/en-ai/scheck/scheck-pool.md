# Scheck Concurrency Strategy
--- 

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Implementing Lua Script Scheduling with a Thread Pool and Task Queue:

Originally, each Lua proto corresponded to a Lua.state object, and each state object would load common libraries and shared data. Each Lua proto had a corresponding timer during runtime, leading to many Lua scripts running in clusters and consuming excessive memory due to the large number of state objects.

Therefore, the following optimizations were made:
- A Lua.state pool was created, from which a state object is retrieved when needed and returned after use.
- The thread pool size is dynamic, ensuring sufficient state objects are available for concurrent task execution.
- All timers were removed and replaced with interval-based execution because the Lua scripts run by Scheck do not require high real-time performance; some delay in execution time is acceptable.

## Thread Pool:

A Lua.state is the smallest unit for running Lua proto and can be referred to as a Lua virtual machine. The thread pool consists of multiple Lua.states.
- When retrieving a state object from the pool, it will be obtained from the pool if available.
- If none are available in the pool but the running count has not reached the maximum allowed capacity (cap), a new state object is created and recycled upon completion of its call.
- State objects in the pool are immediately reclaimed after use.
- There is an initial size and a maximum capacity, allowing for peak running counts.

## Task Queue:

- The Lua execution intervals are unified into a queue of intervals.
- The task queue is traversed to retrieve the task closest to the current time. If the task's scheduled time has already passed, it runs immediately.
- If there is still time remaining before the task's scheduled time, a timer is set to trigger the task when the time arrives.
- When a task runs, it requires a state to execute the Lua proto, which must be retrieved from the thread pool. If no state is available in the pool and the total running count has reached the configured peak, the task enters a waiting state until another task completes and returns a state.