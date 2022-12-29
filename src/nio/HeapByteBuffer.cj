/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the HeapByteBuffer class.
 */
package nio

/**
 * The Function is ArrayCopy
 *
 * @param src of Array<Byte>
 * @param srcPos of Int64
 * @param dest of Array<Byte>
 * @param destPos of Int64
 * @param length of Int64
 * @since 0.32.5
 */
public func ArrayCopy(src: Array<Byte>, srcPos: Int64, dest: Array<Byte>, destPos: Int64, length: Int64) {
    src.copyTo(dest, srcPos, destPos, length)
}

/**
 * The class is HeapByteBuffer inherited from ByteBuffer & ToString
 * @author liyanqing14
 * @since 0.32.5
 */
public open class HeapByteBuffer <: ByteBuffer & ToString {

    init (cap: Int64, lim: Int64) {
        super (-1, 0, lim, cap, Array<Byte>(cap, item: 0), 0)
    }

    init (buf: Array<Byte>, off: Int64, len: Int64) {
        super (-1, off, off+len, buf.size, buf, 0)
    }

    protected init (buf: Array<Byte>, mark: Int64, pos: Int64, lim: Int64, cap: Int64, off: Int64) {
        super(mark, pos, lim, cap, buf, off)
    }

    /**
     * The Function is slice
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public override func slice(): ByteBuffer {
        return HeapByteBuffer(this.hb, -1, 0, this.remaining(), this.remaining(), this.position() + offset)
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
    public override func slice (pos: Int64, lim: Int64): ByteBuffer {
        let rem = lim - pos
        return HeapByteBuffer(hb, -1, 0, rem, rem, pos + offset)
    }

    /**
     * The Function is duplicate
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public override func duplicate(): ByteBuffer {
        return HeapByteBuffer(hb, this.markValue(), this.position(), this.limit(), this.capacity(), offset)
    }

    /**
     * The Function is asReadOnlyBuffer
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public override func asReadOnlyBuffer(): ByteBuffer {
        return HeapByteBuffer(hb, this.markValue(), this.position(), this.limit(), this.capacity(), offset)
    }

    /**
     * The Function is ix
     *
     * @param i of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func ix(i: Int64): Int64 {
        return i + offset
    }

    /**
     * The Function is get
     *
     * @return Type of Byte
     * @since 0.32.5
     */
    public override func get(): Byte {
        return hb[ix(nextGetIndex())]
    }

    /**
     * The Function is get
     *
     * @param i of Int64
     *
     * @return Type of Byte
     * @since 0.32.5
     */
    public override func get(i:Int64) : Byte {
        return hb[ix(checkIndex(i))]
    }

    /**
     * The Function is get
     *
     * @param dst of Array<Byte>
     * @param offset of Int64
     * @param length of Int64
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public override func get(dst: Array<Byte>, offset: Int64, length: Int64): ByteBuffer {
        checkBounds(offset, length, dst.size)
        if (length > this.remaining()) {
            throw Exception() // BufferUnderflowException
        }
        ArrayCopy(hb, ix(position()), dst, offset, length)
        position(position() + length)
        return this
    }

    /**
     * The Function is isDirect
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public override func isDirect(): Bool {
        return false
    }

    /**
     * The Function is isReadOnly
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public override func isReadOnly() : Bool {
        return false
    }

    /**
     * The Function is put
     *
     * @param x of Byte
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public override func put(x: Byte): ByteBuffer {
        hb[ix(nextGetIndex())] = x
        return this
    }

    /**
     * The Function is put
     *
     * @param i of Int64
     * @param x of Byte
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public override func put(i: Int64, x: Byte): ByteBuffer {
        hb[ix(checkIndex(i))] = x
        return this
    }


    /**
     * The Function is put
     *
     * @param src of Array<Byte>
     * @param offset of Int64
     * @param length of Int64
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public override func put(src: Array<Byte>, offset: Int64, length: Int64): ByteBuffer {
        checkBounds(offset, length, src.size)
        if (length > remaining()) {
            throw Exception() // BufferOverflowException
        }
        ArrayCopy(src, offset, hb, ix(position()), length)
        position(position() + length)
        return this
    }

    /**
     * The Function is put
     *
     * @param src of ByteBuffer
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public override func put(src: ByteBuffer): ByteBuffer {
        println("------------>0001")
        if (src.isDirect()) {
            throw Exception("not supported.")
        } else if (src is HeapByteBuffer) {
            if (src == this) {
                throw createSameBufferException()
            }
            let sb: HeapByteBuffer = match ((src as HeapByteBuffer)) {
                case None => throw NoneValueException()
                case Some (v) => v
            }
            let n = sb.remaining()
            if (n > remaining()) {
                throw BufferOverflowException() // BufferOverflowException
            }
            ArrayCopy(sb.hb, sb.ix(sb.position()), hb, ix(position()), n)
            sb.position(sb.position() + n )
            position(position() +n)
        } else {
            super.put(src)
        }
        return this
    }

    /**
     * The Function is compact
     *
     * @return Type of ByteBuffer
     * @since 0.32.5
     */
    public override func compact(): ByteBuffer {
        ArrayCopy(hb, ix(position()), hb, ix(0), remaining())
        position(remaining())
        limit(capacity())
        discardMark()
        return this
    }
    
