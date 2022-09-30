/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the Buffer class.
 */
package okio

import nio.ArrayCopy

from std import math.*
from std import collection.StringBuilder

let let_0: UInt8 = UInt8(UInt32('0'))
let let_9: UInt8 = UInt8(UInt32('9'))
let let_a: UInt8 = UInt8(UInt32('a'))
let let_f: UInt8 = UInt8(UInt32('f'))
let let_A: UInt8 = UInt8(UInt32('A'))
let let_F: UInt8 = UInt8(UInt32('F'))
let let__: UInt8 = UInt8(UInt32('_'))
let let_LF: Int8 = Int8(UInt32('\n'))
let let_CR: Int8 = Int8(UInt32('\r'))
let REPLACEMENT_CHARACTER: Int64 = Int64(UInt32('\u{fffd}'))

/**
 * The class is Buffer inherited from Object & BufferedSource & BufferedSink & Equatable<Buffer> & ToString & Hashable
 * @author liyanqing14
 * @since 0.32.5
 */
public class Buffer <: Object &  BufferedSource & BufferedSink & Equatable<Buffer> & ToString & Hashable {

    static let DIGITS: Array<Byte> = [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f]
    
    var head: ?Segment = None 
    var mysize: Int64 = 0

    /**
     * let member size type is Int64 {
     * @since 0.32.5
     */
    public prop let size: Int64 {
        get() {
            return mysize
        }
    }

    /**
     * The Function is init constructor
     *
     * @since 0.32.5
     */
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

