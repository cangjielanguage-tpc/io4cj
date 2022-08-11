
package okio
from std import io.*
from std import time.*

public interface BufferedSource <: Source {
    func getBuffer(): Buffer
    func exhausted(): Bool
    func require(byteCount: Int64): Unit
    func request(byteCount: Int64): Bool
    func read(sink: Array<Byte>): Int64
    // func read(sink: Buffer, byteCount: Int64): Int64
    func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64
    func readInt8(): Int8
    func readInt16(): Int16
    func readInt16Le(): Int16
    func readInt32(): Int32
    func readInt32Le(): Int32
    func readInt64(): Int64
    func readInt64Le(): Int64
    func readDecimalInt64(): Int64
    func readHexadecimalUInt64(): Int64
    func readByteString(): ByteString
    func readByteString(byteCount: Int64): ByteString
    func readByteArray(): Array<Byte>
    func readByteArray(byteCount: Int64): Array<Byte>
    func readFully(sink: Array<Byte>): Unit
    func readFully(sink: Array<Byte>, byteCount: Int64): Unit
    func readAll(sink: Sink): Int64
    func readUtf8(): String
    func readUtf8Line(): String
    func readUtf8LineStrict(): String
    func readUtf8LineStrict(limit: Int64): String
    func readUtf8CodePoint(): Int64
    func indexOf(value: Int8): Int64
    func indexOf(value: Int8, fromIndex: Int64): Int64
    func indexOf(value: Int8, fromIndex: Int64, toIndex: Int64): Int64
    func indexOf(bytes: ByteString): Int64
    func indexOf(bytes: ByteString, fromIndex: Int64): Int64
    func indexOfElement(targetBytes: ByteString): Int64
    func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64
    func rangeEquals(offset: Int64, bytes: ByteString): Bool
    func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool
    func skip(byteCount: Int64): Unit
    func peek(): BufferedSource
}