    /**
     * The Function is putLong
     *
     * @param value of Int64
     *
     * @return Type of ByteBuffer
     * @since 0.33.3
     */
    @overflowWrapping
    public override func putLong(value: Int64): ByteBuffer {
        this.putUInt64(UInt64(value))
    }

    /**
     * The Function is putInt
     *
     * @param value of Int32
     *
     * @return Type of ByteBuffer
     * @since 0.33.3
     */
    @overflowWrapping
    public override func putInt(value: Int32): ByteBuffer {
        this.putUInt32(UInt32(value))
    }

    /**
     * The Function is putShort
     *
     * @param value of Int16
     *
     * @return Type of ByteBuffer
     * @since 0.33.3
     */
    @overflowWrapping
    public override func putShort(value: Int16): ByteBuffer {
        this.putUInt16(UInt16(value))
    }
    
    /**
     * The Function is getLong
     *
     * @return Type of Int64
     * @since 0.33.3
     */
    @overflowWrapping
    public override func getLong(): Int64 {
        return Int64(this.getUInt64())
    }

    /**
     * The Function is getInt
     *
     * @return Type of Int32
     * @since 0.33.3
     */
    @overflowWrapping
    public override func getInt(): Int32 {
        return Int32(this.getUInt32())
    }

    /**
     * The Function is getShort
     *
     * @return Type of Int16
     * @since 0.33.3
     */
    @overflowWrapping
    public override func getShort(): Int16 {
        return Int16(this.getUInt16())
    }

    @overflowWrapping
    public func putUInt64(value: UInt64): ByteBuffer {
        this.put(UInt8((value >> 56) & 0xff))
        this.put(UInt8((value >> 48) & 0xff))
        this.put(UInt8((value >> 40) & 0xff))
        this.put(UInt8((value >> 32) & 0xff))
        this.put(UInt8((value >> 24) & 0xff))
        this.put(UInt8((value >> 16) & 0xff))
        this.put(UInt8((value >> 8) & 0xff))
        this.put(UInt8(value & 0xff))
        return this
    }

    @overflowWrapping
    public func putUInt32(value: UInt32): ByteBuffer {
        this.put(UInt8((value >> 24) & 0xff))
        this.put(UInt8((value >> 16) & 0xff))
        this.put(UInt8((value >> 8) & 0xff))
        this.put(UInt8(value & 0xff))
        return this
    }

    @overflowWrapping
    public func putUInt16(value: UInt16): ByteBuffer {
        this.put(UInt8((value >> 8) & 0xff))
        this.put(UInt8(value & 0xff))
        return this
    }

    @overflowWrapping
    public func getUInt64(): UInt64 {
        return UInt64(this.get()) << 56 
            | UInt64(this.get()) << 48
            | UInt64(this.get()) << 40
            | UInt64(this.get()) << 32
            | UInt64(this.get()) << 24
            | UInt64(this.get()) << 16
            | UInt64(this.get()) << 8
            | UInt64(this.get())
    }

    @overflowWrapping
    public func getUInt32(): UInt32 {
        return UInt32(this.get()) << 24
            | UInt32(this.get()) << 16
            | UInt32(this.get()) << 8
            | UInt32(this.get())
    }

    @overflowWrapping
    public func getUInt16(): UInt16 {
        return UInt16(this.get()) << 8
            | UInt16(this.get())
    }

    /**
     * The Function is createSameBufferException
     *
     *
     * @return Type of IllegalArgumentException
     * @since 0.32.5
     */
     func createSameBufferException(): IllegalArgumentException {
        throw IllegalArgumentException("The source buffer is this buffer")
    }
}

public class BufferOverflowException <: Exception {
    /**
     * The Function is init constructor
     *
     * @since 0.32.5
     */
    public init() { 
        super("BufferOverflowException: \n")
    }
}
