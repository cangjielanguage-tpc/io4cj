/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the ByteBuffer class.
 */
package nio

from std import collection.StringBuilder

/**
 * The class is ByteBuffer inherited from Buffer & ToString & Hashable & Equatable<Buffer>
 * @author liyanqing14
 * @since 0.32.5
 */
public abstract class ByteBuffer <: Buffer & ToString & Hashable & Equatable<Buffer>  {

    let hb: Array<Byte> 

    let offset: Int64
    
    init (mark: Int64, position: Int64, limit: Int64, capacity: Int64, hbs: Array<Byte>, offset: Int64) {
        super(mark, position, limit, capacity)
        this.hb = hbs
        this.offset = offset
    }

    /**
     * The Function is allocate
     *
     * @param capacity of Int64
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public static func allocate(capacity: Int64): ByteBuffer {
        if (capacity < 0) {
            throw IllegalArgumentException()
        }
        return HeapByteBuffer(capacity, capacity)
    }

    /**
     * The Function is wrap
     *
     * @param array of Array<UInt8>
     * @param offset of Int64
     * @param length of Int64
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public static func wrap(array: Array<UInt8>, offset: Int64, length: Int64): ByteBuffer {
        return HeapByteBuffer(array, offset, length)
    }

    /**
     * The Function is wrap
     *
     * @param array of Array<UInt8>
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public static func wrap(array: Array<UInt8>): ByteBuffer {
        return wrap(array, 0, array.size)
    }

    /**
     * The Function is slice
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func slice(): Buffer

    /**
     * The Function is duplicate
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func duplicate(): Buffer

    /**
     * The Function is asReadOnlyBuffer
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func asReadOnlyBuffer(): Buffer

    /**
     * The Function is get
     *
     * @return Type of UInt8
     * @since 0.32.5
     */
    public func get(): UInt8

    /**
     * The Function is put
     *
     * @param b of UInt8
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func put(b: UInt8): Buffer

    /**
     * The Function is get
     *
     * @param index of Int64
     *
     * @return Type of UInt8
     * @since 0.32.5
     */
    public func get(index: Int64): UInt8

    /**
     * The Function is put
     *
     * @param index of Int64
     * @param b of UInt8
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func put(index: Int64, b: UInt8): Buffer

    public func putLong(value: Int64): ByteBuffer
    public func putInt(value: Int32): ByteBuffer
    public func putShort(value: Int16): ByteBuffer
    public func putUInt64(value: UInt64): ByteBuffer
    public func putUInt32(value: UInt32): ByteBuffer
    public func putUInt16(value: UInt16): ByteBuffer

    public func getLong(): Int64
    public func getInt(): Int32
    public func getShort(): Int16
    public func getUInt64(): UInt64
    public func getUInt32(): UInt32
    public func getUInt16(): UInt16
    /**
     * The Function is get
     *
     * @param dst of Array<UInt8>
     * @param offset of Int64
     * @param length of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func get(dst: Array<UInt8>, offset: Int64, length: Int64) : Buffer {
        checkBounds(offset, length, dst.size)
        if (length > super.remaining()) {
            throw Exception("length > super.remaining()")
        }
        let end = offset + length
        for (i in offset..end) {
            dst[i] = get()
        }
        return this
    }

    /**
     * The Function is get
     *
     * @param dst of Array<UInt8>
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func get(dst: Array<UInt8>): Buffer {
        return get(dst, 0, dst.size)
    }

    /**
     * The Function is put
     *
     * @param src of ByteBuffer
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public open func put(src: ByteBuffer) : ByteBuffer {
        if (src == this) {
            throw Exception() // createSameBufferException
        }
        if (this.isReadOnly()) {
            throw Exception() // ReadOnlyBufferException
        }
        let n = src.remaining()
        if (n > remaining()) {
            throw Exception() // BufferOverflowException
        }
        for (i in 0..n) {
            this.put(src.get())
        }
        return this
    } 

    /**
     * The Function is put
     *
     * @param src of Array<UInt8>
     * @param offset of Int64
     * @param length of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func put(src: Array<UInt8>, offset:Int64, length: Int64): Buffer {
        checkBounds(offset, length, src.size)
        if (length > super.remaining()) {
            throw Exception("length > super.remaining()")
        }
        let end = offset + length
        for (i in offset..end) {
            this.put(src[i])
        }
        return this
    }

    /**
     * The Function is put
     *
     * @param src of Array<UInt8>
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func put(src: Array<UInt8>): Buffer {
        return this.put(src, 0, src.size)
    }

    /**
     * The Function is hasArray
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasArray(): Bool {
        return false
    }

    // override
    /**
     * The Function is array
     *
     * @return Type of Array<UInt8>
     * @since 0.32.5
     */
    public override func array(): Array<UInt8> {
        return this.hb
    }

    /**
     * The Function is arrayOffset
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public override func arrayOffset(): Int64 {
        return this.offset
    }

    /**
     * The Function is position
     *
     * @param newPosition of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func position(newPosition: Int64): Buffer {
        super.position(newPosition)
        return this
    }

    /**
     * The Function is limit
     *
     * @param newLimit of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func limit(newLimit: Int64): Buffer {
        super.limit(newLimit)
        return this
    }

    /**
     * The Function is reset
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func reset(): Buffer {
        super.reset()
    }


    /**
     * The Function is clear
     *
     * @since 0.32.5
     */
    public override func clear () {
        super.clear()
        return this
    }

    /**
     * The Function is flip
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func flip(): Buffer {
        super.flip()
        return this
    }

    /**
     * The Function is rewind
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func rewind(): Buffer {
        super.rewind()
        return this
    }

    /**
     * The Function is compact
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public func compact(): ByteBuffer

    /**
     * The Function is toString
     *
     * @return Type of String
     * @since 0.32.5
     */
    public open func toString(): String {
        let sb = StringBuilder()
        sb.append("ByteBuffer: [pos=")
        sb.append(position())
        sb.append(" lim=")
        sb.append(limit())
        sb.append(" cap=")
        sb.append(capacity())
        sb.append("]")
        let src = sb.toString()
        sb.clear()
        return src
    }

    /**
     * The Function is hashCode
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    @overflowWrapping
    public open func hashCode(): Int64 {
        var h = 1
        var p = position()
        for (i in limit()-1..p:-1) {
            h = 31 * h + Int64(get(i))
        }
        return h
    }

    /**
     * The Function is ==
     *
     * @param that of Buffer
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public open operator func == (that: Buffer): Bool {
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
    public open operator func != (that: Buffer): Bool {
        return !refEq(this, that)
    }

    /**
     * The Function is slice
     *
     * @param pos of Int64
     * @param lim of Int64
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public func slice(pos: Int64, lim: Int64): ByteBuffer
    
}
