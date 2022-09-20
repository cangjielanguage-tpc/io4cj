
package okio

from std import sync.*


let reentrantMutex = ReentrantMutex()

public open class AsyncTimeout <: Timeout & Equatable<AsyncTimeout> { 
    static let TIMEOUT_WRITE_SIZE: Int64 = 64 * 1024;
    private var inQueue = false

    var head: ?AsyncTimeout = None
    var next: ?AsyncTimeout = None

    protected var fun: ?()->Unit = None

    public open func enter() {
        if (inQueue) {
            throw IllegalArgumentException("Unbalanced enter/exit")
        }
        var timeoutNanos: Int64 = timeoutNanos()
        var hasDeadline = hasDeadline();
        if (timeoutNanos == 0 && !hasDeadline) {
            return; // No timeout and no deadline? Don't bother with the queue.
        }
        inQueue = true;
        scheduleTimeout(this, timeoutNanos, hasDeadline);
    }


    protected open func scheduleTimeout(node: AsyncTimeout, timeoutNanos:Int64, hasDeadline:Bool):Unit {
        synchronized(reentrantMutex) {
            match (this.head) {
                case None => 
                    this.head = AsyncTimeout()
                    // TODO : 看门狗 
                case _ => ()
            }
            let now  =  Time.now().unixNano()

        }
    }

    public open func newTimeoutException(e: Exception): Exception {
        return InterruptedException("timeout ${e.toString()}")
    }

    public open func newTimeoutException(): Exception {
        return InterruptedException("timeout")
    }

    protected open func timedOut(): Unit{
        match (fun) {
            case None => ()
            case Some(v) => v()
        }
    }

    public func sink(sink: Sink): Sink {
        func subWrite(source: Buffer, byteCount: Int64): Unit {
            Util.checkOffsetAndCount(source.size, 0, byteCount)
            var byteCount = byteCount
            while (byteCount >0) {
                var toWrite = 0
                var s = source.head.getOrThrow()
                while (toWrite < AsyncTimeout.TIMEOUT_WRITE_SIZE) {
                    toWrite += (s.limit - s.pos)
                    if (toWrite >= byteCount) {
                        toWrite = byteCount
                        break
                    }
                    s = s.next.getOrThrow()
                }
                var throwOnTimeout = false

            }
        }
        func subFlush (): Unit {
            var throwOnTimeout = false
            enter()
            try {
                sink.flush()
                throwOnTimeout = true
            } catch (e: Exception) {
                throw exit(e);
            } finally {
                exit(throwOnTimeout);
            }
        }
        func subTimeout (): Timeout {
            return this
        }
        let asink = AnonymousSink()
        asink.funWrite = subWrite
        asink.funFlush = subFlush
        asink.funTimeout = subTimeout
        return asink
    }

    public func source(source: Source): Source {
        func subRead (sink: Buffer, byteCount: Int64): Int64 {
            var throwOnTimeout = false
            enter()
            try {
                let result = source.read(sink, byteCount)
                throwOnTimeout = true
                return result
            } catch (e:Exception) {
                throw exit(e)
            } finally {
                exit(throwOnTimeout)
            }
        }
        func subTimeout(): Timeout {
            return this
        }
        let source = AnonymousSource()
        source.funRead = subRead
        source.funTimeout = subTimeout
        return source
    }

    func exit(e: Exception): Exception {
        if (!exit()) {
            return e
        }
        return newTimeoutException(e)
    }
    func exit(throwOnTimeout: Bool) {
        if (exit() && throwOnTimeout) {
            throw newTimeoutException()
        }
    }

    public func exit() : Bool {
        if (!inQueue) {
            return false
        }
        inQueue = false
        return cancelScheduledTimeout(this)
    }

    private func cancelScheduledTimeout(node: AsyncTimeout): Bool {
        synchronized(reentrantMutex) {
            var node = node
            var prev = this.head
            while (true) {
                match (prev) {
                    case None => break
                    case Some(v) => 
                        if (v.next.getOrThrow() == node) {
                            v.next = node.next
                            node.next = None
                            return false
                        }
                }
            }
            return true
        }
    }

    public operator func == (that: AsyncTimeout): Bool {
        return refEq(this, that)
    }
    public operator func != (that: AsyncTimeout): Bool {
        return !refEq(this, that)
    }
}
