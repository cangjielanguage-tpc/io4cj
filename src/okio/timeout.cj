package okio

from std import time.*
from std import sync.*

public open class Timeout <: Object {

    private var hasdeadline: ?Bool = None
    private var deadlinenanotime: ?Int64 = None
    private var timeoutnanos: ?Int64 = None
    
    public init() {}

    public open func timeout(timeout: Int64): Timeout {
        if (timeout < 0) {
            throw  IllegalArgumentException("timeout < 0: ${timeout}")
        }
        this.timeoutnanos = Duration.nanosecond(timeout).nanoseconds()
        return this
    }

    public open func timeoutNanos(): Int64 {
        return timeoutnanos.getOrThrow()
    }

    public open func hasDeadline(): Bool {
        return hasdeadline.getOrThrow()
    }

    public open func deadlineNanoTime(): Int64 {
        if (!hasdeadline.getOrThrow()) {
            throw IllegalArgumentException("No deadline")
        }
        return deadlinenanotime.getOrThrow()
    }

    public open func deadlineNanoTime(deadlineNanoTime: Int64): Timeout {
        this.hasdeadline = true
        this.deadlinenanotime = deadlineNanoTime
        return this
    }

    public func deadline(duration: Duration, timeout: Int64) : Timeout {
        if (timeout < 0) {
            throw IllegalArgumentException("duration <= 0: ${duration}")
        }
        (Duration.nanosecond(timeout) + duration).nanoseconds()
        return deadlineNanoTime(123)
    }

    public open func clearTimeout(): Timeout {
        this.timeoutnanos = 0
        return this
    }

    public open func clearDeadline(): Timeout {
        this.hasdeadline = false
        return this
    }

    public open func throwIfReached() {
        if (this.hasdeadline.getOrThrow() && this.deadlinenanotime.getOrThrow() - Time.now().unixNano() <= 0) {
            throw InterruptedIOException("deadline reached");
        }
    }

    public func waitUntilNotified(monitor: Monitor) {
        try {
            var hasDeadline = hasDeadline()
            var timeoutNanos = timeoutNanos()
            if (!hasDeadline && timeoutNanos == 0) {
                monitor.wait()
                return
            }

            var start: Int64 = Time.now().unixNano()
            let waitNanos: Int64 = if (hasDeadline && timeoutNanos != 0) {
                let deadlineNanos = deadlineNanoTime() - start
                math.min(deadlineNanos, timeoutNanos)
            } else if (hasDeadline) {
                deadlineNanoTime() - start
            } else {
                timeoutNanos
            }
            var elapsedNanos: Int64 = 0
            if(waitNanos > 0) {
                var waitMillis: Int64 = waitNanos / 1000000
                let nanos = waitNanos - waitMillis * 1000000
                if (waitMillis < 0) {
                    throw IllegalArgumentException("timeoutMillis value is negative")
                }
                if (nanos < 0 || nanos > 999999) {
                    throw IllegalArgumentException("unixNano timeout value out of range")
                }
                if (nanos > 0) {
                    waitMillis++
                }
                monitor.wait(timeout: UInt64(waitMillis))
                elapsedNanos = Time.now().unixNano() - start
            }

            if (elapsedNanos >= waitNanos) {
                throw IOException("timeout")
            }
        } catch (e: Exception) {
            throw IOException("interrupted")
        }
    }

    static func minTimeout(aNanos: Int64, bNanos: Int64): Int64 {
        if (aNanos == 0) {
            return bNanos
        }
        if (bNanos == 0) {
            return aNanos
        }
        if (aNanos < bNanos) {
            return aNanos
        }
        return bNanos
    }
}