    /**
     * The Function is getBuffer
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func getBuffer(): Buffer {
        return this
    }

    /**
     * The Function is write
     *
     * @param byteString of ByteString
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    public override func write(byteString: ByteString): BufferedSink {
        byteString.write(this)
        this
    }

    /**
     * The Function is write
     *
     * @param source of Array<Byte>
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func write(source: Array<Byte>): Buffer {
        return write(source, 0, source.size)
    }

    /**
     * The Function is write
     *
     * @param source of Array<Byte>
     * @param offset of Int64
     * @param byteCount of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func write(source: Array<Byte>, offset: Int64, byteCount: Int64): Buffer {
        Util.checkOffsetAndCount(source.size, offset, byteCount)
        var offset = offset
        var limit = offset + byteCount
        while (offset < limit) {
            let tail = writableSegment(1)
            let toCopy = math.min(limit - offset, Segment.SIZE - tail.limit)
            nio.ArrayCopy(source, offset, tail.data, tail.limit, toCopy)
            offset += toCopy
            tail.limit += toCopy
        }
        mysize += byteCount
        return this
    }

    /**
     * The Function is writeAll
     *
     * @param source of Source
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func writeAll(source: Source): Int64 {
        var totalBytesRead = 0
        var readCount: Int64 = 0
        while (readCount != -1) {
            totalBytesRead += readCount
            readCount = source.read(this, Segment.SIZE)
        }
        return totalBytesRead
    }

    /**
     * The Function is write
     *
     * @param source of Source
     * @param byteCount of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    public override func write(source: Source, byteCount: Int64): BufferedSink {
        var byteCount = byteCount
        while (byteCount > 0) {
            let read = source.read(this, byteCount)
            if (read == -1) {
                throw EOFException()
            }
            byteCount -= read
        }
        return this
    }

    /**
     * The Function is writeUtf8
     *
     * @param string of String
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    public override func writeUtf8(string: String): BufferedSink {
        return writeUtf8(string, 0, string.size)
    }

    /**
     * The Function is writeUtf8
     *
     * @param string of String
     * @param beginIndex of Int64
     * @param endIndex of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    @overflowWrapping
    public override func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink {
        if (beginIndex < 0) { throw IllegalArgumentException("beginIndex < 0: ${beginIndex}") }
        if (endIndex < beginIndex) { throw IllegalArgumentException("endIndex < beginIndex: ${endIndex} < ${beginIndex}") }
        if (endIndex > string.size) { throw IllegalArgumentException("endIndex > string.length: ${endIndex} > ${string.size}") }
        var i = beginIndex
        while (i < endIndex) {
            var c: Char = string.charAt(i)
            if (UInt32(c) < 0x80) {
                let tail = writableSegment(1)
                let data = tail.data
                var segmentOffset = tail.limit - i
                var runLimit = math.min(endIndex, Segment.SIZE - segmentOffset)
                data[segmentOffset + i] = UInt8(UInt32(c))
                i++
                while (i < runLimit) {
                    c = string.charAt(i)
                    if (UInt32(c) >= 0x80){
                        break
                    }
                    data[segmentOffset + i] = UInt8(UInt32(c))
                    i++
                }
                var runSize = i + segmentOffset - tail.limit
                tail.limit += runSize
                mysize += runSize
            } else if (UInt32(c) < 0x800) {                     // Emit a 11-bit character with 2 bytes.
                writeInt8(Int64(UInt32(c) >>  6)        | 0xc0) // 110xxxxx
                writeInt8(Int64(UInt32(c)       & 0x3f) | 0x80) // 10xxxxxx
                i++
            } else if (UInt32(c) < 0xd800 || UInt32(c) > 0xdfff) {  // Emit a 16-bit character with 3 bytes.
                writeInt8(Int64(UInt32(c) >> 12)        | 0xe0)     // 1110xxxx
                writeInt8(Int64(UInt32(c) >>  6 & 0x3f) | 0x80)     // 10xxxxxx
                writeInt8(Int64(UInt32(c)       & 0x3f) | 0x80)     // 10xxxxxx
                i++
            } else {
                let low: UInt32 = if (i + 1 < endIndex) { UInt32(string.charAt(i+1)) } else { 0 }
                if (UInt32(c) > 0xdbff || low < 0xdc00 || low > 0xdfff) {
                    writeInt8(Int64(UInt32('?')))
                    i++
                    continue
                }
                let codePoint = 0x010000 + (Int64((UInt32(c)) & !0xd800) << 10 | Int64(low) & !0xdc00)
                writeInt8(codePoint >> 18        | 0xf0) // 11110xxx
                writeInt8(codePoint >> 12 & 0x3f | 0x80) // 10xxxxxx
                writeInt8(codePoint >>  6 & 0x3f | 0x80) // 10xxyyyy
                writeInt8(codePoint       & 0x3f | 0x80) // 10yyyyyy
                i += 2
            }
        }
        return this
    }

    /**
     * The Function is writeUtf8CodePoint
     *
     * @param codePoint of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    @overflowWrapping
    public override func writeUtf8CodePoint(codePoint: Int64): BufferedSink {
        if (codePoint < 0x80) {
            this.writeInt8(codePoint)
        } else if (codePoint < 0x800) {
            // Emit a 11-bit code point with 2 bytes.
            writeInt8(codePoint >>  6        | 0xc0) // 110xxxxx
            writeInt8(codePoint       & 0x3f | 0x80) // 10xxxxxx

        } else if (codePoint < 0x10000) {
            if (codePoint >= 0xd800 && codePoint <= 0xdfff) {
                // Emit a replacement character for a partial surrogate.
                writeInt8(Int64(UInt32('?')))
            } else {
                // Emit a 16-bit code point with 3 bytes.
                writeInt8(codePoint >> 12        | 0xe0) // 1110xxxx
                writeInt8(codePoint >>  6 & 0x3f | 0x80) // 10xxxxxx
                writeInt8(codePoint       & 0x3f | 0x80) // 10xxxxxx
            }

        } else if (codePoint <= 0x10ffff) {
            // Emit a 21-bit code point with 4 bytes.
            writeInt8(codePoint >> 18        | 0xf0) // 11110xxx
            writeInt8(codePoint >> 12 & 0x3f | 0x80) // 10xxxxxx
            writeInt8(codePoint >>  6 & 0x3f | 0x80) // 10xxxxxx
            writeInt8(codePoint       & 0x3f | 0x80) // 10xxxxxx

        } else {
            throw IllegalArgumentException( "Unexpected code point: ${codePoint}" )
        }
        return this
    }

    /**
     * The Function is writeInt8
     *
     * @param value of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    @overflowWrapping
    public override func writeInt8(value: Int64): BufferedSink {
        let tail = writableSegment(1)
        tail.data[tail.limit] = UInt8(value)
        tail.limit ++
        mysize += 1
        return this
    }

    /**
     * The Function is writeInt16
     *
     * @param i of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    @overflowWrapping
    public override func writeInt16(i: Int64): BufferedSink {
        let tail = writableSegment(2)
        let data = tail.data
        var limit = tail.limit
        data[limit] = UInt8((UInt16(i) >> 8) & 0xff)
        limit++
        data[limit] = UInt8(UInt16(i) & 0xff)
        limit++
        tail.limit = limit
        mysize += 2
        return this
    }

    /**
     * The Function is writeInt16Le
     *
     * @param value of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    @overflowWrapping
    public override func writeInt16Le(value: Int64): BufferedSink {
        return writeInt16(Int64(Util.reverseBytesInt16(Int16(value))))
    }

    /**
     * The Function is writeInt32
     *
     * @param i of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    @overflowWrapping
    public override func writeInt32(i: Int64): BufferedSink {
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
        mysize += 4
        return this
    }

    /**
     * The Function is writeInt32Le
     *
     * @param value of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    @overflowWrapping
    public override func writeInt32Le(value: Int64): BufferedSink {
        return writeInt32(Int64(Util.reverseBytesInt32(Int32(value))))
    }

    /**
     * The Function is writeInt64
     *
     * @param i of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    @overflowWrapping
    public override func writeInt64(i: Int64): BufferedSink {
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
        mysize += 8
        return this
    }

    /**
     * The Function is writeInt64Le
     *
     * @param value of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    public override func writeInt64Le(value: Int64): BufferedSink {
        return writeInt64(Util.reverseBytesInt64(value))
    }

    /**
     * The Function is writeDecimalInt64
     *
     * @param value of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    public override func writeDecimalInt64(value: Int64): BufferedSink {
        this  // TODO 
    }

    /**
     * The Function is writeHexadecimalUInt64
     *
     * @param value of Int64
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    public override func writeHexadecimalUInt64(value: Int64): BufferedSink {
        this  // TODO 
    }

    /**
     * The Function is flush
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public override func flush(): Unit {}

    /**
     * The Function is emit
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    public override func emit(): BufferedSink {
        return this
    }

    /**
     * The Function is exhausted
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public override func exhausted(): Bool {
        return size == 0
    }

    /**
     * The Function is require
     *
     * @param byteCount of Int64
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public override func require(byteCount: Int64): Unit {
        if (size < byteCount) {
            throw EOFException()
        }
    }

    /**
     * The Function is request
     *
     * @param byteCount of Int64
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public override func request(byteCount: Int64): Bool {
        return this.size >= byteCount
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
        mysize -= 1
        if (pos == limit) {
            this.head = segment.pop()
            SegmentPool.recycle(segment)
        } else {
            segment.pos = pos
        }
        return b
    }

    /**
     * The Function is completeSegmentByteCount
     *
     * @return Type of Int64
     * @since 0.32.5
     */
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

