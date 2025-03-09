# Scheck Concurrency Strategy
--- 

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Implementing Lua Script Scheduling with a Thread Pool and Task Queue:

Originally, each Lua proto corresponded to one Lua.state object, and each state object would load common libraries and public data. Each Lua proto had a corresponding timer during runtime, leading to many Lua scripts running in clusters and consuming too much memory due to the numerous state objects.
Therefore, the following optimizations were made:
- A Lua.state pool was created from which a state is retrieved when needed and returned after use.
- The thread pool size is dynamic, ensuring sufficient state objects are available for concurrent task execution.
- All timers were removed and replaced with interval-based execution because the Lua scripts run by Scheck do not require high real-time performance, and some execution delays are acceptable.

## Thread Pool:

Lua.state is the smallest unit for running Lua proto and can also be referred to as a Lua virtual machine. The thread pool consists of multiple Lua.state objects.
- When retrieving a state object from the thread pool, it is taken from the pool if available.
- If none are available in the pool but the running count has not reached the maximum allowed capacity (cap), a new state object is created and recycled upon completion of the call.
- State objects in the pool are immediately reclaimed after use.
- There are initialization sizes and maximum capacities that allow for peak running counts.

## Task Queue:

- Lua execution times were unified into an interval-based queue.
- The task queue is traversed to retrieve the task closest to the current time; if it has already exceeded the current time, it runs immediately.
- If there is still time before the current time, a timer is set to trigger execution when the time arrives.
- During task execution, a state is required to run the Lua proto, which needs to be fetched from the thread pool. If none are available in the pool and the total running count has reached the configured peak, the task will enter a waiting state until another task completes and returns the state.