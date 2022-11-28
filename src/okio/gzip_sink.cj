/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the GzipSink class.
 */

package okio

from std import time.*
from compress import zlib.*

public class GzipSink <: Sink {

    private var sink: BufferedSink
    private var deflater: Deflater
    public var deflaterSink: DeflaterSink
    public var closed: Bool = false
    private var crc: CRC32 = CRC32()

    /**
     * The Function is init constructor
     *
     * @since 0.34.3
     */
    public init(sink: Sink){
        this.deflater = Deflater(-1 , true)
        this.sink = Okio.buffer(sink)
        this.deflaterSink = DeflaterSink(this.sink, deflater)
        //writeHeader()
    }

    /**
     * The Function is write
     *
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public func write(source: Buffer,byteCount: Int64): Unit {
        if (byteCount < 0) {
            throw IllegalArgumentException("byteCount < 0: ${byteCount}")
        }
        if (byteCount == 0){
            return
        }
        updateCrc(source, byteCount)
        deflaterSink.write(source, byteCount)

    }

    /**
     * The Function is flush
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public override func flush(): Unit {
    }

    /**
     * The Function is timeout
     *
     * @since 0.34.3
     */
    public override func timeout(): Timeout{
        return sink.timeout()
    }

    /**
     * The Function is close
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public override func close(): Unit{
        if(this.closed){
            return
        }

        var thrown: ?Exception = None
        try {
            deflaterSink.finishDeflate()

        } catch (e: Exception) {
            thrown = e
        }

        try {
            deflater.end();
        } catch (e: Exception) {
            match (thrown) {
                    case None => thrown = e
                    case Some(v) => () 
                }           
        }

        try {
            this.sink.close()
        } catch (e: Exception) {
            match (thrown) {
                    case None => thrown = e
                    case Some(v) => () 
                }
            
        }
        closed = true
        match (thrown) {
            case None => ()
            case Some(v) => Util.sneakyRethrow(thrown.getOrThrow())
        }
        
    }
    
    /**
     * The Function is updateCrc
     *
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    private func updateCrc(buffer: Buffer,byteCount: Int64): Unit{
        
            var head: Segment = buffer.head.getOrThrow()
            var byteCount:Int64 = byteCount
        while(byteCount > 0){
            var segmentLength: Int64 = math.min(byteCount, head.limit - head.pos)
            crc.update(head.data , head.pos , segmentLength)
            head = head.next.getOrThrow()
            byteCount -=  segmentLength
        }
    }

    /**
     * The Function is isClosed
     *
     *@return Type of Bool
     * @since 0.34.3
     */
    public override func isClosed(): Bool {
        return sink.isClosed()
    } 

    /**
     * The Function is toString
     *
     *@return Type of String
     * @since 0.34.3
     */
    public override func toString():String{
        return sink.toString()
    }
 }

/**
 * @file
 * The file declars the CRC32 class.
 */
public class CRC32 {

    /**
     * let member crc type is Int64
     * @since 0.34.3
     */
    private var crc: Int64 = 0

    /**
     * The Function is update
     *
     * @param b of Array<Byte>
     * @param off of Int64
     * @param len of Int64
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public func update(b: Array<Byte> , off: Int64 , len: Int64):Unit{
        if (off < 0 || len < 0 || off > b.size - len) {
            throw ArrayIndexOutOfBoundsException()
        }
        updateBytes(crc, b, off, len)
    }

    /**
     * The Function is updateBytes
     *
     * @param crc of Int64
     * @param b of Array<Byte>
     * @param off of Int64
     * @param len of Int64
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public static func updateBytes(crc: Int64 , b: Array<Byte> , off: Int64 , len: Int64):Unit {
        updateBytesCheck(b , off , len)

    }

    /**
     * The Function is updateBytesCheck
     *
     * @param b of Array<Byte>
     * @param off of Int64
     * @param len of Int64
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    private static func updateBytesCheck(b: Array<Byte> , off: Int64 , len: Int64):Unit {
        if (len <= 0) {
            return
        }
        if (b.size == 0) {
            throw NoneValueException()
        }
        if (off < 0 || off >= b.size) {
            throw ArrayIndexOutOfBoundsException()
        }
        let endIndex: Int64 = off + len -1
        if (endIndex < 0 || endIndex >= b.size) {
            throw ArrayIndexOutOfBoundsException()
        }
    }

    /**
     * The Function is reset
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public func reset():Unit {
        crc = 0;
    }
 }