    /**
     * The Function is readInt8
     *
     * @return Type of Int8
     * @since 0.32.5
     */
    public override func readInt8(): Int8 {
        return Int8(readByte())
    }

    /**
     * The Function is readInt16
     *
     * @return Type of Int16
     * @since 0.32.5
     */
    public override func readInt16(): Int16 {
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
        mysize -= 2
        if (pos == limit ) {
            this.head = segment.pop()
            SegmentPool.recycle(segment)
        } else {
            segment.pos = pos
        }
        return Int16(s)
    }

    /**
     * The Function is readInt16Le
     *
     * @return Type of Int16
     * @since 0.32.5
     */
    public override func readInt16Le(): Int16 {
        return Util.reverseBytesInt16(readInt16())
    }

    /**
     * The Function is readInt32
     *
     * @return Type of Int32
     * @since 0.32.5
     */
    public override func readInt32(): Int32 {
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
        mysize -= 4
        if (pos == limit ) {
            this.head = segment.pop()
            SegmentPool.recycle(segment)
        } else {
            segment.pos = pos
        }
        return Int32(s)
    }

    /**
     * The Function is readInt32Le
     *
     * @return Type of Int32
     * @since 0.32.5
     */
    public override func readInt32Le(): Int32 {
        return Util.reverseBytesInt32(readInt32())
    }

