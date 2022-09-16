package okio

from std import time.*

class RealBufferedSink <: BufferedSink {

    public let buf: okio.Buffer = Buffer()

    public let sink: Sink

    var closed: Bool = false

    init (sink: Sink){
        this.sink = sink
    }

    public func buffer (): Buffer {
        return this.buf
    }

    public override func write(byteString: ByteString): BufferedSink {
        if (this.closed) {
            throw IllegalArgumentException("closed.")
        }
        this.buf.write(byteString)
        return emitCompleteSegments()
    }

    public override func write(source: Source, byteCount: Int64): BufferedSink {
        var byteCount = byteCount
        while (byteCount > 0) {
            let read = source.read(this.buf, byteCount)
            if (read == -1) {
                throw EOFException()
            }
            byteCount -= read
            emitCompleteSegments()
        }
        return this
    }

    public override func writeAll(source: Source): Int64 {
        var totalBytesRead = 0
        var readCount = source.read(this.buf, Segment.SIZE)
        while (readCount != -1) {
            totalBytesRead += readCount
            emitCompleteSegments()
            readCount = source.read(this.buf, Segment.SIZE)
        }
        return totalBytesRead
    } 
    public override func writeUtf8(string: String): BufferedSink {
        this.buf.writeUtf8(string)
        return emitCompleteSegments()
    }

    public override func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink {
        this.buf.writeUtf8(string, beginIndex, endIndex)
        return emitCompleteSegments()
    }

    public override func writeUtf8CodePoint(codePoInt64: Int64): BufferedSink {
        this.buf.writeUtf8CodePoint(codePoInt64)
        return emitCompleteSegments()
    }

    public override func writeInt8(value: Int64): BufferedSink {
        this.buf.writeInt8(value)
        return emitCompleteSegments()
    }

    public override func writeInt16(value: Int64): BufferedSink {
        this.buf.writeInt16(value)
        return emitCompleteSegments()
    }

    public override func writeInt16Le(value: Int64): BufferedSink {
        this.buf.writeInt16Le(value)
        return emitCompleteSegments()
    }

    public override func writeInt32(value: Int64): BufferedSink {
        this.buf.writeInt32(value)
        return emitCompleteSegments()
    }

    public override func writeInt32Le(value: Int64): BufferedSink {
        this.buf.writeInt32Le(value)
        return emitCompleteSegments()
    }

    public override func writeInt64(value: Int64): BufferedSink {
        this.buf.writeInt64(value)
        return emitCompleteSegments()
    }

    public override func writeInt64Le(value: Int64): BufferedSink {
        this.buf.writeInt64Le(value)
        return emitCompleteSegments()
    }

    public override func writeDecimalInt64(value: Int64): BufferedSink {
        this.buf.writeDecimalInt64(value)
        return emitCompleteSegments()
    }

    public override func writeHexadecimalUInt64(value: Int64): BufferedSink {
        this.buf.writeHexadecimalUInt64(value)
        return emitCompleteSegments()
    }

    public override func flush(): Unit {
        if (this.closed) {
            throw IllegalArgumentException("closed")
        }
        if (this.buf.size > 0) {
            this.sink.write(this.buf, this.buf.size)
        }
        sink.flush()
    }

    public override func emit(): BufferedSink {
        let byteCount = this.buf.size
        if (byteCount > 0) {
            this.sink.write(this.buf, byteCount)
        }
        return this
    }

    public override func close(): Unit {
        if (this.closed) {
            return
        }
        var thrown: ?Exception = None
        try {
            if (this.buf.size >0) {
                this.write(this.buf, this.buf.size)
            }
        } catch (e:Exception) {
            thrown = e
        }
        try {
            this.sink.close()
        } catch (e: Exception){
            match (thrown) {
                case None => thrown = e
                case Some(v) => () 
            }
        }
        this.closed = true
        match (thrown) {
            case None => ()
            case Some(v) => throw v
        }
    } 

    public override func timeout(): Timeout {
        return this.sink.timeout()
    }

    public override func write(source: Buffer, byteCount: Int64): Unit {
        this.sink.write(source, byteCount)
        emitCompleteSegments()
    }

    public override func isClosed():Bool {false}

    public override func emitCompleteSegments(): BufferedSink {
        if (this.closed) {
            throw IllegalArgumentException("closed.")
        }
        var byteCount = this.buf.completeSegmentByteCount()
        if (byteCount > 0) {
            this.sink.write(this.buf, byteCount)
        }
        return this
    }

    
}


