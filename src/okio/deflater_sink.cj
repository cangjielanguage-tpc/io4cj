/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the DeflaterSink class.
 */

package okio

from compress import zlib.*

public class DeflaterSink {

    private var sink: BufferedSink
    private var sinks: Sink
    private var deflater: Deflater
    private var closed: Bool = true
    private var bufferSink: Buffer = Buffer()
    private var byteCountSink: Int64 = 0

    /**
     * The Function is init constructor
     *
     * @since 0.34.3
     */
    public init(sink: Sink , deflater: Deflater){
        this.sink = Okio.buffer(sink)
        this.sinks = sink
        this.deflater = deflater
    }

    /**
     * The Function is isClosed
     *
     * @return Type of Bool
     * @since 0.34.3
     */
    public func isClosed(): Bool{
        return closed
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
    public func write(source: Buffer , byteCount: Int64){
        deflate(source , byteCount)
        this.bufferSink = source
        this.byteCountSink = byteCount 
    }

    /**
     * The Function is deflate
     *
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    private func deflate (source: Buffer , byteCount: Int64): Unit {
        let buffer: Buffer = sink.buffer()
        
            let byteSink: Array<Byte> = Array<Byte>(byteCount, item: 0)
            let gzipBuffer: Array<Byte> = Array<Byte>(byteCount, item: 0)
            var result = source.read(byteSink)

            var file:File = File("./temporarily.txt" , OpenOption. CreateOrTruncate(true))
            file.write(byteSink)
            file.seek(SeekPosition.Begin(0))
            var compressInputStream: CompressInputStream = CompressInputStream(file , wrap: DeflateFormat)

        while(true){
            
            let deflated: Int64 = compressInputStream.read(gzipBuffer)
            buffer.write(gzipBuffer)
            sinks.write(buffer,buffer.size)
            if(deflated <= 0) {
                break
            }

        }
        compressInputStream.close()
        file.close()
    }

    /**
     * The Function is finishDeflate
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    func finishDeflate():Unit {
        deflater.finishs()
    }

}


/**
 * @file
 * The file declars the Deflater class.
 */
public class Deflater {
    
    private var input: ByteBuffer = ByteBuffer.allocate(0)
    private var inputPos: Int64 = 0
    private var inputLim: Int64 = 0
    private var finish: Bool = true
    private var level: Int64

    /**
     * The Function is init constructor
     *
     * @since 0.34.3
     */
    init(level: Int64 , nowrap: Bool) {
        this.level = level      
    }

    /**
     * The Function is needsInput
     *
     * @return Type of Bool
     * @since 0.34.3
     */
    func needsInput(): Bool {
        let input: ?ByteBuffer = this.input
        return match (input) {
            case None => inputLim == inputPos
            case Some(v) => ! input.getOrThrow().hasRemaining()
        }
    }

    /**
     * The Function is finishs
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    func finishs():Unit {
        finish = true
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