    /**
     * The Function is readInt64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func readInt64(): Int64 {
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
        mysize -= 8
        if (pos == limit) {
            this.head = segment.pop()
            SegmentPool.recycle(segment)
        } else {
            segment.pos = pos
        }
        return Int64(s)
    }

    /**
     * The Function is readInt64Le
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func readInt64Le(): Int64 {
        return Util.reverseBytesInt64(readInt64())
    }

    /**
     * The Function is readDecimalInt64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func readDecimalInt64(): Int64 {
        if (this.size == 0) { throw IllegalStateException(" size == 0") }
        var value = 0
        var seen = 0
        var negative: Bool = false
        var done = false
        var overflowZone = Int64.Min / 10
        var overflowDigit = (Int64.Min % 10) + 1
        do {
            let segment = this.head.getOrThrow()
            let data = segment.data
            var pos = segment.pos
            var limit = segment.limit
            while (pos < limit) {
                let b = data[pos]
                if (b >= let_0 && b <= let_9) {
                    var digit = Int64(let_0 - b)
                    if (value < overflowZone || value == overflowZone && digit < overflowDigit) {
                        throw NumberFormatException("Number too large: ")
                    }
                    value *= 10
                    value += digit
                } else if (b == let__ && seen == 0) {
                    negative = true
                    overflowDigit -= 1
                } else {
                    if (seen == 0) {
                        throw NumberFormatException("Expected leading [0-9] or '-' character but was 0x")
                    }
                    done = true
                    break
                }
            }
            if (pos ==limit) {
                this.head = segment.pop()
                SegmentPool.recycle(segment)
            } else {
                segment.pos = pos
            }
        } while (!done && match (this.head) {
            case None => false
            case _ => true
        })
        this.mysize -= seen
        return match (negative) {
            case true => value
            case false => -value
        }
    }

    /**
     * The Function is readHexadecimalUInt64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func readHexadecimalUInt64(): Int64 {
        if (this.size == 0) {
            throw IllegalStateException("size == 0")
        }
        var value = 0
        var seen = 0
        var done = false
        do {
            let segment = this.head.getOrThrow()
            let data = segment.data
            var pos = segment.pos
            var limit = segment.limit
            while (pos < limit) {
                var digit = 0
                var b: UInt8 = data[pos]
                if (b >= let_0 && b <= let_9) {
                    digit = Int64(b - let_0)
                } else if (b >= let_a && b <= let_f) {
                    digit = Int64(b - let_a + 10)
                } else if (b >= let_A && b <= let_F) {
                    digit = Int64(b - let_A + 10)
                } else {
                    if (seen == 0) {
                        throw NumberFormatException ("Expected leading [0-9a-fA-F] character but was 0x" )
                    }
                    done = true
                    break
                }
                if ((UInt64(value) & 0xf000000000000000) != 0) {
                    throw NumberFormatException("Number too large: ")
                }
                value <<= 4
                value |= digit
                pos++
                seen++
            }
            if (pos ==limit) {
                this.head = segment.pop()
                SegmentPool.recycle(segment)
            } else {
                segment.pos = pos
            }
        } while (!done && match (this.head) {
            case None => false
            case _ => true
        })
        this.mysize -= seen
        return value
    }

    /**
     * The Function is readByteString
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public override func readByteString(): ByteString {
        ByteString(readByteArray())
    }

    /**
     * The Function is readByteString
     *
     * @param byteCount of Int64
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public override func readByteString(byteCount: Int64): ByteString {
        ByteString(readByteArray(byteCount))
    }

    /**
     * The Function is readByteArray
     *
     * @return Type of Array<Byte>
     * @since 0.32.5
     */
    public override func readByteArray(): Array<Byte> {
        try {
            return readByteArray(this.size)
        } catch (e: AssertionException) {
            throw e
        }
    }

    /**
     * The Function is readByteArray
     *
     * @param byteCount of Int64
     *
     * @return Type of Array<Byte>
     * @since 0.32.5
     */
    public override func readByteArray(byteCount: Int64): Array<Byte> {
        Util.checkOffsetAndCount(size, 0, byteCount) 
        if (byteCount > Int64(Int32.Max)) {
            throw IllegalArgumentException()
        }
        let result = Array<Byte>(byteCount, item:0)
        readFully(result)
        return result
    }

    /**
     * The Function is read
     *
     * @param sink of Array<Byte>
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func read(sink: Array<Byte>): Int64 {
        return read(sink, 0, sink.size)
    }

    /**
     * The Function is read
     *
     * @param sink of ByteBuffer
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func read(sink: ByteBuffer): Int64 {
        let s = this.head.getOrThrow()
        let toCopy = min(sink.remaining(), s.limit - s.pos)
        sink.put(s.data, s.pos, toCopy)
        s.pos += toCopy
        mysize -= toCopy
        if (s.pos == s.limit) {
            this.head = s.pop()
            SegmentPool.recycle(s)
        }
        return toCopy
    }

    /**
     * The Function is read
     *
     * @param sink of Array<Byte>
     * @param offset of Int64
     * @param byteCount of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64 {
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
                mysize -= toCopy
                if (v.pos == v.limit) {
                    this.head = v.pop()
                    SegmentPool.recycle(v)
                }
                return toCopy
        }
    }

    /**
     * The Function is read
     *
     * @param sink of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    // @override Source
    public override func read(sink: Buffer, byteCount: Int64): Int64 {
        if (byteCount < 0) {
            throw IllegalArgumentException("byteCount < 0: ${byteCount}")
        }
        if (size == 0) {
            return -1
        }
        var byteCount = byteCount
        if (byteCount > size) {
            byteCount = size
        }
        sink.write(this, byteCount)
        return byteCount
    }

    /**
     * The Function is readFully
     *
     * @param sink of Array<Byte>
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public override func readFully(sink: Array<Byte>): Unit {
        var offset = 0
        while (offset < sink.size) {
            let read = read(sink, offset, sink.size - offset)
            if (read == -1) {
                throw EOFException()
            }
            offset += read
        }
    }

    /**
     * The Function is readFully
     *
     * @param sink of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public override func readFully(sink: Buffer, byteCount: Int64): Unit {
        if (size < byteCount) {
            sink.write(this, size)
            throw EOFException()
        }
        sink.write(this, byteCount)
    } 

    /**
     * The Function is readAll
     *
     * @param sink of Sink
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func readAll(sink: Sink): Int64 {
        let byteCount = size
        if (byteCount < 0) {
            sink.write(this, byteCount)
        }
        return byteCount
    }

    /**
     * The Function is readUtf8
     *
     * @return Type of ?String
     * @since 0.32.5
     */
    public override func readUtf8(): ?String {
        try {
            return readString(size)
        } catch (e: EOFException) {
            throw e
        }
    }

