/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the ByteString class.
 */
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

/**
 * The class is ByteString inherited from Object & Hashable & ToString & Equatable<ByteString>
 * @author liyanqing14
 * @since 0.32.5
 */
public open class ByteString <: Object & Hashable & ToString & Equatable<ByteString> {
    
    protected static let HEX_DIGITS: Array<Char> = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']

    // public static let EMPTY: ByteString = ByteString()
    
    let data: Array<Byte>

    protected var hashcode: Int64 = 0
    
    protected var utf8: String = ""

    /**
     * The Function is init constructor
     *
     * @param data of Array<Byte>
     * @since 0.32.5
     */
    public init (data: Array<Byte>){
        this.data = data
    }

    /**
     * The Function is of
     *
     * @param data of Array<Byte>
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public static func of (data: Array<Byte>): ByteString {
        return ByteString(data.clone())
    }

    /**
     * The Function is of
     *
     * @param target of Array<Byte>
     * @param offset of Int64
     * @param byteCount of Int64
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public static func of(target: Array<Byte>, offset: Int64, byteCount: Int64): ByteString {
        let bytes: Array<Byte> = Array<Byte>(byteCount, item: 0)
        var i = 0
        while (i < byteCount) {
            bytes[i] = target[i + offset]
            i++
        }
        return ByteString(bytes)
    }

    /**
     * The Function is encodeUtf8
     *
     * @param s of String
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    // Returns a new byte string containing the {@code UTF-8} bytes of {@code s}. */
    public static func encodeUtf8(s: String): ByteString {
        let byteString = ByteString(s.toUtf8Array())
        byteString.utf8 = s
        return byteString
    }

    /**
     * The Function is UTF8
     *
     * @return Type of String
     * @since 0.32.5
     */
    /** Constructs a new {@code String} by decoding the bytes as {@code UTF-8}. */
    public func UTF8(): String {
        if (utf8 == "") {
            return unsafe {String.fromUtf8Unchecked(this.data)}
        }
        return utf8
    }


    /**
     * The Function is base64
     *
     * @return Type of String
     * @since 0.32.5
     */
    public func base64 (): String {
        return toBase64String(this.data)
    }


    /**
     * The Function is decodeBase64
     *
     * @param base64 of String
     *
     * @return Type of ?ByteString
     * @since 0.32.5
     */
    public static func decodeBase64 (base64: String): ?ByteString {
        match (fromBase64String(base64)) {
            case Some(arr) => return ByteString(arr)
            case None =>  return None
        }
    }


    /**
     * The Function is hex
     *
     * @return Type of String
     * @since 0.32.5
     */
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


    /**
     * The Function is decodeHex
     *
     * @param hex of String
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public static func decodeHex(hex: String): ByteString {
        if (hex.size % 2 != 0) {
            throw IllegalArgumentException("Unexpected hex string: ${hex}")
        }
        return ByteString(fromHexString(hex).getOrThrow().clone())
    }

    /**
     * The Function is read
     *
     * @param input of InputStream
     * @param byteCount of Int64
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
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

    /**
     * The Function is read
     *
     * @param input of InputStream
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public static func read(input: InputStream): ByteString {
        return read(input, input.length)
    }

    /**
     * The Function is read
     *
     * @param path of String
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public static func read(path: String): ByteString {
        return read(File(path, Open(true, false)))
    }

    /**
     * The Function is toAsciiLowercase
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public func toAsciiLowercase (): ByteString {
        let arr = this.data.clone()
        var index = 0
        while (index < this.data.size) {
            arr[index] = UInt8(UInt32(Char(this.data[index]).toAsciiLowerCase()))
            index++
        }
        return ByteString(arr)
    }

    /**
     * The Function is toAsciiUppercase
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public func toAsciiUppercase (): ByteString {
        let arr = this.data.clone()
        var index = 0
        while (index < this.data.size) {
            arr[index] = UInt8(UInt32(Char(this.data[index]).toAsciiUpperCase()))
            index++
        }
        return ByteString(arr)
    }

    /**
     * The Function is substring
     *
     * @param beginIndex of Int64
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public func substring(beginIndex: Int64): ByteString {
        return substring(beginIndex, data.size)
    }

    /**
     * The Function is substring
     *
     * @param beginIndex of Int64
     * @param endIndex of Int64
     *
     * @return Type of ByteString
     * @since 0.32.5
     */
    public func substring(beginIndex: Int64, endIndex: Int64): ByteString {
        if (beginIndex < 0) {
            throw IllegalArgumentException("beginIndex < 0")
        }
        if (endIndex > this.data.size) {
            throw IllegalArgumentException("endIndex > size(${data.size})")
        }
        let subLen = endIndex - beginIndex
        if (subLen < 0 ) {
            throw IllegalArgumentException("endIndex : ${endIndex} < beginIndex : ${beginIndex}")
        }
        if (beginIndex == 0 && endIndex == this.data.size) {
            return this
        }
        let copy = Array<Byte>(subLen, item: 0)
        nio.ArrayCopy(this.data, beginIndex, copy, 0, subLen)
        return ByteString(copy)
    }

    /**
     * The Function is getByte
     *
     * @param pos of Int64
     *
     * @return Type of Byte
     * @since 0.32.5
     */
    public func getByte (pos: Int64): Byte {
        return this.data[pos]
    }

    /**
     * let member size type is Int64 {
     * @since 0.32.5
     */
    public prop let size: Int64 {
        get () {
            return this.data.size
        }
    }

