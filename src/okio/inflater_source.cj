/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the InflaterSource class.
 */

package okio

from compress import zlib.*

public class InflaterSource <: Source {

    private var source: BufferedSource
    private var inflater: Inflater
    private var bufferBytesHeldByInflater: Int64 = 0
    private var closed: Bool = false

    /**
     * The Function is init constructor
     *
     * @since 0.34.3
     */
    public init(source: Source , inflater: Inflater) {
        this.source = Okio.buffer(source)
        this.inflater = inflater
        getInflaterSource(Okio.buffer(source) , inflater)
    }

    /**
     * The Function is getInflaterSource
     *
     * @param source of BufferedSource
     * @param inflater of Inflater
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    func getInflaterSource(source: BufferedSource , inflater: Inflater):Unit {
        this.source = source
        this.inflater = inflater
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
    public func read(sink: Buffer , byteCount: Int64): Int64 {
        if (byteCount < 0) {
            throw IllegalArgumentException("byteCount < 0: ${byteCount}")
        }
        if (closed) {
            throw IllegalStateException("closed")
        }
        if (byteCount == 0) {
            return 0
        }
            var sourceArray: Array<UInt8> = Array<UInt8>(1024, item: 0)
            var tempBuf: Array<UInt8> = Array<UInt8>(1024, item: 0)
            var file: File = File("./temporar.txt" , OpenOption. CreateOrTruncate(true))

            var decompressOutputStream: DecompressOutputStream = DecompressOutputStream(file, wrap: DeflateFormat)

        while(true){
            let sourceEnd: Bool = refill()
            source.read(tempBuf)
            let s: Segment = sink.writableSegment(1)
            //var toRead = math.min(byteCount, Segment.SIZE - s.limit)

            
            decompressOutputStream.write(tempBuf.slice(0, 1024).toArray())

            var inflated = file.read(sourceArray)

            /* if (inflated <= 0) {
                return -1
                } */

            if (inflated > 0) {
                s.limit += inflated

                var sinkSize: Int64 = sink.size + inflated
                return inflated
            }
            if (inflater.finished() || inflater.needsDictionary()) {
                releaseInflatedBytes()
                if (s.pos == s.limit) {
            // We allocated a tail segment, but didn't end up needing it. Recycle!
            sink.head = s.pop();
            SegmentPool.recycle(s);
          }
          return -1;
            }
            if (sourceEnd) {
                throw EOFException("source exhausted prematurely")
            }
        }
        //decom.flush()
        decompressOutputStream.flush()
        decompressOutputStream.close()
        file.close()
        return 0
    }

    /**
     * The Function is refill
     *
     * @return Type of Bool
     * @since 0.34.3
     */
    public func refill(): Bool {
        if (!inflater.needsInput()) {
            return false
        }
        releaseInflatedBytes()
        if (inflater.getRemaining() != 0) {
            throw IllegalStateException("?")
        }
        if (source.exhausted()) {
            return true
        }
        let s: Segment = source.getBuffer().head.getOrThrow()
        bufferBytesHeldByInflater = s.limit - s.pos
        inflater.setInput(s.data , s.pos , bufferBytesHeldByInflater)
        return false
    }

    /**
     * The Function is releaseInflatedBytes
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    private func releaseInflatedBytes():Unit {
        if (bufferBytesHeldByInflater == 0) {
            return
        }
        let released: Int64 = bufferBytesHeldByInflater - inflater.getRemaining()
        bufferBytesHeldByInflater -= released
        source.skip(released)
    }

    /**
     * The Function is timeout
     *
     * @return Type of Timeout
     * @since 0.34.3
     */
    public override func timeout(): Timeout {
        return source.timeout()
    }

    /**
     * The Function is close
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public override func close():Unit {
        if (closed) {
            inflater.end()
            closed = true
            source.close()
        }
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
/**
 * @file
 * The file declars the Inflater class.
 */
public class Inflater {

    private var input: ByteBuffer = ByteBuffer.allocate(0)
    private var inputArray: Array<Byte> = []
    private var inputPos: Int64 = 0
    private var inputLim: Int64 = 0
    private var finishe: Bool = true
    private var needDict: Bool = true
    private var bytesRead: Int64 = 0
    private var inputConsumed: Int64 = 0
    private var outputConsumed: Int64 = 0
    
    /**
     * The Function is finished
     *
     * @return Type of Bool
     * @since 0.34.3
     */
    public func finished(): Bool {
        return finishe
    }

    /**
     * The Function is needsDictionary
     *
     * @return Type of Bool
     * @since 0.34.3
     */
    public func needsDictionary(): Bool {
        return needDict
    }

    /**
     * The Function is needsInput
     *
     * @return Type of Bool
     * @since 0.34.3
     */
    public func needsInput(): Bool {
        let input: ?ByteBuffer = this.input
        return match (input) {
            case None => inputLim == inputPos
            case Some(v) => ! input.getOrThrow().hasRemaining()
        }
    }

    /**
     * The Function is getRemaining
     *
     * @return Type of Int64
     * @since 0.34.3
     */
    public func getRemaining(): Int64 {
        let input: ?ByteBuffer = this.input
        return match (input) {
            case None => inputLim - inputPos
            case Some(v) => input.getOrThrow().remaining()
        }
    }

    /**
     * The Function is setInput
     *
     * @param input of Array<Byte>
     * @param off of Int64
     * @param len of Int64
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public func setInput(input: Array<Byte> , off: Int64 , len: Int64):Unit {
        if (off < 0 || len < 0 || off > (input.size - len)) {
            throw ArrayIndexOutOfBoundsException()
        }
        this.inputArray = input
        this.inputPos = off
        this.inputLim = off + len
    }

    /**
     * The Function is end
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    public func end():Unit {
        input = ByteBuffer.allocate(0)
    }
}