    /**
     * The Function is readUtf8
     *
     * @param byteCount of Int64
     *
     * @return Type of ?String
     * @since 0.32.5
     */
    public override func readUtf8(byteCount: Int64): ?String {
        return readString(byteCount)  // TODO: readString(byteCount, Util.UTF_8)
    }

    /**
     * The Function is readString
     *
     * @return Type of ?String
     * @since 0.32.5
     */
    public override func readString(): ?String {  // TODO: readString(Charset charset)
        try {
            return readString(size)
        } catch (e: EOFException) {
            throw e
        }
    }

    /**
     * The Function is readString
     *
     * @param byteCount of Int64
     *
     * @return Type of ?String
     * @since 0.32.5
     */
    public override func readString(byteCount: Int64) : ?String {  // TODO:  readString(long byteCount, Charset charset) 
        Util.checkOffsetAndCount(this.size, 0, byteCount)
        if (byteCount > Int64(Int32.Max)) {
            throw IllegalArgumentException("byteCount > Integer.MAX_VALUE: ${byteCount}")
        }
        if (byteCount == 0) {
            return None
        }
        let s = this.head.getOrThrow()
        if (s.pos + byteCount > s.limit) {
            return String.fromUtf8(readByteArray(byteCount))
        }
        let result = String.fromUtf8(s.data, start: s.pos, length: byteCount)
        s.pos += byteCount
        this.mysize -= byteCount
        if (s.pos == s.limit) {
            this.head = s.pop()
            SegmentPool.recycle(s)
        }
        return result
    }


    /**
     * The Function is readUtf8Line
     *
     * @return Type of ?String
     * @since 0.32.5
     */
    public override func readUtf8Line(): ?String {
        let newline = indexOf(let_LF)
        if (newline == -1 && size != 0) {
            return readUtf8(size)
        } else if (newline == -1 && size == 0) {
            return None
        }
        return readUtf8Line(newline)
    }

    func readUtf8Line(newLine: Int64): ?String {
        if (newLine > 0 && getInt8(newLine -1) == Int8(UInt32('\r'))) {
            let result = readUtf8(newLine -1)
            this.skip(2)
            return result
        } else {
            let result = readUtf8(newLine)
            this.skip(1)
            return result
        }
    }

    /**
     * The Function is readUtf8LineStrict
     *
     * @return Type of ?String
     * @since 0.32.5
     */
    public override func readUtf8LineStrict(): ?String {
        return readUtf8LineStrict(Int64.Max)
    }

    /**
     * The Function is readUtf8LineStrict
     *
     * @param limit of Int64
     *
     * @return Type of ?String
     * @since 0.32.5
     */
    public override func readUtf8LineStrict(limit: Int64): ?String {
        if (limit < 0) {
            throw IllegalArgumentException("limit < 0: ${limit}")
        }
        let scanLength = if (limit == Int64.Max) {
            Int64.Max
        } else {
            limit + 1
        }
        let newLine = indexOf(let_LF, 0, scanLength)
        if (newLine != -1) {
            return readUtf8Line(newLine)
        }
        if (scanLength < size 
            && getInt8(scanLength - 1) == let_CR
            && getInt8(scanLength) == let_LF) {
            return readUtf8Line(scanLength)
        }
        let data = Buffer()
        copyTo(data, 0, math.min(32, size))
        throw EOFException("\\n not found: limit= ${math.min(size, limit)} content= ${data.readByteString().hex()} …") 
    }

