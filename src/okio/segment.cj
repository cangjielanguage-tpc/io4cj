package okio

// 缓冲区的一段。
public class Segment <: Object & Equatable<Segment> {
    static let SIZE = 8192
    static let SHARE_MINIMUM = 1024
    let data: Array<Byte>
    var pos: Int64
    var limit: Int64
    var shared: Bool
    var owner: Bool
    var next: ?Segment = Option.None
    var prev: ?Segment = Option.None

    public init() {
        this(Array<UInt8>(SIZE, item: 0), 0, 0, false, true)
    }

    public init(data: Array<UInt8>, pos: Int64, limit: Int64, shared: Bool, owner: Bool) {
        this.data = data
        this.pos = pos
        this.limit = limit
        this.shared = shared
        this.owner = owner
    }

    func sharedCopy(): Segment {
        shared = true
        return Segment(data, 0, 0, true, false)
    }

    func unsharedCopy(): Segment {
        shared = true
        return Segment(data.clone(), 0, 0, true, false)
    }

    public func push(segment: Segment): Segment {
        segment.prev = this
        segment.next = next
        next?.prev = segment
        next = segment
        return segment
    }

    public func pop(): ?Segment {
        let nextA = next.getOrThrow()
        let result: ?Segment = if (nextA != this) {
            next
        } else {
            None
        }
        prev?.next = next
        next?.prev = prev
        next = None
        prev = None
        return result
    }

    /*
       将循环链表的头拆分为两段。
       第一段包含 [pos..pos+byteCount）中的数据,
       第二段包含 [pos+byteCount..limit] 中的数据,
       将部分段从一个缓冲区移动到另一个缓冲区时非常有用。
     */
    public func split(byteCount: Int64): Segment {
        if (byteCount <= 0 || byteCount > limit - pos) {
            throw IllegalArgumentException()
        }
        var prefix: Segment
        if (byteCount >= SHARE_MINIMUM) {
            prefix = sharedCopy()
        } else {
            prefix = SegmentPool.take()
            data.copyTo(prefix.data, 0, 0, byteCount)
        }
        prefix.limit = prefix.pos + byteCount
        pos += byteCount
        prev?.push(prefix)
        return prefix
    }

    public func compact() {
        match (prev) {
            case Some(seg) => doCompact(seg)
            case None => 1
        }
    }

    func doCompact(prev: Segment) {
        if (!prev.owner) {
            return
        }
        let byteCount = limit - pos
        let availableByteCount = SIZE - prev.limit + (if (prev.shared) {
            0
        } else {
            prev.pos
        })
        if (byteCount > availableByteCount) {
            return
        }
        writeTo(prev, byteCount);
        pop();
        SegmentPool.recycle(this);
    }

    public func writeTo(sink: Segment, byteCount: Int64) {
        if (!sink.owner) {
            throw IllegalArgumentException()
        }
        if (sink.limit + byteCount > SIZE) {
            if (sink.shared) {
                throw IllegalArgumentException()
            }
            if (sink.limit + byteCount - sink.pos > SIZE) {
                throw IllegalArgumentException()
            }
            data.copyTo(sink.data, sink.pos, 0, sink.limit - sink.pos);
            sink.limit -= sink.pos
            sink.pos = 0
        }
        data.copyTo(sink.data, pos, sink.limit, byteCount);
        sink.limit += byteCount
        pos += byteCount
    }
    public operator func ==(that: Segment): Bool {
        return refEq(this, that)
    }
    public operator func !=(that: Segment): Bool {
        return !refEq(this, that)
    }
}
