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
    let diff = srcPos - destPos
    for (i in srcPos..srcPos + length) {
        dest[i - diff] = src[i]
    }
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
    public override func asReadOnlyBuffer():ByteBuffer {
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
        if (src.isDirect()) {
            throw Exception("not supported.")
        } else if (src is HeapByteBuffer) {
            if (src == this) {
                throw CreateSameBufferException()
            }
            let sb: HeapByteBuffer = match ((src as HeapByteBuffer)) {
                case None => throw NoneValueException()
                case Some (v) => v
            }
            let n = sb.remaining()
            if (n > remaining()) {
                throw Exception() // BufferOverflowException
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
}

public class CreateSameBufferException <: IllegalArgumentException {
    /**
     * The Function is init constructor
     *
     * @since 0.32.5
     */
    public init(){
        super("CreateSameBufferException: \n")
    }
}