    /**
     * The Function is readUtf8CodePoint
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func readUtf8CodePoint(): Int64 {
        if (size == 0) { throw EOFException() }
        var b0 = UInt8(getInt8(0))
        var codePoint = 0
        var byteCount = 0
        var min = 0
        if ((b0 & 0x80) == 0) {
            codePoint = Int64(b0 & 0x7f)
            byteCount = 1                   // 7 bits (ASCII).
            min = 0x0
        } else if ((b0 & 0xe0) == 0xc0) {   // 0x110xxxxx
            codePoint = Int64(b0 & 0x1f) 
            byteCount = 2                   // 11 bits (5 + 6).
            min = 0x80 
        } else if ((b0 & 0xf0) == 0xe0) {   // 0x1110xxxx
            codePoint = Int64(b0 & 0x0f) 
            byteCount = 3                   // 16 bits (4 + 6 + 6).
            min = 0x800 
        } else if ((b0 & 0xf8) == 0xf0) {   // 0x11110xxx
            codePoint = Int64(b0 & 0x07) 
            byteCount = 4                   // 21 bits (3 + 6 + 6 + 6).
            min = 0x10000 
        } else {                            // We expected the first byte of a code point but got something else.
            skip(1)
            return REPLACEMENT_CHARACTER 
        }
        if (size < byteCount) { throw EOFException("size < ${byteCount}:${size}(to read code point prefixed ${b0}") }
        for (i in 1..byteCount) {
            let b = UInt8(getInt8(i))
            if ((b & 0xc0) == 0x80) {
                codePoint <<= 6 
                codePoint |= Int64(b & 0x3f) 
            } else {
                skip(1)
                return REPLACEMENT_CHARACTER
            }
        }
        skip(byteCount) 
        return match {
            case codePoint > 0x10ffff => REPLACEMENT_CHARACTER                          // Reject code points larger than the Unicode maximum.
            case codePoint >= 0xd800 && codePoint <= 0xdfff => REPLACEMENT_CHARACTER    // Reject partial surrogates.
            case codePoint < min => REPLACEMENT_CHARACTER                               // Reject overlong code points.
            case _ => codePoint
        }
    }

    /**
     * The Function is indexOf
     *
     * @param value of Int8
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func indexOf(value: Int8): Int64 {
        return indexOf(value, 0, Int64.Max)
    }

    /**
     * The Function is indexOf
     *
     * @param value of Int8
     * @param fromIndex of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func indexOf(value: Int8, fromIndex: Int64): Int64 {
        return indexOf(value, fromIndex, Int64.Max)
    }

    /**
     * The Function is indexOf
     *
     * @param value of Int8
     * @param fromIndex of Int64
     * @param toIndex of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func indexOf(value: Int8, fromIndex: Int64, toIndex: Int64): Int64 {
        if (fromIndex < 0 || toIndex < fromIndex) {
            throw IllegalArgumentException("fromIndex: ${fromIndex} is greater than toIndex: ${fromIndex} or less than 0")
        }
        var fromIndex = fromIndex
        var toIndex = toIndex
        let b = UInt8(value)
        if (toIndex > size) {
            toIndex = size
        }
        if (fromIndex == toIndex) {
            return -1
        }
        var s: ?Segment = None
        var offset = -1
        match (this.head) {
            case None => return -1
            case Some(v) => s = this.head
        }
        if (size - fromIndex < fromIndex) {
            offset = size
            while (offset > fromIndex) {
                s = s.getOrThrow().prev.getOrThrow()
                offset -= (s.getOrThrow().limit - s.getOrThrow().pos)
            }
        } else  {
            offset = 0
            var nextOffset = offset + (s.getOrThrow().limit - s.getOrThrow().pos)
            while (nextOffset < fromIndex) {
                s = s.getOrThrow().next.getOrThrow()
                offset = nextOffset
                nextOffset = offset + (s.getOrThrow().limit - s.getOrThrow().pos)
            }
        }
        while (offset < toIndex) {
            let data = s.getOrThrow().data
            var limit = math.min(s.getOrThrow().limit, s.getOrThrow().pos + toIndex - offset)
            var pos = s.getOrThrow().pos + fromIndex - offset
            while(pos < limit) {
                if (data[pos] == b) {
                    return pos - s.getOrThrow().pos + offset
                }
                pos++
            }
            offset += (s.getOrThrow().limit - s.getOrThrow().pos)
            fromIndex = offset
            s = s.getOrThrow().next
        }
        return -1
    }

    /**
     * The Function is indexOf
     *
     * @param bytes of ByteString
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func indexOf(bytes: ByteString): Int64 {
        return indexOf(bytes, 0)
    }

    /**
     * The Function is indexOf
     *
     * @param bytes of ByteString
     * @param fromIndex of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func indexOf(bytes: ByteString, fromIndex: Int64): Int64 {
        if (bytes.size == 0) {
            throw IllegalArgumentException("bytes is empty")
        }
        if (fromIndex < 0) {
            throw IllegalArgumentException("fromIndex < 0")
        }
        var fromIndex = fromIndex
        var s: ?Segment = None
        var offset = -1
        match (this.head) {
            case None => return -1
            case Some(v) => s = this.head
        }
        if (size - fromIndex < fromIndex) {
            offset = size
            while (offset > fromIndex) {
                s = s.getOrThrow().prev.getOrThrow()
                offset -= (s.getOrThrow().limit - s.getOrThrow().pos)
            }
        } else  {
            offset = 0
            var nextOffset = offset + (s.getOrThrow().limit - s.getOrThrow().pos)
            while (nextOffset < fromIndex) {
                s = s.getOrThrow().next.getOrThrow()
                offset = nextOffset
                nextOffset = offset + (s.getOrThrow().limit - s.getOrThrow().pos)
            }
        }

        let b0 = bytes.getByte(0)
        var bytesSize = bytes.size
        var resultLimit = size - bytesSize + 1
        while (offset < resultLimit) {
            let data = s.getOrThrow().data
            let segmentLimit = math.min(s.getOrThrow().limit, s.getOrThrow().pos + resultLimit - offset)
            for (pos in s.getOrThrow().pos + fromIndex - offset .. segmentLimit where data[pos] == b0 && this.rangeEquals(s.getOrThrow(), pos + 1, bytes, 1, bytesSize)) {
                return pos - s.getOrThrow().pos + offset
            }
            offset += (s.getOrThrow().limit - s.getOrThrow().pos)
            fromIndex = offset
            s = s.getOrThrow().next
        }
        return -1
    }

    /**
     * The Function is indexOfElement
     *
     * @param targetBytes of ByteString
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func indexOfElement(targetBytes: ByteString): Int64 {
        return indexOfElement(targetBytes, 0)
    }

    /**
     * The Function is indexOfElement
     *
     * @param targetBytes of ByteString
     * @param fromIndex of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64 {
        if (fromIndex < 0) {
            throw IllegalArgumentException("fromIndex < 0")
        }
        var fromIndex = fromIndex
        var offset = 0
        var s: Segment = match (this.head) {
            case None => return -1
            case Some(v) => v
        }
        if (size - fromIndex < fromIndex) {
            offset = size
            while (offset > fromIndex) {
                s = s.prev.getOrThrow()
                offset -= (s.limit - s.pos)
            }
        } else  {
            var nextOffset = offset + (s.limit - s.pos)
            while (nextOffset < fromIndex) {
                s = s.next.getOrThrow()
                offset = nextOffset
                nextOffset = offset + (s.limit - s.pos)
            }
        }
        if (targetBytes.size == 2) {
            var b0 = targetBytes.getByte(0)
            var b1 = targetBytes.getByte(1)
            while (offset < size) {
                for (pos in s.pos + fromIndex - offset..s.limit where s.data[pos] == b0 || s.data[pos] == b1) {
                    return pos - s.pos + offset
                }
                offset += (s.limit - s.pos)
                fromIndex = offset
                s = s.next.getOrThrow()
            }
        } else {
            let targetByteArray = targetBytes.internalArray()
            while (offset < size) {
                for (pos in s.pos + fromIndex - offset..s.limit) {
                    for (t in targetByteArray where s.data[pos] == t) {
                        return pos - s.pos + offset
                    }
                }
                offset += (s.limit - s.pos)
                fromIndex = offset
                s = s.next.getOrThrow()
            }
        }
        return -1
    }

    /**
     * The Function is rangeEquals
     *
     * @param offset of Int64
     * @param bytes of ByteString
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public override func rangeEquals(offset: Int64, bytes: ByteString): Bool {
        return rangeEquals(offset, bytes, 0, bytes.size)
    }

    /**
     * The Function is rangeEquals
     *
     * @param offset of Int64
     * @param bytes of ByteString
     * @param bytesOffset of Int64
     * @param byteCount of Int64
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public override func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool {
        if (offset < 0
            || bytesOffset < 0
            || byteCount < 0
            || size - offset < byteCount
            || bytes.size - bytesOffset < byteCount) {
            return false
        }
        for (i in 0..byteCount where UInt8(getInt8(offset + i)) != bytes.getByte(bytesOffset + i)) {
            return false
        }
        return true
    }

    private func rangeEquals(segment: Segment, segmentPos: Int64, bytes: ByteString, bytesOffset:Int64, bytesLimit: Int64): Bool {
        var segment = segment
        var segmentPos = segmentPos
        var segmentLimit = segment.limit
        var data = segment.data
        for (i in bytesOffset..bytesLimit) {
            if (segmentPos == segmentLimit) {
                segment = segment.next.getOrThrow()
                data = segment.data
                segmentPos = segment.pos
                segmentLimit = segment.limit
            }
            if (data[segmentPos] != bytes.getByte(i)) {
                return false
            }
            segmentPos ++
        }
        return true
    }

    /**
     * The Function is emitCompleteSegments
     *
     * @return Type of BufferedSink
     * @since 0.32.5
     */
    public override func emitCompleteSegments(): BufferedSink {
        return this
    }

