package okio


class RealBufferedSource <: BufferedSource {

    public let buf: Buffer = Buffer()
    
    public let source: Source
    
    var closed: Bool = false
    
    public init (source: Source){
        this.source = source
    }

    public func buffer (): Buffer {
        return this.buf
    }

    public func getBuffer (): Buffer {
        return this.buf
    }

    public func read (sink: Buffer, byteCount: Int64): Int64 {
        if (byteCount <0) {
            throw IllegalArgumentException("byteCount <0: ${byteCount}")
        }
        if (closed) {
            throw IllegalArgumentException("closed")
        }
        if (this.buf.size == 0) {
            let read = this.source.read(this.buf, Segment.SIZE)
            if (read == -1) {
                return -1
            }
        }
        let toRead = min(byteCount, this.buf.size)
        return this.buf.read(sink, toRead)
        return 0
    }

    public func exhausted (): Bool {
        if (closed) {
            throw IllegalArgumentException("closed")
        }
        return this.buf.exhausted() && this.source.read(this.buf, Segment.SIZE) == -1
    }

    public func require(byteCount: Int64): Unit {
        if (!request(byteCount)) {
            throw EOFException()
        }
    }

    public func request (byteCount: Int64): Bool {
        if (byteCount <0) {
            throw IllegalArgumentException("byteCount <0: ${byteCount}")
        }
        if (closed) {
            throw IllegalArgumentException("closed")
        }
        while (this.buf.size < byteCount) {
            if (source.read(this.buf, Segment.SIZE) == -1){
                return false
            }
        }
        return true
    }

    public func readInt8(): Int8 {
        this.require(1)
        return buf.readInt8()
    }

    public func readByteString (): ByteString {
        buf.writeAll(source)
        return buf.readByteString()
    }

    public func readByteString (byteCount: Int64): ByteString {
        require(byteCount)
        return buf.readByteString()
    }

    // public func select (options: Options): Int32 {
    //     return 0
    // }

    public func readByteArray (): Array<Byte> {
        buf.writeAll(source)
        return buf.readByteArray()
    }

    public func readByteArray (byteCount: Int64): Array<Byte> {
        require(byteCount)
        return buf.readByteArray(byteCount)
    }

    public func read(sink: Array<Byte>): Int64 {
        return 0
    }

    public func read(sink: ByteBuffer): Int64 {
        return 0
    }

    public func readFully(sink: Array<Byte>): Unit {
        
    }

    public func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64 {
        return 0
    }

    // public func read (sink: ByteBuffer): Int32 {
    //     return 0
    // }

    public func readFully (sink: Buffer, byteCount: Int64): Unit {
        
    }

    public func readAll(sink: Sink): Int64 {
        return 0
    }

    public func readUtf8 (): ?String {
        return None
    }

    public func readUtf8 (byteCount: Int64): String {
        return ""
    }

    // public func readString (charset: Charset): String {
    //     return ""
    // }

    // public func readString (byteCount: Int64, charset: Charset): String {
    //     return ""
    // }

    @overflowWrapping
    public func readUtf8Line (): ?String {
        let newline = indexOf(Int8(UInt32('\n')))
        if (newline == -1) {
            return if (this.buf.size != 0 ) {
                return readUtf8(this.buf.size)
            } else {
                return None
            }
        }
        return this.buf.readUtf8Line(newline)
    }

    public func readUtf8LineStrict (): ?String {
        return None
    }

    public func readUtf8LineStrict (limit: Int64): ?String {
        return None
    }

    public func readUtf8CodePoint(): Int64 {
        require(1)
        let b0: Int8 = this.buf.getInt8(0)
        if ((UInt8(b0) & 0xe0) == 0xc0) {
            require(2)
        } else if ((UInt8(b0) & 0xf0) == 0xe0) {
            require(3)
        } else if ((UInt8(b0) & 0xf8) == 0xf0) {
            require(4)
        }
        return this.buf.readUtf8CodePoint()
    }

    public override func readInt16 (): Int16 {
        require(2)
        return this.buf.readInt16()
    }

    public override func readInt16Le (): Int16 {
        require(2)
        return this.buf.readInt16Le()
    }

    public override func readInt32 (): Int32 {
        require(4)
        return this.buf.readInt32()
    }

    public override func readInt32Le (): Int32 {
        require(4)
        return this.buf.readInt32Le()
    }

    public override func readInt64 (): Int64 {
        require(8)
        return this.buf.readInt64()
    }

    public override func readInt64Le (): Int64 {
        require(8)
        return this.buf.readInt64Le()
    }

