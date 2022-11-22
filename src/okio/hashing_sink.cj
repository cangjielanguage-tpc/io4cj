/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the HashingSource class.
 */
package okio

from std import time.*
from std import io.*
from std import core.*
from  cryptocj import md5cj.*
from  cryptocj import sha1cj.*
from  cryptocj import sha256cj.*
from  cryptocj import sha512cj.*
from  cryptocj import hmaccj.*

public class HashingSink <: ForwardingSink {

    private static var algorithmArray: Array<UInt8> = Array<UInt8>()
    private static var result: String = String(Array<Char>())
    private static var key: Array<UInt8> = Array<UInt8>()
    private var hasHmac: Bool = true
    private var source: Buffer = Buffer()
    private var sink: Sink


    /**
     * The Function is md5
     * 
     * @param sink of Sink
     * 
     * @return Type of HashingSink
     * @since 0.34.3
     */
    public static func md5(sink: Sink): HashingSink {
        return HashingSink(sink , "MD5")
    }

    /**
     * The Function is sha1
     * 
     * @param sink of Sink
     * 
     * @return Type of HashingSink
     * @since 0.34.3
     */
    public static func sha1(sink: Sink): HashingSink {
        return HashingSink(sink , "SHA-1")
    }

    /**
     * The Function is sha256
     * 
     * @param sink of Sink
     * 
     * @return Type of HashingSink
     * @since 0.34.3
     */
    public static func sha256(sink: Sink): HashingSink {
        return HashingSink(sink , "SHA-256")
    }

    /**
     * The Function is sha512
     * 
     * @param sink of Sink
     * 
     * @return Type of HashingSink
     * @since 0.34.3
     */
    public static func sha512(sink: Sink): HashingSink {
        return HashingSink(sink , "SHA-512")
    }

    /**
     * The Function is hmacSha1
     * 
     * @param sink of Sink
     * @param byteCount of Int64
     * 
     * @return Type of HashingSink
     * @since 0.34.3
     */
    public static func hmacSha1(sink: Sink , key: String): HashingSink {
        if(key.size <= 0) {
        throw Exception("The key cannot be empty.")
        }
        HashingSink.algorithmArray = Array<UInt8>(20,item: 0)
        HashingSink.key = key.toUtf8Array()
        HashingSink.result = String(Array<Char>(41, item: '0'))
        return HashingSink(sink)
    }

    /**
     * The Function is hmacSha256
     * 
     * @param sink of Sink
     * @param byteCount of Int64
     * 
     * @return Type of HashingSink
     * @since 0.34.3
     */
    public static func hmacSha256(sink: Sink , key: String):HashingSink {
        HashingSink(sink)
        if(key.size <= 0) {
        throw Exception("The key cannot be empty.")
        }
        HashingSink.algorithmArray = Array<UInt8>(32,item: 0)
        HashingSink.key = key.toUtf8Array()
        HashingSink.result = String(Array<Char>(65, item: '0'))
        return HashingSink(sink)
    }

    /**
     * The Function is hmacSha512
     * 
     * @param sink of Sink
     * @param byteCount of Int64
     * 
     * @return Type of HashingSink
     * @since 0.34.3
     */
    public static func hmacSha512(sink: Sink , key: String): HashingSink {
        HashingSink(sink)
        if(key.size <= 0) {
        throw Exception("The key cannot be empty.")
        }
        HashingSink.algorithmArray = Array<UInt8>(64,item: 0)
        HashingSink.key = key.toUtf8Array()
        HashingSink.result = String(Array<Char>(129, item: '0'))
        return HashingSink(sink)
    }

    /**
     * The Function is init constructor
     *
     * @since 0.34.3
     */
    private init(sink: Sink , algorithm: String){
        super(sink)
        this.sink = sink
        HashingSink.algorithmArray = Array<UInt8>(getLength(algorithm),item: 0)
    }

    /**
     * The Function is init constructor
     *
     * @since 0.34.3
     */
    private init(sink: Sink){
        super(sink)
        this.sink = sink
    }

    /**
     * The Function is write
     * 
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @since 0.34.3
     */
    public override func write(source: Buffer , byteCount: Int64){
        Util.checkOffsetAndCount(source.size, 0, byteCount)
        super.write(source, byteCount)
    }

