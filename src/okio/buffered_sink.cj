
package okio
// from std import io.*
from std import time.*

public interface BufferedSink <: Sink {
    func write(byteString: ByteString): BufferedSink
    func write(byteString: ByteString, offset: Int64, byteCount: Int64): BufferedSink
    // func write(source: Buffer): BufferedSink
    func write(source: Source, byteCount: Int64): BufferedSink
    // func write(source: Buffer, byteCount: Int64): Unit
    func writeAll(source: Source): Int64
    func writeUtf8(string: String): BufferedSink
    func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink
    func writeUtf8CodePoInt64(codePoInt64: Int64): BufferedSink
    // func writeString(string: String, charset: Charset): BufferedSink
    // func writeString(string: String, beginIndex: Int64, endIndex: Int64, charset: Charset): BufferedSink
    func writeInt8(value: Int8): BufferedSink
    func writeInt16(value: Int16): BufferedSink
    func writeInt16Le(value: Int16): BufferedSink
    func writeInt32(value: Int32): BufferedSink
    func writeInt32Le(value: Int32): BufferedSink
    func writeInt64(value: Int64): BufferedSink
    func writeInt64Le(value: Int64): BufferedSink
    func writeDecimalInt64(value: Int64): BufferedSink
    func writeHexadecimalUInt64(value: Int64): BufferedSink
    func flush(): Unit
    func emit(): BufferedSink
    // func outputStream(): OutputStream
}