    public override func readDecimalInt64(): Int64 { 
        require(1)
        var pos = 0
        while (request(pos + 1)) {
            let b = UInt8(this.buf.getInt8(pos))
            if ((b < let_0 || b > let_9) && (pos != 0 || b != let__)) {
                if (pos == 0) {
                    throw NumberFormatException("")
                }
                break
            }
            pos ++
        }
        return this.buf.readDecimalInt64()
    }
    public override func readHexadecimalUInt64(): Int64 {
        require(1)
        var pos = 0
        while (request(pos + 1)) {
            let b = UInt8(this.buf.getInt8(pos))
            if ((b < let_0 || b > let_9) && (b < let_a || b > let_f) && (b < let_A || b > let_F)) {
                if (pos == 0) {
                    throw NumberFormatException("")
                }
                break
            }
            pos ++
        }
        return this.buf.readHexadecimalUInt64()
    }

    public override func skip (byteCount: Int64): Unit {
        if (closed) {
            throw IllegalStateException("closed")
        }
        var byteCount = byteCount
        while (byteCount > 0) {
            if (this.buf.size == 0 && source.read(this.buf, Segment.SIZE) == -1) {
                throw EOFException()
            }
            let toSkip = math.min(byteCount, this.buf.size);
            this.buf.skip(toSkip);
            byteCount -= toSkip;
        }
    }

    public func indexOf (b: Int8): Int64 {
        return indexOf(b, 0, Int64.Max)
    }

    public func indexOf (b: Int8, fromIndex: Int64): Int64 {
        return indexOf(b, fromIndex, Int64.Max)
    }

    public func indexOf (b: Int8, fromIndex: Int64, toIndex: Int64): Int64 {
        var fromIndex = fromIndex
        if (closed) {
            throw IllegalStateException("closed")
        }
        if (fromIndex < 0 || toIndex < fromIndex) {
            throw  IllegalArgumentException("fromIndex=${fromIndex} toIndex=${toIndex}")
        }
        while (fromIndex < toIndex) {
            let result = this.buf.indexOf(b, fromIndex, toIndex)
            if (result != -1) {
                return result
            }
            let lastBufferSize = this.buf.size
            if (lastBufferSize >= toIndex || source.read(this.buf, Segment.SIZE) == -1){
                 return -1
            }
            fromIndex = math.max(fromIndex, lastBufferSize)
        }
        return -1
    }

    public func indexOf (bytes: ByteString): Int64 {
        return indexOf(bytes, 0)
    }

    public func indexOf (bytes: ByteString, fromIndex: Int64): Int64 {
        var fromIndex = fromIndex
        if (closed) {
            throw IllegalStateException("closed")
        }
        while (true) {
            let result = this.buf.indexOf(bytes, fromIndex)
            if (result != -1) {
                return result
            }

            let lastBufferSize = this.buf.size
            if (source.read(this.buf, Segment.SIZE) == -1) {
                return -1
            }
            fromIndex = math.max(fromIndex, lastBufferSize - bytes.size + 1)
        }
        return -1
    }

    public func indexOfElement (targetBytes: ByteString): Int64 {
        return indexOfElement(targetBytes, 0)
    }

    public func indexOfElement (targetBytes: ByteString, fromIndex: Int64): Int64 {
        var fromIndex = fromIndex
        if (closed) {
            throw IllegalStateException("closed")
        }
        while (true) {
            let result = this.buf.indexOfElement(targetBytes, fromIndex)
            if (result != -1) {
                return result
            }

            let lastBufferSize = this.buf.size
            if (source.read(this.buf, Segment.SIZE) == -1)  {
                return -1
            }
            fromIndex = math.max(fromIndex, lastBufferSize)
        }
        return 0
    }

    public func rangeEquals(offset: Int64, bytes: ByteString): Bool {
        return rangeEquals(offset, bytes, 0, bytes.size)
    }
    
    public func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool {
        if (closed) {
            throw IllegalStateException("closed")
        }
        if (offset < 0 || bytesOffset < 0 || byteCount < 0 || bytes.size - bytesOffset < byteCount) {
            return false;
        }
        for(i in 0..byteCount) {
            let bufferOffset = offset + i
            if (!request(bufferOffset + 1)) {
                return false
            }
            if (this.buf.getInt8(bufferOffset) != Int8(bytes.getByte(bytesOffset + i))) {
                return false
            }
        }
        return true
    }

    public func peek (): BufferedSource {
        return Okio.buffer(PeekSource(this))
    }

    // public func inputStream (): InputStream {
    //     return InputStream()
    // }

    public func isOpen (): Bool {
        return true
    }

    public func close (): Unit {
        
    }

    public func timeout(): Timeout {
        return Timeout()  // TODO
    }

    public func toString (): String {
        return "buffer(source)"
    }

    public func isClosed(): Bool {
        return false
    }
    
}