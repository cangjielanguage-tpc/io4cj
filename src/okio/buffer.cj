package okio

import nio.ArrayCopy

from std import math.*

// public class Buffer {

// }

public class Buffer <: Object &  BufferedSource & BufferedSink & Equatable<Buffer>  {

    static let DIGITS: Array<Byte> = [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f]
    
    var head: ?Segment = None 
    var size: Int64 = 0
    
    public init() {}

    func writableSegment (minimumCapacity: Int64): Segment {
        if (minimumCapacity < 1 || minimumCapacity > Segment.SIZE) {
            throw IllegalArgumentException()
        }
        match (this.head) {
            case None => 
                this.head = SegmentPool.take()
                this.head.getOrThrow().next = this.head
                this.head.getOrThrow().prev = this.head
                return this.head.getOrThrow()
            case Some(v) => 
                var tail = v.prev.getOrThrow()
                if (tail.limit + minimumCapacity > Segment.SIZE || !tail.owner) {
                    tail = tail.push(SegmentPool.take())
                }
                return tail
        }
    }

    public func getBuffer(): Buffer {
        return this
    }

    public func write(byteString: ByteString): BufferedSink {
        this
    }

    public func write(byteString: ByteString, offset: Int64, byteCount: Int64): BufferedSink {
        this
    }

    public func write(source: Array<Byte>, offset: Int64, byteCount: Int64): Int64 {
        0
    }

    public func writeAll(source: Source): Int64 {
        var totalBytesRead = 0
        var readCount: Int64 = 0
        while (readCount != -1) {
            totalBytesRead += readCount
            readCount = source.read(this, Segment.SIZE)
        }
        return totalBytesRead
    }

    public func write(source: Source, byteCount: Int64): BufferedSink {
        this
    }

    public func writeUtf8(string: String): BufferedSink {
        this
    }

    public func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink {
        this
    }

    public func writeUtf8CodePoInt64(codePoInt64: Int64): BufferedSink {
        this
    }

    public func writeInt8(value: Int8): BufferedSink {
        let tail = writableSegment(1)
        tail.data[tail.limit] = UInt8(value)
        tail.limit ++
        size += 1
        return this
    }

    public func writeInt16(i: Int16): BufferedSink {
        let tail = writableSegment(2)
        let data = tail.data
        var limit = tail.limit
        data[limit] = UInt8((UInt16(i) >> 8) & 0xff)
        limit++
        data[limit] = UInt8(UInt16(i) & 0xff)
        limit++
        tail.limit = limit
        size += 2
        return this
    }

    public func writeInt16Le(value: Int16): BufferedSink {
        return writeInt16(Util.reverseBytesInt16(value))
    }

    public func writeInt32(i: Int32): BufferedSink {
        let tail = writableSegment(4)
        let data = tail.data
        var limit = tail.limit
        data[limit] = UInt8((UInt32(i) >> 24) & 0xff)
        limit++
        data[limit] = UInt8((UInt32(i) >> 16) & 0xff)
        limit++
        data[limit] = UInt8((UInt32(i) >> 8) & 0xff)
        limit++
        data[limit] = UInt8(UInt32(i) & 0xff)
        limit++
        tail.limit = limit
        size += 4
        return this
    }

    public func writeInt32Le(value: Int32): BufferedSink {
        return writeInt32(Util.reverseBytesInt32(value))
    }

    public func writeInt64(i: Int64): BufferedSink {
        let tail = writableSegment(8)
        let data = tail.data
        var limit = tail.limit
        data[limit] = UInt8((UInt64(i) >> 56) & 0xff)
        limit++
        data[limit] = UInt8((UInt64(i) >> 48) & 0xff)
        limit++
        data[limit] = UInt8((UInt64(i) >> 40) & 0xff)
        limit++
        data[limit] = UInt8((UInt64(i) >> 32) & 0xff)
        limit++
        data[limit] = UInt8((UInt64(i) >> 24) & 0xff)
        limit++
        data[limit] = UInt8((UInt64(i) >> 16) & 0xff)
        limit++
        data[limit] = UInt8((UInt64(i) >> 8) & 0xff)
        limit++
        data[limit] = UInt8(UInt64(i) & 0xff)
        limit++
        tail.limit = limit
        size += 8
        return this
    }

