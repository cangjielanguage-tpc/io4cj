package okio
from std import socket.Socket
from net import tls.TlsSocket

public class Okio {

    private init (){}


    public static func buffer(source: Source): BufferedSource {
        return RealBufferedSource(source)
    }

    public static func buffer(sink: Sink): BufferedSink {
        return RealBufferedSink(sink)
    }

    public static func sink(socket: Socket): Sink {
        let timeout = timeout(socket)
        let sink = sink(SocketBuffer(socket), timeout)
        return timeout.sink(sink)
    }

    public static func source(socket: Socket): Source {
        let timeout = timeout(socket)
        let source = source(SocketBuffer(socket), timeout)
        return timeout.source(source)
    }

    private static func source (input: InputStream, timeout: Timeout) : Source { 
        func subRead (sink: Buffer, byteCount: Int64): Int64 {
            if (byteCount < 0) {
                throw IllegalArgumentException("byteCount < 0")
            }
            if (byteCount == 0) {
                return 0
            }
            try {
                timeout.throwIfReached()
                let tail = sink.writableSegment(1)
                let maxToCopy = math.min(byteCount, Segment.SIZE - tail.limit)
                let bytesRead = input.read(tail.data[tail.limit.. tail.limit + maxToCopy])
                if (bytesRead == -1) {
                    if (tail.pos == tail.limit) {
                        sink.head = tail.pop()
                        SegmentPool.recycle(tail)
                    }
                    return -1
                }
                tail.limit += bytesRead
                sink.size += bytesRead
                return bytesRead
            } catch (e: Exception) {
                throw e
            }
        }
        func subTimeout(): Timeout {
            return timeout
        }
        let source = AnonymousSource()
        source.funRead = subRead
        source.funTimeout = subTimeout
        return source
    }

    private static func sink (out: OutputStream, timeout: Timeout) : Sink {
        func subWrite(source: Buffer, byteCount: Int64): Unit {
            Util.checkOffsetAndCount(source.size, 0, byteCount)
            var byteCount = byteCount
            while (byteCount > 0) {
                timeout.throwIfReached()
                var head = source.head.getOrThrow()
                var toCopy = math.min(byteCount, head.limit - head.pos)
                out.write(head.data[head.pos..head.pos+toCopy]) // TODO 
                head.pos += toCopy
                byteCount -= toCopy
                source.size -= toCopy
                if (head.pos == head.limit) {
                    source.head = head.pop()
                    SegmentPool.recycle(head)
                }
            }
        }
        func subFlush (): Unit {
            out.flush()
        }
        func subTimeout (): Timeout {
            return timeout
        }
        let sink = AnonymousSink()
        sink.funWrite = subWrite
        sink.funFlush = subFlush
        sink.funTimeout = subTimeout
        return sink
    }

    public static func timeout(socket: Socket): AsyncTimeout {
        func subtimeout (): Unit {
            try {
                socket.close()
            } catch (e: Exception) {
                println("123")  // TODO 
            } catch (e: Error) {
                println("45")  // TODO 
            } 
        }
        let ast = AsyncTimeout()
        ast.fun = subtimeout
        return ast
    }

    public static func timeout(socket: TlsSocket): AsyncTimeout {
        func subtimeout (): Unit {
            try {
                socket.close()
            } catch (e: Exception) {
                println("123")  // TODO 
            } catch (e: Error) {
                println("45")  // TODO 
            } 
        }
        let ast = AsyncTimeout()
        ast.fun = subtimeout
        return ast
    }


}

class AnonymousSource <: Source {
    var funRead: ?(Buffer, Int64)-> Int64 = None
    var funTimeout: ?()-> Timeout = None

    public override func close(): Unit { }

    public override func read(sink: Buffer, byteCount: Int64): Int64 {
        match (this.funRead) {
            case None => -1
            case Some(v) => v(sink, byteCount)
        }
    }

    public override func timeout(): Timeout {
        return this.funTimeout.getOrThrow()()
    }

    public override func isClosed(): Bool {false}
}


class AnonymousSink <: Sink {
    var funWrite: ?(Buffer, Int64)-> Unit = None
    var funFlush: ?()-> Unit = None
    var funTimeout: ?()-> Timeout = None

    public override func close(): Unit {}

    public override func flush(): Unit {
        match (this.funFlush) {
            case None => ()
            case Some(v) => v()
        }
    }

    public override func timeout(): Timeout {
        return this.funTimeout.getOrThrow()()
    }

    public override func write(source: Buffer, byteCount: Int64): Unit {
        match (this.funWrite) {
            case None => ()
            case Some(v) => v(source, byteCount)
        }
    }

    public override func isClosed(): Bool {false}
}
