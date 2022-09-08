package nio

public func ArrayCopy(src: Array<Byte>, srcPos: Int64, dest: Array<Byte>, destPos: Int64, length: Int64) {
    let diff = destPos - destPos
    for (i in srcPos..srcPos + length) {
        dest[i - diff] = src[i]
    }
}

public open class HeapByteBuffer <: ByteBuffer {

    init (cap: Int64, lim: Int64) {
        super (-1, 0, lim, cap, Array<Byte>(cap, item: 0), 0)
    }

    init (buf: Array<Byte>, off: Int64, len: Int64) {
        super (-1, off, off+len, buf.size, buf, 0)
    }

    protected init (buf: Array<Byte>, mark: Int64, pos: Int64, lim: Int64, cap: Int64, off: Int64) {
        super(mark, pos, lim, cap, buf, off)
    }

    public func slice(): ByteBuffer {
        return HeapByteBuffer(this.hb, -1, 0, this.remaining(), this.remaining(), this.position() + offset)
    }

    func slice (pos: Int64, lim: Int64): ByteBuffer {
        let rem = lim - pos
        return HeapByteBuffer(hb, -1, 0, rem, rem, pos + offset)
    }

    public func duplicate(): ByteBuffer {
        return HeapByteBuffer(hb, this.markValue(), this.position(), this.limit(), this.capacity(), offset)
    }

    public func asReadOnlyBuffer():ByteBuffer {
        return HeapByteBuffer(hb, this.markValue(), this.position(), this.limit(), this.capacity(), offset)
    }

    public func ix(i: Int64): Int64 {
        return i + offset
    }

    public func byteOffset(i: Int64): Int64 {
        return i
    }

    public func get(): Byte {
        return hb[ix(nextGetIndex())]
    }

    public func get(i:Int64) : Byte {
        return hb[ix(checkIndex(i))]
    }

    public override func get(dst: Array<Byte>, offset: Int64, length: Int64): ByteBuffer {
        checkBounds(offset, length, dst.size)
        if (length > this.remaining()) {
            throw Exception() // BufferUnderflowException
        }
        ArrayCopy(hb, ix(position()), dst, offset, length)
        position(position() + length)
        return this
    }

    public func isDirect(): Bool {
        return false
    }

    public func isReadOnly() : Bool {
        return false
    }

    public func put(x: Byte): ByteBuffer {
        hb[ix(nextGetIndex())] = x
        return this
    }

    public func put(i: Int64, x: Byte): ByteBuffer {
        hb[ix(checkIndex(i))] = x
        return this
    }


    public override func put(src: Array<Byte>, offset: Int64, length: Int64): ByteBuffer {
        checkBounds(offset, length, src.size)
        if (length > remaining()) {
            throw Exception() // BufferOverflowException
        }
        ArrayCopy(src, offset, hb, ix(position()), length)
        position(position() + length)
        return this
    }

    public override func put(src: ByteBuffer): ByteBuffer {
        if (src is HeapByteBuffer) {
            if (src == this) {
                throw Exception() // createSameBufferException
            }
            let sb: HeapByteBuffer = match ((src as HeapByteBuffer)) {
                case Some (v) => v
                case None => throw NoneValueException()
            }
            let n = sb.remaining()
            if (n > remaining()) {
                throw Exception() // BufferOverflowException
            }
            ArrayCopy(sb.hb, sb.ix(sb.position()), hb, ix(position()), n)
            sb.position(sb.position() + n )
            position(position() +n)
        } else if (src.isDirect()) {
            throw Exception("not supported.")
        } else {
            super.put(src)
        }
        return this
    }

    public open func compact(): ByteBuffer {
        ArrayCopy(hb, ix(position()), hb, ix(0), remaining())
        position(remaining())
        limit(capacity())
        discardMark()
        return this
    }

    func myGet(i : Int64): Byte {
        return hb[i]
    }

    func myPut(i: Int64, b: Byte) {
        hb[i] = b
    }

}