    public func writeInt64Le(value: Int64): BufferedSink {
        return writeInt64(Util.reverseBytesInt64(value))
    }

    public func writeDecimalInt64(value: Int64): BufferedSink {
        this
    }

    public func writeHexadecimalUInt64(value: Int64): BufferedSink {
        this
    }

    public func flush(): Unit {

    }

    public func emit(): BufferedSink {
        this
    }

    public func exhausted(): Bool {
        return size == 0
    }

    public func require(byteCount: Int64): Unit {

    }

    public func request(byteCount: Int64): Bool {
        true
    }

    func readByte(): UInt8 {
        if (this.size == 0) {
            throw IllegalArgumentException(" size == 0")
        }
        let segment = this.head.getOrThrow()
        var pos = segment.pos
        var limit = segment.limit
        let data = segment.data
        var b = data[pos]
        pos++
        size -= 1
        if (pos == limit) {
            this.head = segment.pop()
            SegmentPool.recycle(segment)
        } else {
            segment.pos = pos
        }
        return b
    }

    public func readInt8(): Int8 {
        return Int8(readByte())
    }

    public func readInt16(): Int16 {
        if (this.size < 2) {
            throw IllegalArgumentException(" size < 2: ${size}")
        }
        let segment = this.head.getOrThrow()
        var pos = segment.pos
        var limit = segment.limit
        // If the short is split across multiple segments, delegate to readByte().
        if (limit - pos < 2) {
            return Int16(UInt16(readByte() & 0xff) << 8 | UInt16(readByte() & 0xff)) 
        }
        let data = segment.data
        var s = UInt16(data[pos] & 0xff) << 8
        pos ++
        s = s | UInt16(data[pos] & 0xff)
        pos ++
        size -= 2
        if (pos == limit ) {
            this.head = segment.pop()
            SegmentPool.recycle(segment)
        } else {
            segment.pos = pos
        }
        return Int16(s)
    }

    public func readInt16Le(): Int16 {
        return Util.reverseBytesInt16(readInt16())
    }

    public func readInt32(): Int32 {
        if (this.size < 4) {
            throw IllegalArgumentException(" size < 4: ${size}")
        }
        let segment = this.head.getOrThrow()
        var pos = segment.pos
        var limit = segment.limit
        // If the short is split across multiple segments, delegate to readByte().
        if (limit - pos < 4) {
            return Int32( UInt32(readByte() & 0xff) << 24
                        | UInt32(readByte() & 0xff) << 16 
                        | UInt32(readByte() & 0xff) << 8 
                        | UInt32(readByte() & 0xff)) 
        }
        let data = segment.data
        var s = UInt32(data[pos] & 0xff) << 24
        pos ++
        s = s | UInt32(data[pos] & 0xff) << 16
        pos ++
        s = s | UInt32(data[pos] & 0xff) << 8
        pos ++
        s = s | UInt32(data[pos] & 0xff)
        pos ++
        size -= 4
        if (pos == limit ) {
            this.head = segment.pop()
            SegmentPool.recycle(segment)
        } else {
            segment.pos = pos
        }
        return Int32(s)
    }

    public func readInt32Le(): Int32 {
        return Util.reverseBytesInt32(readInt32())
    }

