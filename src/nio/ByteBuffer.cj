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
    
    init (mark: Int64, position: Int64, limits: Int64, capacity: Int64, hbs: Array<Byte>, offsets: Int64) {
        super(mark, position, limits, capacity)
        this.hb = hbs
        this.offset = offsets
    }

    /**
     * The Function is allocate
     *
     * @param capacity of Int64
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public static func allocate(capacitys: Int64): ByteBuffer {
        if (capacitys < 0) {
            throw IllegalArgumentException()
        }
        return HeapByteBuffer(capacitys, capacitys)
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
    public static func wrap(arrays: Array<UInt8>, offset: Int64, length: Int64): ByteBuffer {
        try{
            return HeapByteBuffer(arrays,offset,length)
        } catch (ex: IllegalArgumentException) {
            throw IndexOutOfBoundsException()
        }
    }

    /**
     * The Function is wrap
     *
     * @param array of Array<UInt8>
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public static func wrap(arrays: Array<UInt8>): ByteBuffer {
        return wrap(arrays, 0, arrays.size)
    }

    /**
     * The Function is slice
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func slice(): ByteBuffer

    /**
     * The Function is duplicate
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func duplicate(): ByteBuffer

    /**
     * The Function is asReadOnlyBuffer
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func asReadOnlyBuffer(): ByteBuffer

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
    public func put(bs: UInt8): ByteBuffer

    /**
     * The Function is get
     *
     * @param index of Int64
     *
     * @return Type of UInt8
     * @since 0.32.5
     */
    public func get(indexs: Int64): UInt8

    /**
     * The Function is put
     *
     * @param index of Int64
     * @param b of UInt8
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func put(indexs: Int64, b: UInt8): ByteBuffer

    public func putLong(val: Int64): ByteBuffer
    public func putInt(val: Int32): ByteBuffer
    public func putShort(val: Int16): ByteBuffer
    public func putUInt64(val: UInt64): ByteBuffer
    public func putUInt32(val: UInt32): ByteBuffer
    public func putUInt16(val: UInt16): ByteBuffer

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
    public func get(dst: Array<UInt8>, offset: Int64, length: Int64) : ByteBuffer

    /**
     * The Function is get
     *
     * @param dst of Array<UInt8>
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func get(dst: Array<UInt8>): ByteBuffer {
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
    public func put(src: ByteBuffer) : ByteBuffer 

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
    public func put(src: Array<UInt8>, offset:Int64, length: Int64): ByteBuffer 

    /**
     * The Function is put
     *
     * @param src of Array<UInt8>
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func put(srcs: Array<UInt8>): ByteBuffer {
        return this.put(srcs, 0, srcs.size)
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
    public override func position(newPosit: Int64): ByteBuffer {
        super.position(newPosit)
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
    public override func limit(newLim: Int64): ByteBuffer {
        super.limit(newLim)
        return this
    }

    /**
     * The Function is reset
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func reset(): ByteBuffer {
        super.reset()
        return this
    }


    /**
     * The Function is clear
     *
     * @since 0.32.5
     */
    public override func clear (): ByteBuffer {
        super.clear()
        return this
    }

    /**
     * The Function is flip
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func flip(): ByteBuffer {
        super.flip()
        return this
    }

    /**
     * The Function is rewind
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public override func rewind(): ByteBuffer {
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
        let sbd = StringBuilder()
        sbd.append("ByteBuffer: [offset=")
        sbd.append(this.offset)
        sbd.append(" mark=")
        sbd.append(this.mar)
        sbd.append(" pos=")
        sbd.append(position())
        sbd.append(" lim=")
        sbd.append(limit())
        sbd.append(" cap=")
        sbd.append(capacity())
        sbd.append("]")
        let src = sbd.toString()
        sbd.clear()
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
        var hc: Int32 = 1
        var p = position()
        for (i in limit()-1..=p:-1) {
            hc = 31 * hc + Int32(get(i))
        }
        return Int64(hc)
    }

    /**
     * The Function is ==
     *
     * @param that of Buffer
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public open operator func == (thats: Buffer): Bool {
        return refEq(this, thats)
    }
    /**
     * The Function is !=
     *
     * @param that of Buffer
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public open operator func != (thats: Buffer): Bool {
        return !refEq(this, thats)
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
    public func slice(pos: Int64, limit: Int64): ByteBuffer
    
}
