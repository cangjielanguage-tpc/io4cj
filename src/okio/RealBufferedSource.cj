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

    public func readUtf8 (): String {
        return ""
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

    public func readUtf8Line (): String {
        return ""
    }

    public func readUtf8LineStrict (): String {
        return ""
    }

    public func readUtf8LineStrict (limit: Int64): String {
        return ""
    }

    public func readUtf8CodePoint(): Int64 {
        return 0
    }

    public func readInt16 (): Int16 {
        return 0
    }

    public func readInt16Le (): Int16 {
        return 0
    }

    public func readInt32 (): Int32 {
        return 0
    }

    public func readInt32Le (): Int32 {
        return 0
    }

    public func readInt64 (): Int64 {
        return 0
    }

    public func readInt64Le (): Int64 {
        return 0
    }

    public func readDecimalInt64(): Int64 { 
        0
    }
    public func readHexadecimalUInt64(): Int64 {
        0
    }

    public func skip (byteCount: Int64): Unit {
        
    }

    public func indexOf (b: Int8): Int64 {
        return 0
    }

    public func indexOf (b: Int8, fromIndex: Int64): Int64 {
        return 0
    }

    public func indexOf (b: Int8, fromIndex: Int64, toIndex: Int64): Int64 {
        return 0
    }

    public func indexOf (bytes: ByteString): Int64 {
        return 0
    }

    public func indexOf (bytes: ByteString, fromIndex: Int64): Int64 {
        return 0
    }

    public func indexOfElement (targetBytes: ByteString): Int64 {
        return 0
    }

    public func indexOfElement (targetBytes: ByteString, fromIndex: Int64): Int64 {
        return 0
    }

    public func rangeEquals(offset: Int64, bytes: ByteString): Bool {
        return true
    }
    
    public func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool {
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
        return ""
    }

    public func isClosed(): Bool {
        return false
    }
    
}