    public func readInt64(): Int64 {
        if (this.size < 8) {
            throw IllegalArgumentException(" size < 8: ${size}")
        }
        let segment = this.head.getOrThrow()
        var pos = segment.pos
        var limit = segment.limit
        // If the short is split across multiple segments, delegate to readByte().
        if (limit - pos < 8) {
            return Int64( (UInt64(readInt32()) & 0xffffffff) << 32
                        | (UInt64(readInt32()) & 0xffffffff))
        }
        let data = segment.data
        var s: UInt64 = UInt64(data[pos] & 0xff) << 56
        pos ++
        s = s | UInt64(data[pos] & 0xff) << 48
        pos ++
        s = s | UInt64(data[pos] & 0xff) << 40
        pos ++
        s = s | UInt64(data[pos] & 0xff) << 32
        pos ++
        s = s | UInt64(data[pos] & 0xff) << 24
        pos ++
        s = s | UInt64(data[pos] & 0xff) << 16
        pos ++
        s = s | UInt64(data[pos] & 0xff) << 8
        pos ++
        s = s | UInt64(data[pos] & 0xff)
        pos ++
        size -= 8
        if (pos == limit) {
            this.head = segment.pop()
            SegmentPool.recycle(segment)
        } else {
            segment.pos = pos
        }
        return Int64(s)
    }

    public func readInt64Le(): Int64 {
        return Util.reverseBytesInt64(readInt64())
    }

    public func readDecimalInt64(): Int64 {
        if (this.size == 0) {
            throw IllegalArgumentException(" size == 0")
        }
        var value = 0
        var seen = 0
        var negative: Bool = false
        var done = false
        var overflowZone = Int64.Min / 10
        var overflowDigit = (Int64.Min % 10) + 1
        // TODO
        return 0
    }

    public func readHexadecimalUInt64(): Int64 {
        0
    }


    public func readByteString(): ByteString {
        ByteString(readByteArray())
    }

    public func readByteString(byteCount: Int64): ByteString {
        ByteString(readByteArray(byteCount))
    }

    public func readByteArray(): Array<Byte> {
        try {
            return readByteArray(this.size)
        } catch (e: AssertionException) {
            throw e
        }
    }


    public func readByteArray(byteCount: Int64): Array<Byte> {
        Util.checkOffsetAndCount(size, 0, byteCount) 
        if (byteCount > Int64(Int32.Max)) {
            throw IllegalArgumentException()
        }
        let result = Array<Byte>(byteCount, item:0)
        readFully(result)
        return result
    }

    public func read(sink: Array<Byte>): Int64 {
        0
    }
    public func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64 {
         Util.checkOffsetAndCount(sink.size, offset, byteCount)
        match (this.head) {
            case None => return -1
            case Some(v) =>
                let toCopy: Int64 = if (byteCount <= v.limit - v.pos) {
                    byteCount
                } else {
                    v.limit - v.pos
                }
                nio.ArrayCopy(v.data, v.pos, sink, offset, toCopy)
                v.pos += toCopy
                size -= toCopy
                if (v.pos == v.limit) {
                    this.head = v.pop()
                    SegmentPool.recycle(v);
                }
                return toCopy
        }
    }

    // @override Source
    public func read(sink: Buffer, byteCount: Int64): Int64 {
        0
    }

    public func readFully(sink: Array<Byte>): Unit {
        var offset = 0
        while (offset < sink.size) {
            let read = read(sink, offset, sink.size - offset)
            if (read == -1) {
                throw EOFException()
            }
            offset += read
        }
    }

    public func readFully(sink: Array<Byte>, byteCount: Int64): Unit {

    }

    public func readAll(sink: Sink): Int64 {
        0
    }

    public func readUtf8(): String {
        ""
    }

    public func readUtf8Line(): String {
        ""
    }

    public func readUtf8LineStrict(): String {
        ""
    }

    public func readUtf8LineStrict(limit: Int64): String {
        ""
    }

    public func readUtf8CodePoint(): Int64 {
        0
    }

    public func indexOf(value: Int8): Int64 {
        0
    }

    public func indexOf(value: Int8, fromIndex: Int64): Int64 {
        0
    }

    public func indexOf(value: Int8, fromIndex: Int64, toIndex: Int64): Int64 {
        0
    }

    public func indexOf(bytes: ByteString): Int64 {
        0
    }

    public func indexOf(bytes: ByteString, fromIndex: Int64): Int64 {
        0
    }

    public func indexOfElement(targetBytes: ByteString): Int64 {
        0
    }

