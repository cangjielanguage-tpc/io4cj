package okio
from std import collection.*

public class Buffer <: BufferedSource & BufferedSink {
    public func write(source: Buffer, byteCount: Int64): Unit {
        
    }
    public func write(byteString: ByteString): BufferedSink {
        this
    }

    public func write(byteString: ByteString, offset: Int64, byteCount: Int64): BufferedSink {
        this
    }

    public func write(source: Buffer): BufferedSink {
        this
    }

    public func write(source: Array<Byte>, offset: Int64, byteCount: Int64): Int64 {
        0
    }

    public func writeAll(source: Source): Int64 {
        0
    }

    public func write(source: Source, byteCount: Int64): BufferedSink {
        this
    }

    public func writeUtf8(string: String): BufferedSink {
        this
    }

    public func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink {
        this
    }

    public func writeUtf8CodePoInt64(codePoInt64: Int64): BufferedSink {
        this
    }

    public func writeByte(value: Int64): BufferedSink {
        this
    }

    public func writeInt16(value: Int64): BufferedSink {
        this
    }

    public func writeInt16Le(value: Int64): BufferedSink {
        this
    }

    public func writeInt64(value: Int64): BufferedSink {
        this
    }

    public func writeInt64Le(value: Int64): BufferedSink {
        this
    }

    public func writeDecimalInt64(value: Int64): BufferedSink {
        this
    }

    public func writeHexadecimalUInt64(value: Int64): BufferedSink {
        this
    }

    public func flush(): Unit {

    }

    public func emit(): BufferedSink {
        this
    }

    public func exhausted(): Bool {
        true
    }

    public func require(byteCount: Int64): Unit {

    }

    public func request(byteCount: Int64): Bool {
        true
    }

    public func readByte(): Byte {
        0
    }

    public func readInt16(): Int16 {
        0
    }

    public func readInt16Le(): Int16 {
        0
    }

    public func readInt32(): Int32 {
        0
    }

    public func readInt32Le(): Int32 {
        0
    }

    public func readInt64(): Int64 {
        0
    }

    public func readInt64Le(): Int64 {
        0
    }

    public func readDecimalInt64(): Int64 {
        0
    }

    public func readHexadecimalUInt64(): Int64 {
        0
    }


    public func readByteString(): ByteString {
        ByteString()
    }

    public func readByteString(byteCount: Int64): ByteString {
        ByteString()
    }

    public func readByteArray(): Array<Byte> {
        Array<Byte>()
    }

    public func readByteArray(byteCount: Int64): Array<Byte> {
        Array<Byte>()
    }

    public func read(sink: Array<Byte>): Int64 {
        0
    }
    public func read(sink: Buffer, byteCount: Int64): Int64 {
        0
    }
    public func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64 {
        0
    }

    public func read(sink: Array<Byte>, byteCount: Int64): Int64 {
        0
    }

    public func readFully(sink: Array<Byte>): Unit {

    }

    public func readFully(sink: Array<Byte>, byteCount: Int64): Unit {

    }

    public func readAll(sink: Sink): Int64 {
        0
    }

    public func readUtf8(): String {
        ""
    }

    public func readUtf8Line(): String {
        ""
    }

    public func readUtf8LineStrict(): String {
        ""
    }

    public func readUtf8LineStrict(limit: Int64): String {
        ""
    }

    public func readUtf8CodePoint(): Int64 {
        0
    }

    public func indexOf(value: Byte): Int64 {
        0
    }

    public func indexOf(value: Byte, fromIndex: Int64): Int64 {
        0
    }

    public func indexOf(value: Byte, fromIndex: Int64, toIndex: Int64): Int64 {
        0
    }

    public func indexOf(bytes: ByteString): Int64 {
        0
    }

    public func indexOf(bytes: ByteString, fromIndex: Int64): Int64 {
        0
    }

    public func indexOfElement(targetBytes: ByteString): Int64 {
        0
    }

    public func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64 {
        0
    }

    public func rangeEquals(offset: Int64, bytes: ByteString): Bool {
        true
    }

    public func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool {
        true
    }

    public func skip(byteCount: Int64): Unit {

    }

    public func peek(): BufferedSource {
        this
    }

    public func seek(l: Int64, pos: SeekOrigin): Int64 {
        0
    }

    public func close(): Unit {

    }

    public func timeout(): Duration {
        Duration.second()
    }


}
