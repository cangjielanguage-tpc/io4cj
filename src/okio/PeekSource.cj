
package okio

class PeekSource <: Source {

    var closed: Bool = false
    var pos: Int64 = 0
    var expectedPos: Int64 = 0
    var expectedSegment: ?Segment
    var buffer: Buffer
    var upstream: BufferedSource

    init (upstream: BufferedSource) {
        this.upstream = upstream
        this.buffer = upstream.getBuffer()
        this.expectedSegment = buffer.head
        this.expectedPos = match (buffer.head) {
            case None => -1
            case Some(v) => v.pos
        }
    }

    public func read(sink: Buffer, byteCount: Int64): Int64 {
        if (byteCount < 0) {
            throw IllegalArgumentException("byteCount < 0: ${byteCount}")
        }
        if (this.closed) {
            throw IllegalArgumentException("closed")
        }
        if (this.expectedSegment.getOrThrow() != this.buffer.head.getOrThrow() || this.expectedPos != this.buffer.head.getOrThrow().pos) {
            throw IllegalArgumentException("Peek source is invalid because upstream source was used")
        }
        if (byteCount == 0) {
            return 0
        }
        match ((this.expectedSegment, this.buffer.head)) {
            case (None, Some(v)) =>
                this.expectedSegment = v
                this.expectedPos = v.pos
            case _ => ()
        }
        let toCopy = min(byteCount, buffer.size - this.pos)
        this.buffer.copyTo(sink, this.pos, toCopy)
        this.pos += toCopy
        return toCopy

    }
    public func close(): Unit {
        this.closed = true
    }
    public func timeout(): Timeout {
        return Timeout()  // TODO
    }

    public func isClosed(): Bool {
        return this.closed
    }
}