    public func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64 {
        0
    }

    public func rangeEquals(offset: Int64, bytes: ByteString): Bool {
        true
    }

    public func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool {
        true
    }

    public func skip(byteCount: Int64): Unit {

    }

    public func peek(): BufferedSource {
        return Okio.buffer(PeekSource(this))
    }

//    public func seek(l: Int64, pos: SeekOrigin): Int64 {
//        0
//    }

    public func close(): Unit {

    }

    public func timeout(): Duration {
        Duration.second()
    }
    
    public func isClosed(): Bool {
        return true
    }

    @overflowWrapping
    public func hashCode(): Int64 {
        match (this.head) {
            case None => 
                return 0
            case Some(v) =>
                var result: Int64 = 1
                var s: Segment = v
                do {
                    for (pos in s.pos..s.limit) {
                        result = 31 * result + Int64(s.data[pos])
                    }
                    s = s.next.getOrThrow()
                } while (s != v)
                return result
        }
    }

    public func copyTo(out: Buffer, offset: Int64, byteCount: Int64): Buffer {
        Util.checkOffsetAndCount(size, offset, byteCount)
        var offset = offset
        var byteCount = byteCount
        if (byteCount == 0 ) {
            return this
        }
        out.size += byteCount
        var s = this.head.getOrThrow()
        while (offset >= s.limit - s.pos) {
            offset -= (s.limit - s.pos)
            s = s.next.getOrThrow()
        }

        while (byteCount > 0) {
            let copy: Segment = s.sharedCopy()
            copy.pos += offset
            copy.limit = min(copy.pos + byteCount, copy.limit)
            match (out.head) {
                case None => 
                    copy.next = copy
                    copy.prev = copy
                    out.head = copy
                case Some(v) =>
                    out.head.getOrThrow().prev.getOrThrow().push(v)
                    ()
                    
            }
            byteCount -= copy.limit - copy.pos
            offset = 0
        }
        return this
    }

    public func completeSegmentByteCount(): Int64 {
        var result = size
        if (result ==0) {
            return 0
        }
        var tail: Segment = this.head.getOrThrow().prev.getOrThrow()
        if (tail.limit < Segment.SIZE && tail.owner) {
            result -= tail.limit - tail.pos
        }
        return result
    }

    public func write(source: Buffer, byteCount: Int64): Unit {
        if (source == this) {
            throw IllegalArgumentException("source == this")
        }

        Util.checkOffsetAndCount(source.size, 0, byteCount)
        var byteCount = byteCount
        while (byteCount > 0) {
            if (byteCount < (source.head.getOrThrow().limit - source.head.getOrThrow().pos)) {
                let tail: ?Segment = match (head) {
                    case None => None
                    case Some(v) => v.prev
                }
                match (tail) {
                    case None => source.head = source.head.getOrThrow().split(byteCount)
                    case Some(v) =>
                        let temp = if (v.shared) {
                            0
                        } else {
                            v.pos
                        }
                        if (v.owner && byteCount + v.limit - temp <= Segment.SIZE) {
                            source.head.getOrThrow().writeTo(v, byteCount)
                            source.size -= byteCount
                            size += byteCount
                            return
                        } else {
                            source.head = source.head.getOrThrow().split(byteCount)
                        }
                }
            }

            let segmentToMove = source.head.getOrThrow()
            var movedByteCount = segmentToMove.limit - segmentToMove.pos
            source.head = segmentToMove.pop()
            match (head) {
                case None => 
                    head = segmentToMove
                    head.getOrThrow().next = head
                    head.getOrThrow().prev = head 
                case Some(v) => 
                    let tail = v.prev.getOrThrow().push(segmentToMove)
                    tail.compact()
            }   
            source.size -= movedByteCount
            size += movedByteCount
            byteCount -= movedByteCount
        }
    }
    public operator func == (that: Buffer): Bool {
        return refEq(this, that)
    }
    public operator func != (that: Buffer): Bool {
        return !refEq(this, that)
    }
}