    /**
     * The Function is clear
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public func clear(): Unit {
        try {
            this.skip(size)
        } catch (e: Exception) {
            throw e
        }
    }

    /**
     * The Function is skip
     *
     * @param byteCount of Int64
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public override func skip(byteCount: Int64): Unit {
        var byteCount = byteCount
        while (byteCount > 0) {
            let s = match(this.head) {
                case Some(v) => v
                case None => throw EOFException()
            }
            let toSkip = min(byteCount, s.limit - s.pos)
            this.mysize -= toSkip
            byteCount -= toSkip
            s.pos += toSkip
            if (s.pos == s.limit) {
                this.head = s.pop()
                SegmentPool.recycle(s)
            }
        }
    }

    /**
     * The Function is peek
     *
     * @return Type of BufferedSource
     * @since 0.32.5
     */
    public override func peek(): BufferedSource {
        return Okio.buffer(PeekSource(this))
    }

    /**
     * The Function is close
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public override func close(): Unit {}

    /**
     * The Function is timeout
     *
     * @return Type of Timeout
     * @since 0.32.5
     */
    public override func timeout(): Timeout {
        return Timeout.NONE
    }

    /**
     * The Function is isClosed
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public override func isClosed(): Bool {
        throw Exception("isClosed not support.")
    }

    /**
     * The Function is hashCode
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    @overflowWrapping
    public override func hashCode(): Int64 {
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

    /**
     * The Function is copyTo
     *
     * @param out of Buffer
     * @param offset of Int64
     * @param byteCount of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func copyTo(out: Buffer, offset: Int64, byteCount: Int64): Buffer {
        Util.checkOffsetAndCount(size, offset, byteCount)
        var offset = offset
        var byteCount = byteCount
        if (byteCount == 0 ) {
            return this
        }
        out.mysize += byteCount
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
                    v.prev.getOrThrow().push(copy)
                    ()
                    
            }
            byteCount -= copy.limit - copy.pos
            offset = 0
            s = s.next.getOrThrow()
        }
        return this
    }


    /**
     * The Function is write
     *
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public override func write(source: Buffer, byteCount: Int64): Unit {
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
                            source.mysize -= byteCount
                            mysize += byteCount
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
            source.mysize -= movedByteCount
            this.mysize += movedByteCount
            byteCount -= movedByteCount
        }
    }

    /**
     * The Function is ==
     *
     * @param that of Buffer
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public operator func == (that: Buffer): Bool {
        match ((that.head, this.head)) {
            case (Some(n), Some(m)) => 
                if (n != m) {
                    return false
                }
            case (None, None) => () 
            case _ => return false
        }
        if (this.size != that.size) {
            return false
        }
        return refEq(this, that)
    }

    /**
     * The Function is !=
     *
     * @param that of Buffer
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public operator func != (that: Buffer): Bool {
        return !refEq(this, that)
    }

    /**
     * The Function is getInt8
     *
     * @param pos of Int64
     *
     * @return Type of Int8
     * @since 0.32.5
     */
    @overflowWrapping
    public func getInt8(pos: Int64): Int8 {
        var pos = pos
        Util.checkOffsetAndCount(size, pos, 1)
        if (size - pos > pos) {
            var s = this.head.getOrThrow()
            while (true) {
                let segmentByteCount = s.limit - s.pos
                if (pos < segmentByteCount) {
                    return Int8(s.data[s.pos + pos])
                }
                pos -= segmentByteCount
                s = s.next.getOrThrow()
            }
        } else {
            pos -= size
            var s = this.head.getOrThrow()
            while (true) {
                pos += s.limit - s.pos
                if (pos >= 0) {
                    return Int8(s.data[s.pos + pos])
                }
                s = s.prev.getOrThrow()
            }
        }
        return 1
    }

    /**
     * The Function is toString
     *
     * @return Type of String
     * @since 0.32.5
     */
    public override func toString():String {
        let sb = StringBuilder()
        sb.append("[size=${this.size}] ")
        var temp = this.head
        while (true) {
            match (temp) {
                case None => break
                case Some(v) =>
                    sb.append(v.data[v.pos..v.limit])
                    break
                    temp = v.next
            }
        }
        return sb.toString()
    }

    /**
     * The Function is buffer
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func buffer(): Buffer {
        return this
    }
}
