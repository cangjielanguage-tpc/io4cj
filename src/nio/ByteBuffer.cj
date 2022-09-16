package nio

from std import collection.StringBuilder

public abstract class ByteBuffer <: Buffer & ToString & Hashable & Equatable<Buffer>  {

    let hb: Array<Byte> 

    let offset: Int64
    
    init (mark: Int64, position: Int64, limit: Int64, capacity: Int64, hbs: Array<Byte>, offset: Int64) {
        super(mark, position, limit, capacity)
        if (capacity != hbs.size) {
            throw Exception("capacity != hbs.size")
        }
        this.hb = hbs
        this.offset = offset
    }

    init (mark: Int64, position: Int64, limit: Int64, capacity: Int64, offset: Int64) {
        super(mark, position, limit, capacity)
        this.hb = Array<Byte>()
        this.offset = offset
    }

    func base(): Array<UInt8> {
        return this.hb
    }

    public static func allocateDirect(capacity: Int64) /* : Buffer */ {
        // TODO
    }

    public static func allocate(capacity: Int64): ByteBuffer {
        if (capacity < 0) {
            throw IllegalArgumentException()
        }
        return HeapByteBuffer(capacity, capacity)
    }

    public static func wrap(array: Array<UInt8>, offset: Int64, length: Int64): ByteBuffer {
        return HeapByteBuffer(array, offset, length);
    }

    public static func wrap(array: Array<UInt8>): ByteBuffer {
        return wrap(array, 0, array.size)
    }

    public func slice(): Buffer;
    
    public func duplicate(): Buffer;
    
    public func asReadOnlyBuffer(): Buffer;
    
    public func get(): UInt8;
    
    public func put(b: UInt8): Buffer;
    
    public func get(index: Int64): UInt8;
    
    public func put(index: Int64, b: UInt8): Buffer;

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

    public open func get(dst: Array<UInt8>): Buffer {
        return get(dst, 0, dst.size)
    }

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

    public open func put(src: Array<UInt8>): Buffer {
        return this.put(src, 0, src.size)
    }

    public open func hasArray(): Bool {
        // return  // 感觉不需要实现
        return false
    }

    // override
    // public func array(): Array<UInt8> {
    //     return this.hb
    // }

    public open func arrayOffset(): Int64 {
        return this.offset
    }

    public override func position(newPosition: Int64): Buffer {
        super.position(newPosition)
        return this
    }

    public override func limit(newLimit: Int64): Buffer {
            super.limit(newLimit)
        return this
    }

    public override func reset(): Buffer {
        super.reset()
    }


    public override func clear () {
        super.clear()
        return this
    }

    public override func flip(): Buffer {
        super.flip();
        return this;
    }

    public override func rewind(): Buffer {
        super.rewind();
        return this;
    }

    func compact(): Buffer

    public open func toString(): String {

        let sb = StringBuilder()
        // sb.append(hb.toString()+"   || ")
        sb.append("ByteBuffer: [pos=")
        sb.append(position());
        sb.append(" lim=");
        sb.append(limit());
        sb.append(" cap=");
        sb.append(capacity());
        sb.append("]");
        let src = sb.toString()
        sb.clear()
        return src
    }

    public open func hashCode(): Int64 {
        var h = 1
        var p = position()
        for (i in limit()-1..p:-1) {
            h = 31 * h + Int64(get(i))
        }
        return h
    }

    public open operator func == (that: Buffer): Bool {
        return refEq(this, that)
    }
    public open operator func != (that: Buffer): Bool {
        return !refEq(this, that)
    }

    // public func compareTo(): Bool
    // public final ByteOrder order()
    // public final ByteBuffer order(ByteOrder bo) {
    public func alignedSlice(unitSize: Int64): ByteBuffer {
        var pos = position()
        var lim = limit()
        // var pos_mod = 
        return this
    }

    func slice(pos: Int64, lim: Int64): Buffer;
    
}
