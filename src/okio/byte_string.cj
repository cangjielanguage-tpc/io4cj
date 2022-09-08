package okio

from std import collection.*
from std import format.*
from std import sync.*
from std import io.*
from encoding import hex.*
from encoding import base64.*
//from crypto import enc.*


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

public open class ByteString <: Hashable & ToString {
    
    protected static var lock: ReentrantMutex = ReentrantMutex()
    
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
    // public static func encodeUtf8(s: String): ByteString {
    // }

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

    public static func read (input: InputStream, byteCount: Int64): ByteString {
        if (input.length != byteCount) {
            throw IllegalArgumentException()
        }
        synchronized(lock) {
            let arr = Array<Byte>(byteCount, item: 0)
            input.read(arr)
            return ByteString(arr)
        }
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

    public func getByte (pos: Int64): Byte {
        return this.data[pos]
    }

    public func size(): Int64 {
        return this.data.size
    }

    public func toByteArray (): Array<Byte> {
        return this.data.clone()
    }

    public func write (out: OutputStream): Unit {
        out.write(this.data)
    }

    public func equals (o: ByteString): Bool {
        return true  // TODO
    }

    public func hashCode (): Int64 {
        return 0   //TODO
    }

    public func toString (): String {
        return ""  // TODO
    }

//    private func readObject (`in`: ObjectInputStream): Unit {
//
//    }

//    private func writeObject (out: ObjectOutputStream): Unit {
//
//    }

//    public init() {}
}


