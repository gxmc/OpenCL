在 `OpenCL 编程实践`中，为了比较 CPU 和 GPU 的性能，前面统计函数的执行时间使用了 `glibc` 中提供的时钟和时间相关函数。为了测得到 `func` 函数的执行时间，在待测函数执行前，首先通过调用 system_time() 得到当前的时间戳 `time_start`，接着执行 `func` 函数，待其执行完后再次调用 system_time() 得到当前时间戳 `time_end`，使用 time_end 减去 time_start 就可以得到函数 `func` 的执行时间。下面是封装后的 system_time() 函数：
```c
int64_t system_time()
{
	struct timespec t;

	clock_gettime(CLOCK_MONOTONIC, &t);
	return (int64_t)(t.tv_sec) * 1e9 + t.tv_nsec;
}
```

函数 clock_gettime() 的原型如下：
```c
int clock_gettime(clockid_t clk_id, struct timespec *tp);

struct timespec {
	time_t   tv_sec;        /* seconds */
	long     tv_nsec;       /* nanoseconds */
};
```

参数描述如下：

- clk_id：表示时钟类型。CLOCK_MONOTONIC 为单调递增时钟，在系统启动后开始计时，其时间不能手动的被重新设置。在 Linux 系统中，CLOCK_MONOTONIC 通过高精度定时器实现，使用 hrtimer_init() 来初始化；
- tp：指向结构体 timespec 的指针，返回当前的时间戳信息。

在 Linux 系统中，内核版本从 `Linux 2.6.28 开始`，支持另一个时钟 CLOCK_BOOTTIME。该时钟和 CLOCK_MONOTONIC 比较类似，但是它包含了系统在休眠过程中的时间，这在记录时间戳信息中需要包含时间非常有用。相关时钟的精度可通过 clock_getres() 函数调用获取，其原型如下：
```c
int clock_getres(clockid_t clk_id, struct timespec *res);
```
下面是参数描述：

- clk_id：表示对应时钟的类型；
- res：返回该时钟的精度，以纳秒为单位。