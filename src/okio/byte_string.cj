package okio

from std import collection.*
from std import format.*
from std import sync.*
from std import io.*
from std import math.*
from encoding import hex.*
from encoding import base64.*
//from crypto import enc.*
import nio.*

func toByteArray(str: String): Array<Byte> {
    let data: Array<Byte> = Array<Byte> (str.size + 1, {a => 0})
    for(i in 0..str.size) {
        data[i] = UInt8(UInt32(str[i]))
    }
    data
}

func compare(aval: Array<Byte>, fromIndex: Int64, bval: Array<Byte>): Bool{
    let asize: Int64 = aval.size
    let bsize: Int64 = bval.size
    if(asize - fromIndex < bsize) {
        return false
    }
    for(i in 0..asize) {
        if(aval[i + fromIndex] != bval[i]) {
            return false
        }
    }
    true
}

public open class ByteString <: Object & Hashable & ToString & Equatable<ByteString> {
    
    protected static let HEX_DIGITS: Array<Char> = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']

    // public static let EMPTY: ByteString = ByteString()
    
    let data: Array<Byte>

    protected var hashcode: Int64 = 0
    
    protected var utf8: String = ""
    
    public init (data: Array<Byte>){
        this.data = data
    }

    /**
     * Returns a new byte string containing a clone of the bytes of {@code data}.
     */
    public func of (data: Array<Byte>): ByteString {
        return ByteString(data.clone())
    }

    /**
     * Returns a new byte string containing a copy of {@code byteCount} bytes of {@code data} starting
     * at {@code offset}.
     */
    public func of(target: Array<Byte>, offset: Int64, byteCount: Int64): ByteString {
        let bytes: Array<Byte> = Array<Byte>(byteCount, item: 0)
        var i = 0
        while (i < byteCount) {
            bytes[i] = target[i + offset]
            i++
        }
        return ByteString(bytes)
    }

    // Returns a new byte string containing the {@code UTF-8} bytes of {@code s}. */
    public static func encodeUtf8(s: String): ByteString {
        let byteString = ByteString(s.toUtf8Array())
        byteString.utf8 = s
        return byteString
    }

    /** Constructs a new {@code String} by decoding the bytes as {@code UTF-8}. */
    public func UTF8(): String {
        if (utf8 == "") {
            return String.fromUtf8(this.data)
        }
        return utf8
    }

    /**
     * Returns this byte string encoded as <a
     * href="http://www.ietf.org/rfc/rfc2045.txt">Base64</a>. In violation of the
     * RFC, the returned string does not wrap lines at 76 columns.
     */
    public func base64 (): String {
        return toBase64String(this.data)
    }

    /**
     * Decodes the Base64-encoded bytes and returns their value as a byte string.
     * Returns null if {@code base64} is not a Base64-encoded sequence of bytes.
     */
    public static func decodeBase64 (base64: String): ?ByteString {
        match (fromBase64String(base64)) {
            case Some(arr) => return ByteString(arr)
            case None =>  return None
        }
    }

    /** Returns this byte string encoded in hexadecimal. */
    public func hex(): String {
        let chars: Array<Char> = Array<Char>(this.data.size * 2, item: ' ')
        var c = 0
        for (d in this.data) {
            chars[c] = HEX_DIGITS[Int64((d >> 4) & 0x0f)]
            c++
            chars[c] = HEX_DIGITS[Int64(d & 0x0f)]
            c++
        }
        return String(chars)
    }

    /** Decodes the hex-encoded bytes and returns their value a byte string. */
    public static func decodeHex(hex: String): ByteString {
        if (hex.size % 2 != 0) {
            throw IllegalArgumentException("Unexpected hex string: ${hex}")
        }
        return ByteString(fromHexString(hex).getOrThrow().clone())
    }

    private static func decodeHexDigit (c: Char): UInt32 {
        let uc = UInt32(c)
        if (uc >= UInt32('0') && uc <= UInt32('9')) {
            return uc - UInt32('0')
        }
        if (uc >= UInt32('a') && uc <= UInt32('f')) {
            return uc - UInt32('a') + 10
        }
        if (uc >= UInt32('A') && uc <= UInt32('F')) {
            return uc - UInt32('A') + 10
        }
        throw IllegalArgumentException("Unexpected hex digit: ${c}")
    }

    public static func read(input: InputStream, byteCount: Int64): ByteString {
        if (byteCount < 0) {
            throw IllegalArgumentException("byteCount < 0")
        }
        if (input.length < byteCount) {
            throw EOFException()
        }
        let arr = Array<Byte>(byteCount, item: 0)
        try {
            input.read(arr)
        } catch (e: Exception) {
            throw EOFException(e.toString())
        }
        return ByteString(arr)
    }

    public static func read(input: InputStream): ByteString {
        return read(input, input.length)
    }

    public static func read(path: String): ByteString {
        return read(File(path, Read, Open))
    }