    /**
     * The Function is writeMD5
     * 
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @since 0.34.3
     */
    public func writeMD5(source: Buffer , byteCount: Int64){
        source.copyTo(this.source,0, byteCount)
        let sourceString: String = source.readUtf8Line().getOrThrow()
        md5(sourceString , algorithmArray)
        HashingSink.result = md5HexToString(algorithmArray)
        write(this.source, byteCount)
    }

    /**
     * The Function is writeMD5
     * 
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @since 0.34.3
     */
    public func writeSHA1(source: Buffer , byteCount: Int64){
        source.copyTo(this.source,0, byteCount)
        let sourceString: String = source.readUtf8Line().getOrThrow()        
        sha1(sourceString , algorithmArray)
        HashingSink.result = toHexString(algorithmArray)
        write(this.source, byteCount)
    }

    /**
     * The Function is writeMD5
     * 
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @since 0.34.3
     */
    public func writeSHA256(source: Buffer , byteCount: Int64){
        source.copyTo(this.source,0, byteCount)
        let sourceString: String = source.readUtf8Line().getOrThrow()  
        sha256(sourceString , algorithmArray)
        HashingSink.result = toHexString(algorithmArray)
        write(this.source, byteCount)
    }

    /**
     * The Function is writeMD5
     * 
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @since 0.34.3
     */
    public func writeSHA512(source: Buffer , byteCount: Int64){
        source.copyTo(this.source,0, byteCount)
        let sourceString: String = source.readUtf8Line().getOrThrow()
        sha512(sourceString , algorithmArray)
        HashingSink.result = toHexString(algorithmArray)
        write(this.source, byteCount)
    }

    /**
     * The Function is writeMD5
     * 
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @since 0.34.3
     */
    public func writehmacSha1(source: Buffer , byteCount: Int64){
        source.copyTo(this.source,0, byteCount)
        var algorithm: AlgorithmType = AlgorithmType.SHA1
        var sourceArray: Array<UInt8> = Array<UInt8>()
        let sourceString: String = source.readString().getOrThrow()
        sourceArray = sourceString.toUtf8Array()
        hmac(algorithm , key , sourceArray , algorithmArray)
        HashingSink.result = toHexString(algorithmArray)
        write(this.source, byteCount)
    }

    /**
     * The Function is writeMD5
     * 
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @since 0.34.3
     */
    public func writehmacSha256(source: Buffer , byteCount: Int64){
        source.copyTo(this.source,0, byteCount)
        var algorithm: AlgorithmType = AlgorithmType.SHA256
        var sourceArray: Array<UInt8> = Array<UInt8>()
        let sourceString: String = source.readString().getOrThrow()
        sourceArray = sourceString.toUtf8Array()
        hmac(algorithm , key , sourceArray , algorithmArray)
        HashingSink.result = toHexString(algorithmArray)
        write(this.source, byteCount)
    }

    /**
     * The Function is writeMD5
     * 
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @since 0.34.3
     */
    public func writehmacSha512(source: Buffer , byteCount: Int64){
        source.copyTo(this.source,0, byteCount)
        var algorithm: AlgorithmType = AlgorithmType.SHA512
        var sourceArray: Array<UInt8> = Array<UInt8>()
        let sourceString: String = source.readString().getOrThrow()
        sourceArray = sourceString.toUtf8Array()
        hmac(algorithm , key , sourceArray , algorithmArray)
        HashingSink.result = toHexString(algorithmArray)
        write(this.source, byteCount)
    }
    
    /**
     * The Function is hash
     *
     * @return Type of ByteString
     * @since 0.34.3
     */
    public func hash(): String{
        return result      
    }

    /**
     * The Function is isClosed
     *
     * @return Type of Bool
     * @since 0.34.3
     */
    public override func isClosed(): Bool {
        return sink.isClosed()
    } 

    /**
     * The Function is getLength
     * 
     * @param algorithm of String
     * @return Type of Int64
     * @since 0.34.3
     */
    private func getLength(algorithm:String): Int64 {
        let result: Int64 = match (algorithm) {
            case "MD5" => 16
            case "SHA-1" => 20
            case "SHA-256" => 32
            case "SHA-512" => 64
            case _ => throw Exception("NoSuchAlgorithmException:${algorithm}")
        }
        return result
    }
}
