/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the GzipSource class.
 */

package okio

from std import time.*
from compress import zlib.*

public class GzipSource <: Source {

    private static var FHCRC: Int8 = 1
    private static var FEXTRA: Int8 = 2
    private static var FNAME: Int8 = 3
    private static var FCOMMENT: Int8 = 4

    private static var SECTION_HEADER: Int8 = 0
    private static var SECTION_BODY: Int8 = 1
    private static var SECTION_TRAILER: Int8 = 2
    private static var SECTION_DONE: Int8 = 3

    private var section: Int8 = SECTION_HEADER
    private var source: BufferedSource
    private var inflater: Inflater
    private var inflaterSource: InflaterSource
    private var crc: CRC32 = CRC32()

    /**
     * The Function is init constructor
     *
     * @since 0.34.3
     */
    public init(source:Source){
        this.inflater = Inflater()
        this.source = Okio.buffer(source)
        this.inflaterSource = InflaterSource(this.source,inflater)
    }

    /**
     * The Function is read
     *
     * @param sink of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Int64
     * @since 0.34.3
     */
    public func read(sink: Buffer,byteCount: Int64): Int64{
        if(byteCount < 0){
            throw IllegalArgumentException("byteCount < 0:${byteCount}")
        }
        if(byteCount == 0){
            return 0
        }
        if(section == SECTION_HEADER){
            //consumeHeader()
            section = SECTION_BODY
        }
        if(section == SECTION_BODY){
            let offest: Int64 = sink.size
            let result: Int64 = inflaterSource.read(sink , byteCount)
            if(result != -1){
                //updateCrc(sink,offest,result)
                return result
            }
            section = SECTION_TRAILER
        }
        if(section == SECTION_TRAILER){
            //consumeTrailer()
            let section = SECTION_DONE
            /* if(!source.exhausted()){
                throw Exception("gzip finished without exhausting source")
            } */
        }
        return -1
    }
    
    /**
     * The Function is timeout
     *
     * @return Type of Timeout
     * @since 0.34.3
     */
    public override func timeout(): Timeout{
        return source.timeout()
    }

    /**
     * The Function is close
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public override func close(): Unit{     
        inflaterSource.close()
    }

    /**
     * The Function is isClosed
     *
     *@return Type of Bool
     * @since 0.34.3
     */
    public override func isClosed(): Bool {
        return source.isClosed()
    } 

    /**
     * The Function is toString
     *
     *@return Type of String
     * @since 0.34.3
     */
    public override func toString():String{
        return source.toString()
    }  
}
