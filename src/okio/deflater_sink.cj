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
    private var deflater: Deflater
    private var closed: Bool = true
    public static var bytesRead: Int64 = 0
    private var bufferSink: Buffer = Buffer()
    private var byteCountSink: Int64 = 0
    public var datas: Buffer = Buffer()
    /**
     * The Function is init constructor
     *
     * @since 0.34.3
     */
    public init(sink: Sink , deflater: Deflater){
        this.sink = Okio.buffer(sink)
        this.deflater = deflater
        getDeflaterSink(Okio.buffer(sink),deflater)
    }

    /**
     * The Function is getDeflaterSink
     *
     * @param sink of BufferedSink
     * @param deflater of Deflater
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    func getDeflaterSink(sink: BufferedSink , deflater: Deflater):Unit {
        this.sink = sink
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
    public func write(source: Buffer , byteCount: Int64): Buffer{
        let str = deflate(source , byteCount)
        this.bufferSink = source
        this.byteCountSink = byteCount 
        return str
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
    private func deflate (source: Buffer , byteCount: Int64):Buffer {
        let buffer: Buffer = sink.buffer()
        
            let byteSink: Array<Byte> = Array<Byte>(byteCount, item: 0)
            var result = source.read(byteSink)

            var file:File = File("./temporarily.txt" , OpenOption. CreateOrTruncate(true))
            file.write(byteSink)
            file.seek(SeekPosition.Begin(0))
            var compressInputStream: CompressInputStream = CompressInputStream(file , wrap: DeflateFormat)

        while(true){
            // 在当前sink中申请一个位于segment链表尾部的segment，用来存放压缩后的数据
            let s: Segment = buffer.writableSegment(1)
            // 调用Deflater类的压缩方法执行实际的压缩操作，压缩后的数据存放在s.data中

            let deflated: Int64 = compressInputStream.read(s.data.slice(0, byteCount))

            datas.write(s.data)
            //println(sink.toString())

            bytesRead +=deflated
            if (deflated > 0) {
                // 有数据被压缩了
                s.limit = s.limit + deflated
                var bufferSize: Int64 = buffer.size + deflated
                sink.emitCompleteSegments()
            }else if (deflater.needsInput()) {
                // 没有数据被压缩，同时也不存在需要压缩的数据，则释放申请的segment
                if (s.pos == s.limit) {
                    buffer.head = s.pop()
                    SegmentPool.recycle(s)
                }
                return datas
            }
        }
        compressInputStream.close()
        file.close()
        return datas
    }

    /**
     * The Function is finishDeflate
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    func finishDeflate():Unit {
        deflater.finishs()
        write(bufferSink , byteCountSink)
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
    public func needsInput(): Bool {
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
    public func finishs():Unit {
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