    /**
     * The Function is toByteArray
     *
     * @return Type of Array<Byte>
     * @since 0.32.5
     */
    public func toByteArray (): Array<Byte> {
        return this.data.clone()
    }

    func internalArray(): Array<Byte> {
        return this.data
    }

    /**
     * The Function is write
     *
     * @param outPath of String
     * @param mode of OpenMode, and the Default value is Append
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public func write (outPath: String): Unit {
        write(File(outPath, OpenOption.CreateOrAppend))
        // write(File(outPath, Write, mode))
    }

    /**
     * The Function is write
     *
     * @param out of OutputStream
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public func write (out: OutputStream): Unit {
        out.write(this.data)
    }

    /**
     * The Function is write
     *
     * @param buffer of Buffer
     * @since 0.32.5
     */
    public func write (buffer: Buffer) {
        buffer.write(this.data, 0, data.size)
    }

    /**
     * The Function is rangeEquals
     *
     * @param offset of Int64
     * @param other of ByteString
     * @param otherOffset of Int64
     * @param byteCount of Int64
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public func rangeEquals(offset: Int64, other: ByteString, otherOffset: Int64, byteCount: Int64): Bool {
        return other.rangeEquals(otherOffset, this.data, offset, byteCount)
    }

    /**
     * The Function is rangeEquals
     *
     * @param offset of Int64
     * @param other of Array<Byte>
     * @param otherOffset of Int64
     * @param byteCount of Int64
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public func rangeEquals(offset: Int64, other: Array<Byte>, otherOffset: Int64, byteCount: Int64): Bool {
        return offset >= 0 && offset <= data.size - byteCount
        && otherOffset >= 0 && otherOffset <= other.size - byteCount
        && Util.arrayRangeEquals(data, offset, other, otherOffset, byteCount)
    }

    /**
     * The Function is startsWith
     *
     * @param prefix of ByteString
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public func startsWith(prefix: ByteString): Bool {
        return rangeEquals(0, prefix, 0, prefix.size)
    }

    /**
     * The Function is startsWith
     *
     * @param prefix of Array<Byte>
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public func startsWith(prefix: Array<Byte>): Bool {
        return rangeEquals(0, prefix, 0, prefix.size)
    }   

    /**
     * The Function is endsWith
     *
     * @param suffix of ByteString
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public func endsWith (suffix: ByteString):Bool {
        return rangeEquals(this.size - suffix.size, suffix, 0, suffix.size)
    }

    /**
     * The Function is endsWith
     *
     * @param suffix of Array<Byte>
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public func endsWith (suffix:Array<Byte>) :Bool {
        return rangeEquals(this.size - suffix.size, suffix, 0, suffix.size)
    }

    /**
     * The Function is indexOf
     *
     * @param other of ByteString
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func indexOf(other: ByteString): Int64 {
        return indexOf(other.internalArray(), 0)
    }

    /**
     * The Function is indexOf
     *
     * @param other of ByteString
     * @param fromIndex of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func indexOf(other: ByteString, fromIndex: Int64): Int64 {
        return indexOf(other.internalArray(), fromIndex)
    }

    /**
     * The Function is indexOf
     *
     * @param other of Array<Byte>
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func indexOf(other: Array<Byte>): Int64 {
        return indexOf(other, 0)
    }

    /**
     * The Function is indexOf
     *
     * @param other of Array<Byte>
     * @param fromIndex of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func indexOf(other: Array<Byte>, fromIndex: Int64): Int64 {
        for (i in max(fromIndex, 0)..=data.size-other.size where Util.arrayRangeEquals(this.data, i, other, 0, other.size)) {
            return i
        }
        return -1
    }

    /**
     * The Function is lastIndexOf
     *
     * @param other of ByteString
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func lastIndexOf(other: ByteString) : Int64 {
        return lastIndexOf(other.internalArray(), this.size)
    }

    /**
     * The Function is lastIndexOf
     *
     * @param other of ByteString
     * @param fromIndex of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func lastIndexOf(other: ByteString, fromIndex: Int64): Int64 {
        return lastIndexOf(other.internalArray(), fromIndex)
    }

    /**
     * The Function is lastIndexOf
     *
     * @param other of Array<Byte>
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func lastIndexOf(other: Array<Byte>): Int64 {
        return lastIndexOf(other, this.size)
    }

    /**
     * The Function is lastIndexOf
     *
     * @param other of Array<Byte>
     * @param fromIndex of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func lastIndexOf(other: Array<Byte>, fromIndex: Int64): Int64 {
        for (i in min(fromIndex, data.size - other.size)..=0:-1 where Util.arrayRangeEquals(this.data, i, other, 0, other.size)) {
            return i
        }
        return -1
    }

    /**
     * The Function is ==
     *
     * @param that of ByteString
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public operator func == (that: ByteString): Bool {
        return this.equals(that)
    }

    /**
     * The Function is !=
     *
     * @param that of ByteString
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public operator func != (that: ByteString): Bool {
        return !(this == that)
    }

    /**
     * The Function is equals
     *
     * @param o of ByteString
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public func equals (o: ByteString): Bool {
        if (refEq(this, o)) {
            return true
        }
        if (o.size != this.size) {
            return false
        }
        for (index in 0..this.size where this.data[index] != o.data[index]) {
            return false
        }
        return true
    }

    /**
     * The Function is hashCode
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func hashCode (): Int64 {
        return Util.hashCode(this.data)
    }

    /**
     * The Function is toString
     *
     * @return Type of String
     * @since 0.32.5
     */
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
