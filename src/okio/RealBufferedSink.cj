package okio

from std import time.*

import nio.*

// class RealBufferedSink <: BufferedSink {

//     public let buf: Buffer = Buffer()
    
//     public let sink: Sink
    
//     var closed: Bool = true
    
//     init (sink: Sink){
//         this.sink = sink
//     }

//     public func buffer (): Buffer {
//         return this.buf
//     }

//     public func write(byteString: ByteString): BufferedSink {
//         if (this.closed) {
//             throw IllegalArgumentException("closed.")
//         }
//         this.buf.wirte(byteString)
//         return emitCompleteSegments()
//     }
//     public func write(byteString: ByteString, offset: Int64, byteCount: Int64): BufferedSink
//     // func write(source: Buffer): BufferedSink
//     public func write(source: Source, byteCount: Int64): BufferedSink
//     // func write(source: Buffer, byteCount: Int64): Unit
//     public func writeAll(source: Source): Int64
//     public func writeUtf8(string: String): BufferedSink
//     public func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink
//     public func writeUtf8CodePoInt64(codePoInt64: Int64): BufferedSink
//     // func writeString(string: String, charset: Charset): BufferedSink
//     // func writeString(string: String, beginIndex: Int64, endIndex: Int64, charset: Charset): BufferedSink
//     public func writeInt8(value: Int8): BufferedSink
//     public func writeInt16(value: Int16): BufferedSink
//     public func writeInt16Le(value: Int16): BufferedSink
//     public func writeInt32(value: Int32): BufferedSink
//     public func writeInt32Le(value: Int32): BufferedSink
//     public func writeInt64(value: Int64): BufferedSink
//     public func writeInt64Le(value: Int64): BufferedSink
//     public func writeDecimalInt64(value: Int64): BufferedSink
//     public func writeHexadecimalUInt64(value: Int64): BufferedSink
//     public func flush(): Unit
//     public func emit(): BufferedSink

//     pulbic func emitCompleteSegments(): BufferedSink {
//         if (this.closed) {
//             throw IllegalArgumentException("closed.")
//         }
//         var byteCount = this.buf.completeSegmentByteCount()
//         if (byteCount > 0) {
//             this.sink.
//         }
//     }

    
// }


