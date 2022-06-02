package okio

from std import collection.*
from std import format.*
from encoding import hex.*
from encoding import base64.*
from crypto import enc.*

func toByteArray(str: String): Array<Byte> {
    let data: Array<Byte> = Array<Byte> (str.size() + 1, {a => 0})
    for(i in 0..str.size()) {
        data[i] = UInt8(ord(str[i]))
    }
    data
}

func compare(aval: Array<Byte>, fromIndex: Int64, bval: Array<Byte>): Bool{
    let asize: Int64 = aval.size()
    let bsize: Int64 = bval.size()
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

public class ByteString {
    private let myData: Array<Byte>
    private let mySize: Int64
    public init() {
        let str: String = ""
        this.myData = toByteArray(str)
        this.mySize = str.size()
    }

    public init(str: String) {
        this.myData = toByteArray(str)
        this.mySize = str.size()
    }

    public init(value: Collection<Byte>) {
        this.myData = Array<Byte>(value)
        this.mySize = value.size()
    }

    public init(value: Array<Byte>) {
        this.myData = value
        this.mySize = value.size()
    }

    public func utf8(): String {
        String.fromUtf8(myData)
    }

    public func base64(): String {
        toBase64String(myData)
    }

    public func base64Url(): String {
        ""
    }

    public func hex(): String {
        toHexString(myData)
    }

    public func md5(): ByteString {
        ByteString(MD5.digestBytes(myData))
    }

    public func sha1(): ByteString {
        ByteString(SHA1.digestBytes(myData))
    }

    public func sha256(): ByteString {
        ByteString(SHA256.digestBytes(myData))
    }

    public func sha512(): ByteString {
        this
    }

    public func hmacSha1(key: ByteString): ByteString {
        ByteString(HMac.hmacSHA1(key.toByteArray(), myData))
    }

    public func hmacSha256(key: ByteString): ByteString {
        ByteString(HMac.hmacSHA256(key.toByteArray(), myData))
    }

    public func hmacSha512(key: ByteString): ByteString {
        this
    }
    public func toAsciiLowercase(): ByteString {
        let data: Array<Byte> = Array<Byte>(mySize, {a => 0})
        for(i in 0..mySize) {
            if (myData[i] >= UInt8(ord('A')) && myData[i] <= UInt8(ord('Z'))) {
                data[i] = myData[i] + 32
            } else {
                data[i] = myData[i]
            }
        }
        ByteString(data)
    }

    public func substring(beginIndex: Int64, endIndex: Int64): ByteString {
        this
    }

    public func toAsciiUppercase(): ByteString {
        let data: Array<Byte> = Array<Byte>(mySize, {a => 0})
        for(i in 0..mySize) {
            if (myData[i] >= UInt8(ord('a')) && myData[i] <= UInt8(ord('z'))) {
                data[i] = myData[i] + 32
            } else {
                data[i] = myData[i]
            }
        }
        ByteString(data)
    }

    private func internalGet(pos: Int64): Byte {
        myData[pos]
    }

    private func getSize(): Int64 {
        mySize
    }

    public func toByteArray(): Array<Byte> {
        myData.clone()
    }

    public func rangeEquals(offset: Int64, other: ByteString, otherOffset: Int64, byteCount: Int64): Bool {
        let otherData: Array<Byte> = other.toByteArray()
        for (i in 0..byteCount) {
            if (myData[offset + i] != otherData[otherOffset + i]) {
                return false
            }
        }
        true
    }

    public func rangeEquals(offset: Int64, other: Array<Byte>, otherOffset: Int64, byteCount: Int64): Bool {
        for (i in 0..byteCount) {
            if (myData[offset + i] != other[otherOffset + i]) {
                return false
            }
        }
        true
    }

    public func copyInto(offset: Int64, target: Array<Byte>, targetOffset: Int64, byteCount: Int64): Unit {
        if (offset + byteCount > mySize) {
            throw IllegalArgumentException("out of range")
        }
        for(i in 0..byteCount) {
            target[i] = myData[offset + i]
        }
    }

    public func startsWith(prefix: ByteString): Bool {
        let prefixData: Array<Byte> = prefix.toByteArray()
        for(i in 0..prefixData.size() ) {
            if(myData[i] != prefixData[i]) {
                return false
            }
        }
        true
    }

    public func startsWith(prefix: Array<Byte>): Bool {
        for(i in 0..prefix.size()) {
            if(myData[i] != prefix[i]) {
                return false
            }
        }
        true
    }

    public func endsWith(suffix: ByteString): Bool {
        let suffixData: Array<Byte> = suffix.toByteArray()
        let offset: Int64 = mySize - suffixData.size()
        for(i in 0..suffixData.size() ) {
            if(myData[i + offset] != suffixData[i]) {
                return false
            }
        }
        true
    }

    public func endsWith(suffix: Array<Byte>): Bool {
        let offset: Int64 = mySize - suffix.size()
        for(i in 0..suffix.size()) {
            if(myData[i + offset] != suffix[i]) {
                return false
            }
        }
        true
    }

    public func indexOf(other: ByteString, fromIndex: Int64): Int64 {
        let ret: Int64 = -1
        if(mySize - fromIndex < other.getSize()) {
            return -1
        }
        let data: Array<Byte> = other.toByteArray()
        for(i in fromIndex..mySize) {
            if(mySize - i < data.size()) {
                return ret
            }
            if (compare(myData, i, data)) {
                return i
            }
        }
        -1
    }

    public func indexOf(other: Array<Byte>, fromIndex: Int64): Int64 {
        let ret: Int64 = -1
        if(mySize - fromIndex < other.size()) {
            return -1
        }
        for(i in fromIndex..mySize) {
            if(mySize - i < other.size()) {
                return ret
            }
            if (compare(myData, i, other)) {
                return i
            }
        }
        -1
    }

    public func lastIndexOf(other: ByteString, fromIndex: Int64): Int64 {
        var ret: Int64 = -1
        if(mySize - fromIndex < other.getSize()) {
            return -1
        }
        let data: Array<Byte> = other.toByteArray()
        for(i in fromIndex..mySize) {
            if(mySize - i < data.size()) {
                return ret
            }
            if (compare(myData, i, data)) {
                ret = i
            }
        }
        ret
    }

    public func lastIndexOf(other: Array<Byte>, fromIndex: Int64): Int64 {
        var ret: Int64 = -1
        if(mySize - fromIndex < other.size()) {
            return -1
        }
        for(i in fromIndex..mySize) {
            if(mySize - i < other.size()) {
                return ret
            }
            if (compare(myData, i , other)) {
                ret = i
            }
        }
        ret
    }

    public func hashCode(): Int64 {
        0
    }

    public func compareTo(other: ByteString): Int64 {
        0
    }

    public func toString(): String {
        myData.toString()
    }
}