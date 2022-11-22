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

public class HashingSource <: ForwardingSource {

    private static var algorithmArray: Array<UInt8> = Array<UInt8>()
    private static var result: String = String(Array<Char>())
    private static var key: Array<UInt8> = Array<UInt8>()
    private var hasHmac: Bool = true
    private var sink: Buffer = Buffer()
    private var source: Source
    
    /**
     * The Function is md5
     * 
     * @param source of Source
     * 
     * @return Type of HashingSource
     * @since 0.34.3
     */
    public static func md5(source:Source):HashingSource{
        return HashingSource(source,"MD5")
    }

    public static func sha1(source: Source): HashingSource{
        return HashingSource(source, "SHA-1")
    }
    
    public static func sha256(source: Source): HashingSource{
        return HashingSource(source, "SHA-256")
    }

    public static func hmacSha1(source: Source,key: String):HashingSource{
        if(key.size <= 0) {
        throw Exception("The key cannot be empty.")
        }
        HashingSource.algorithmArray = Array<UInt8>(20,item: 0)
        HashingSource.key = key.toUtf8Array()
        HashingSource.result = String(Array<Char>(41, item: '0'))
        return HashingSource(source)
    }

    public static func hmacSha256(source:Source,key:String):HashingSource{
        if(key.size <= 0) {
        throw Exception("The key cannot be empty.")
        }
        HashingSource.algorithmArray = Array<UInt8>(32,item: 0)
        HashingSource.key = key.toUtf8Array()
        HashingSource.result = String(Array<Char>(65, item: '0'))
        return HashingSource(source)
    }

    private init(source: Source,algorithm: String){
        super(source)
        this.source = source
        HashingSource.algorithmArray = Array<UInt8>(getLength(algorithm),item: 0)
    }

    private init(source: Source){
        super(source);
        this.source = source
    }

    public override func read(sink: Buffer,byteCount: Int64):Int64{
        let readResult: Int64 = super.read(sink , byteCount)
        this.sink = sink
        return readResult
    }

    public func readMD5() {
        let sinkString: String = sink.readUtf8Line().getOrThrow()
        md5(sinkString , algorithmArray)
        HashingSource.result = md5HexToString(algorithmArray)
    }

    public func readSHA1() {
        let sinkString: String = sink.readUtf8Line().getOrThrow()        
        sha1(sinkString , algorithmArray)
        HashingSource.result = toHexString(algorithmArray)
    }

    public func readSHA256() {
        let sinkString: String = sink.readUtf8Line().getOrThrow()  
        sha256(sinkString , algorithmArray)
        HashingSource.result = toHexString(algorithmArray)
    }

    public func readhmacSha1() {
        var algorithm: AlgorithmType = AlgorithmType.SHA1
        var sinkArray: Array<UInt8> = Array<UInt8>()
        let sinkString: String = sink.readString().getOrThrow()
        sinkArray = sinkString.toUtf8Array()
        hmac(algorithm , key , sinkArray , algorithmArray)
        HashingSource.result = toHexString(algorithmArray)
    }

    public func readhmacSha256() {
        var algorithm: AlgorithmType = AlgorithmType.SHA256
        var sinkArray: Array<UInt8> = Array<UInt8>()
        let sinkString: String = sink.readString().getOrThrow()
        sinkArray = sinkString.toUtf8Array()
        hmac(algorithm , key , sinkArray , algorithmArray)
        HashingSource.result = toHexString(algorithmArray)
    }

    public func hash(): String{
        return result
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
            case _ => throw Exception("NoSuchAlgorithmException:${algorithm}")
        }
        return result
    }

    /**
     * The Function is isClosed
     *
     * @return Type of Bool
     * @since 0.34.3
     */
    public override func isClosed(): Bool {
        return source.isClosed()
    } 

}
