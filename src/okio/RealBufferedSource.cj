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

    public override func getBuffer (): Buffer {
        return this.buf
    }

    public override func read (sink: Buffer, byteCount: Int64): Int64 {
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
    }

    public override func exhausted (): Bool {
        if (closed) {
            throw IllegalArgumentException("closed")
        }
        return this.buf.exhausted() && this.source.read(this.buf, Segment.SIZE) == -1
    }

    public override func require(byteCount: Int64): Unit {
        if (!request(byteCount)) {
            throw EOFException()
        }
    }

    public override func request (byteCount: Int64): Bool {
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

    public override func readInt8(): Int8 {
        this.require(1)
        return buf.readInt8()
    }

    public override func readByteString (): ByteString {
        buf.writeAll(source)
        return buf.readByteString()
    }

    public override func readByteString (byteCount: Int64): ByteString {
        require(byteCount)
        return buf.readByteString()
    }

    // public func select (options: Options): Int32 {
    //     return 0
    // }

    public override func readByteArray (): Array<Byte> {
        buf.writeAll(source)
        return buf.readByteArray()
    }

    public override func readByteArray (byteCount: Int64): Array<Byte> {
        require(byteCount)
        return buf.readByteArray(byteCount)
    }

    public override func read(sink: Array<Byte>): Int64 {
        return read(sink, 0, sink.size)
    }

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

    public override func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64 {
        Util.checkOffsetAndCount(sink.size, offset, byteCount);
        if (this.buf.size == 0) {
            let read = source.read(this.buf, Segment.SIZE);
            if (read == -1) {
                return -1
            }
        }
        let toRead = math.min(byteCount, this.buf.size);
        return this.buf.read(sink, offset, toRead);
    }

    public override func read (sink: ByteBuffer): Int64 {
        if (this.buf.size == 0) {
            let read = source.read(this.buf, Segment.SIZE);
            if (read == -1) {
                return -1
            }
        }
        return this.buf.read(sink)
    }

    public override func readFully (sink: Buffer, byteCount: Int64): Unit {
        try {
            require(byteCount)
        } catch ( e: EOFException) {
            sink.writeAll(this.buf)
            throw e
        }
        this.buf.readFully(sink, byteCount)
    }

    public override func readAll(sink: Sink): Int64 {
        var totalBytesWritten = 0
        while (this.source.read(this.buf, Segment.SIZE) != -1) {
            let emitByteCount = this.buf.completeSegmentByteCount()
            if (emitByteCount > 0) {
                totalBytesWritten += emitByteCount
                sink.write(this.buf, emitByteCount)
            }
        }
        if (this.buf.size > 0) {
            totalBytesWritten += this.buf.size
            sink.write(this.buf, this.buf.size)
        }
        return totalBytesWritten
    }

    public override func readUtf8 (): ?String {
        this.buf.writeAll(source)
        return this.buf.readUtf8()
    }

    public override func readUtf8 (byteCount: Int64): ?String {
        require(byteCount)
        return this.buf.readUtf8(byteCount)
    }

    public override func readString (): ?String {
        this.buf.writeAll(source)
        return this.buf.readString()
    }

    // public func readString (byteCount: Int64, charset: Charset): String {
    //     return ""
    // }

    @overflowWrapping
    public override func readUtf8Line (): ?String {
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

    public override func readUtf8LineStrict (): ?String {
        return readUtf8LineStrict(Int64.Max)
    }

    public override func readUtf8LineStrict (limit: Int64): ?String {
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
            return this.buf.readUtf8Line(newLine)
        }
        if (scanLength < Int64.Max 
            && request(scanLength)
            && request(scanLength + 1)
            && this.buf.getInt8(scanLength - 1) == let_CR
            && this.buf.getInt8(scanLength) == let_LF) {
            return this.buf.readUtf8Line(scanLength)
        }
        let data = Buffer()
        this.buf.copyTo(data, 0, math.min(32, this.buf.size))
        throw EOFException("\\n not found: limit= ${math.min(this.buf.size, limit)} content= ${data.readByteString().hex()} …") 
    }

    public override func readUtf8CodePoint(): Int64 {
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

    public override func indexOf (b: Int8): Int64 {
        return indexOf(b, 0, Int64.Max)
    }

    public override func indexOf (b: Int8, fromIndex: Int64): Int64 {
        return indexOf(b, fromIndex, Int64.Max)
    }

    public override func indexOf (b: Int8, fromIndex: Int64, toIndex: Int64): Int64 {
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

    public override func indexOf (bytes: ByteString): Int64 {
        return indexOf(bytes, 0)
    }

    public override func indexOf (bytes: ByteString, fromIndex: Int64): Int64 {
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

    public override func indexOfElement (targetBytes: ByteString): Int64 {
        return indexOfElement(targetBytes, 0)
    }

    public override func indexOfElement (targetBytes: ByteString, fromIndex: Int64): Int64 {
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

    public override func rangeEquals(offset: Int64, bytes: ByteString): Bool {
        return rangeEquals(offset, bytes, 0, bytes.size)
    }
    
    public override func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool {
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

    public override func peek (): BufferedSource {
        return Okio.buffer(PeekSource(this))
    }

    // public func inputStream (): InputStream {
    //     return InputStream()
    // }

    public func isOpen (): Bool {
        return !this.closed
    }

    public override func close (): Unit {
        if (closed) {
            return
        }
        this.closed = true;
        source.close()
        this.buf.clear()
    }

    public override func timeout(): Timeout {
        return source.timeout()
    }

    public override func toString (): String {
        return "RealBufferedSource: ${this.buf.toString()}"
    }

    public override func isClosed(): Bool {
        return !isOpen()
    }
    
}