    public func toAsciiLowercase (): ByteString {
        let arr = this.data.clone()
        var index = 0
        while (index < this.data.size) {
            arr[index] = UInt8(UInt32(Char(this.data[index]).toAsciiLowerCase()))
            index++
        }
        return ByteString(arr)
    }

    public func toAsciiUppercase (): ByteString {
        let arr = this.data.clone()
        var index = 0
        while (index < this.data.size) {
            arr[index] = UInt8(UInt32(Char(this.data[index]).toAsciiUpperCase()))
            index++
        }
        return ByteString(arr)
    }

    public func substring(beginIndex: Int64): ByteString {
        return substring(beginIndex, data.size)
    }

    public func substring(beginIndex: Int64, endIndex: Int64): ByteString {
        if (beginIndex < 0) {
            throw IllegalArgumentException("beginIndex < 0")
        }
        if (endIndex > this.data.size) {
            throw IllegalArgumentException("endIndex > size(${data.size})")
        }
        let subLen = endIndex - beginIndex
        if (subLen < 0 ) {
            throw IllegalArgumentException("endIndex < beginIndex")
        }
        if (beginIndex == 0 && endIndex == this.data.size) {
            return this
        }
        let copy = Array<Byte>(subLen, item: 0)
        nio.ArrayCopy(this.data, beginIndex, copy, 0, subLen)
        return ByteString(copy)
    }

    public func getByte (pos: Int64): Byte {
        return this.data[pos]
    }

    public prop let size: Int64 {
        get () {
            return this.data.size
        }
    }

    public func toByteArray (): Array<Byte> {
        return this.data.clone()
    }

    func internalArray(): Array<Byte> {
        return this.data
    }

    public func write (outPath: String, mode!: OpenMode = Append): Unit {
        write(File(outPath, Write, mode))
    }

    public func write (out: OutputStream): Unit {
        out.write(this.data)
    }

    public func write (buffer: Buffer) {
        buffer.write(this.data, 0, data.size)
    }

    public func rangeEquals(offset: Int64, other: ByteString, otherOffset: Int64, byteCount: Int64): Bool {
        return other.rangeEquals(otherOffset, this.data, offset, byteCount)
    }

    public func rangeEquals(offset: Int64, other: Array<Byte>, otherOffset: Int64, byteCount: Int64): Bool {
        return offset >= 0 && offset <= data.size - byteCount
        && otherOffset >= 0 && otherOffset <= other.size - byteCount
        && Util.arrayRangeEquals(data, offset, other, otherOffset, byteCount)
    }

    public func startsWith(prefix: ByteString): Bool {
        return rangeEquals(0, prefix, 0, prefix.size)
    }

    public func startsWith(prefix: Array<Byte>): Bool {
        return rangeEquals(0, prefix, 0, prefix.size)
    }   

    public func endsWith (suffix: ByteString):Bool {
        return rangeEquals(this.size - suffix.size, suffix, 0, suffix.size)
    }

    public func endsWith (suffix:Array<Byte>) :Bool {
        return rangeEquals(this.size - suffix.size, suffix, 0, suffix.size)
    }

    public func indexOf(other: ByteString): Int64 {
        return indexOf(other.internalArray(), 0)
    }

    public func indexOf(other: ByteString, fromIndex: Int64): Int64 {
        return indexOf(other.internalArray(), fromIndex)
    }

    public func indexOf(other: Array<Byte>): Int64 {
        return indexOf(other, 0)
    }

    public func indexOf(other: Array<Byte>, fromIndex: Int64): Int64 {
        for (i in max(fromIndex, 0)..data.size-other.size where Util.arrayRangeEquals(this.data, i, other, 0, other.size)) {
            return i
        }
        return -1
    }

    public func lastIndexOf(other: ByteString) : Int64 {
        return lastIndexOf(other.internalArray(), this.size)
    }

    public func lastIndexOf(other: ByteString, fromIndex: Int64): Int64 {
        return lastIndexOf(other.internalArray(), fromIndex)
    }

    public func lastIndexOf(other: Array<Byte>): Int64 {
        return lastIndexOf(other, this.size)
    }

    public func lastIndexOf(other: Array<Byte>, fromIndex: Int64): Int64 {
        for (i in min(fromIndex, data.size - other.size)..=0:-1 where Util.arrayRangeEquals(this.data, i, other, 0, other.size)) {
            return i
        }
        return -1
    }

    public operator func == (that: ByteString): Bool {
        return refEq(this, that)
    }

    public operator func != (that: ByteString): Bool {
        return !refEq(this, that)
    }

    public func equals (o: ByteString): Bool {
        return this == o
    }

    public func hashCode (): Int64 {
        return Util.hashCode(this.data)
    }

    public func toString (): String {
        if ( this.data.size == 0) {
            return "[size=0]"
        }
        let text = UTF8()
        let safeText = text.replace("\\", "\\\\")
                            .replace("\n", "\\n")
                            .replace("\r", "\\r")
        return "[text=${safeText}]"
    }

}


