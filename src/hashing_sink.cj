/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */

/**
 * @file
 * The file declars the HashingSource class.
 */
package io4cj



public class HashingSink <: ForwardingSink {

    private static var algorithmArray: Array<UInt8> = Array<UInt8>()
    private static var result: String = String(Array<Rune>())
    private static var key: Array<UInt8> = Array<UInt8>()
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
        HashingSink.algorithmArray = Array<UInt8>(20, repeat: 0)
        HashingSink.key = key.toArray()
        HashingSink.result = String(Array<Rune>(41, repeat: r'0'))
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
        HashingSink.algorithmArray = Array<UInt8>(32, repeat: 0)
        HashingSink.key = key.toArray()
        HashingSink.result = String(Array<Rune>(65, repeat: r'0'))
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
        HashingSink.algorithmArray = Array<UInt8>(64, repeat: 0)
        HashingSink.key = key.toArray()
        HashingSink.result = String(Array<Rune>(129, repeat: r'0'))
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
        HashingSink.algorithmArray = Array<UInt8>(getLength(algorithm), repeat: 0)
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
        let sourceArray: Array<UInt8> = source.readByteArray()
        let sourceData= String.fromUtf8(sourceArray)[0..byteCount].toArray()
        md5(sourceData , algorithmArray)
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
        let sourceArray: Array<UInt8> = source.readByteArray()
        let sourceData= String.fromUtf8(sourceArray)[0..byteCount].toArray()       
        sha1(sourceData , algorithmArray)
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
        let sourceArray: Array<UInt8> = source.readByteArray() 
        let sourceData= String.fromUtf8(sourceArray)[0..byteCount].toArray() 
        sha256(sourceData , algorithmArray)
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
        let sourceArray: Array<UInt8> = source.readByteArray()
        let sourceData= String.fromUtf8(sourceArray)[0..byteCount].toArray() 
        sha512(sourceData , algorithmArray)
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
        var algorithm: AlgorithmType = AlgorithmType.Sha1
        var sourceArray: Array<UInt8> = Array<UInt8>()
        let sourceString: String = source.readString()[0..byteCount]
        //let sourceData= String.fromUtf8(sourceArray).substring(0,byteCount).toUtf8Array() 
        sourceArray = sourceString.toArray()
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
        var algorithm: AlgorithmType = AlgorithmType.Sha256
        var sourceArray: Array<UInt8> = Array<UInt8>()
        let sourceString: String = source.readString()[0..byteCount]
        sourceArray = sourceString.toArray()
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
        var algorithm: AlgorithmType = AlgorithmType.Sha512
        var sourceArray: Array<UInt8> = Array<UInt8>()
        let sourceString: String = source.readString()[0..byteCount]
        sourceArray = sourceString.toArray()
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
        sink.isClosed()
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
