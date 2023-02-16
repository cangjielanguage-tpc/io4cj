## okio 库
### 介绍

Okio是OkHttp的低层IO库，核心概念是source和sink，类似于仓颉的InputStream和OutputStream。

### 1 提供okio轻量级io框架功能

前置条件：NA

场景：

1. 提供核心接口 Sink/Source/BufferedSink/BufferedSource接口实现

2. 提供核心接口缓存功能类开发, SegmentPool类/Segment类实现

3. 提供核心接口实现类 Buffer类/RealBufferedSink类/RealBufferedSource类开发

4. 提供核心功能辅助类开发, ByteString类/ utf8类/ util类开发实现

5. 提供 nio 组件 ByteBuffer和 Buffer开发

约束：

性能： 支持版本几何性能持平

可靠性： NA

### 1.1 主要接口


#### 1.1.1 Okio 类

okio程序主要入口类, 此类无法创建对象, 其暴露的接口均是静态函数.
```cangjie
public class Okio {

    /*
     * 返回缓冲从Source读取的新Source。返回的BufferedSource将对其内存缓冲区执行批量读取。
     * 参数 Source - 原Source对象
     * 返回值 BufferedSource - 返回新Source子类BufferedSource, BufferedSource比Source有更多的接口可以使用.
     */
    public static func buffer(source: Source): BufferedSource

    /*
     * 返回缓冲写入Sink的新Sink。返回的BufferedSink可以将Sink的内存缓冲区进行批量写入。
     * 参数 Sink - 原Sink对象
     * 返回值 BufferedSink - 返回新Sink的子类BufferedSink,  BufferedSink在内存写入上比Sink有更多的接口可以使用.
     */
    public static func buffer(sink: Sink): BufferedSink

    /*
     * 返回写入Socket的Sink。
     * 参数 Socket - 标准库套接字对象
     * 返回值 Sink - Sink对象
     */
    public static func sink(socket: Socket): Sink 

    /*
     * 返回写入TlsSocket的Sink。
     * 参数 TlsSocket - 标准库套接字对象
     * 返回值 Sink - Sink对象
     */
    static func sink(socket: TlsSocket): Sink 

    /*
     * 返回写入File的Sink。
     * 参数 File - 标准库std的文件对象
     * 返回值 Sink - Sink对象
     */
    public static func sink(file: File): Sink

    /*
     * 返回从Socket读取的Source。
     * 参数 Socket - 标准库套接字对象
     * 返回值 Source - Source对象
     */
    public static func source(socket: Socket): Source  

    /*
     * 返回从TlsSocket读取的Source。
     * 参数 TlsSocket - 标准库套接字对象
     * 返回值 Source - Source对象
     */
    static func source(socket: TlsSocket): Source {

    /*
     * 返回写入File的Source。
     * 参数 File - 标准库std的文件对象
     * 返回值 Source - Source对象
     */
    public static func source(file: File): Source
}
```

#### 1.1.2 Source 接口

此接口在功能上等同于cangjie标准库的std.io.InputStream
```cangjie
public interface Source <: Resource {
    /*
     * 关闭此源并释放此源持有的资源。读取封闭源是一个错误。多次关闭Source是安全的。
     */
    public func close(): Unit 

    /*
     * 从Source中删除至少1个字节，并将它们附加到Sink中。返回读取的字节数，如果此Source已用完，则返回-1。
     * 参数 Buffer - okio的Buffer对象, Sink的实现类
     * 参数 Int64 - 计数器
     * 返回值 Int64 - 返回读取的字节数，如果此Source已用完，则返回-1。
     */
    public func read(sink: Buffer, byteCount: Int64): Int64

    /*
     * 返回此Source的超时对象。
     * 返回值 Timeout - 超时对象
     */
    public func timeout(): Timeout 
}
```

#### 1.1.3 Sink 接口

此接口在功能上等同于cangjie标准库的std.io.OutputStream
```cangjie
public interface Sink <: Resource {

    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的。
     */
    public func close(): Unit   

    /*
     * 将所有缓冲字节推送到SInk的目标中。
     */
    public func flush(): Unit  

    /*
     * 返回此接收器的超时对象
     * 返回值 Timeout - 超时对象
     */
    public func timeout(): Timeout  

    /*
     * 从Source中删除byteCount字节并将其附加到此Sink中。
     * 参数 Buffer - okio的Buffer对象, source的实现类
     * 参数 Int64 - 计数器
     */
    public func write(source: Buffer, byteCount: Int64): Unit
}
```

#### 1.1.4 BufferedSink 接口

一种在内部保留缓冲区的接收器，以便调用者可以进行较小的写操作，而不会降低性能。
```cangjie
public interface BufferedSink <: Sink {
    
    /*
     * 获取此BufferedSink的缓冲对象
     * 返回值 Buffer - Buffer
     */
    public func buffer (): Buffer

    /*
     * 向该source写入一个完整的字节数组。
     * 参数 source - 字节数组
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(source: Array<Byte>): BufferedSink 

    /*
     * 向BufferedSink中写入一个完整的ByteString所包含的字节序列
     * 参数 byteString - okio的ByteString对象
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(byteString: ByteString): BufferedSink  

    /*
     * 向BufferedSink中写入一个source中包含bytecount个的字节序列
     * 参数 Source - 读取的source
     * 参数 Int64 - 写入的计数器
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(source: Source, byteCount: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个完整source的字节序列
     * 参数 source - 读取的source
     * 返回值 Int64 - Int64
     */
    public func writeAll(source: Source): Int64

    /*
     * 向BufferedSink中写入UTF-8编码的字符串.
     * 参数 String - 读取的String
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeUtf8(string: String): BufferedSink

    /*
     * 向BufferedSink中写入UTF-8编码带有起始和结束范围的字符串.
     * 参数 String - 读取的String
     * 参数 Int64 - 开始索引
     * 参数 Int64 - 结束索引
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink

    /*
     * 用UTF-8编码codePoint并将其写入此BufferedSink。
     * 参数 Int64 - UTF-8的数字表示形式
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeUtf8CodePoint(codePoInt64: Int64): BufferedSink 

    /*
     * 向BufferedSink中写入一个int8的字节
     * 参数 Int64 - 写入一个不超过int8.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt8(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt16(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt16Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt32(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt32Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt64(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt64Le(value: Int64): BufferedSink

    /*
     * 将BufferedSink所有缓冲数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    public func emit(): BufferedSink

    /*
     * 将完整Segment数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    public func emitCompleteSegments(): BufferedSink 

}
```

#### 1.1.5 BufferedSource 接口

一种在内部保留缓冲区的源，以便调用者可以进行较小的读取而不影响性能。它还允许客户端提前读取，在使用输入之前尽可能多地缓冲。
```cangjie
public interface BufferedSource <: Source & ToString {

    /*
     * 获取buffer类
     * 返回值 Buffer - Buffer类
     */
    public func getBuffer(): Buffer

    /*
     * 如果此源中没有更多字节，则返回true。这将阻塞，直到有字节要读取或源完全耗尽。
     * 返回值 Bool - bool
     */
    public func exhausted(): Bool

    /*
     * 当缓冲区至少包含byteCount字节时返回。如果Source在读取所需字节之前耗尽, 将抛出EOFException.
     * 参数 Int64 - byteCount 计数器
     */
    public func require(byteCount: Int64): Unit

    /*
     * 当缓冲区至少包含byteCount字节时，返回true，并根据需要进行扩展。如果源在读取请求的字节之前耗尽，则返回false。
     * 参数 Int64 - byteCount 计数器
     * 返回值 Bool - Bool
     */
    public func request(byteCount: Int64): Bool

    /*
     * 从Sink中复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - 读取的数组
     * 返回值 Int64 - 返回读取的长度
     */
    public func read(sink: Array<Byte>): Int64

    /*
     * 将Sink中的字节序列读入给定的ByteBuffer。
     * 参数 ByteBuffer - 读取的byteBuffer
     * 返回值 Int64 - 读取的长度
     */
    public func read(sink: ByteBuffer): Int64  

    /*
     * 从Sink中带有起始索引和结束索引的子序列复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - sink
     * 参数 Int64 - offset 偏移量
     * 参数 Int64 - byteCount 计数长度
     * 返回值 Int64 - 返回读取的字节数
     */
    public func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64

    /*
     * 从这个source中删除一个字节并返回它。
     * 返回值 Int8 - 返回的字节
     */
    public func readInt8(): Int8

    /*
     * 从这个源中删除两个字节，并返回一个大端int16
     * 返回值 Int16 - 大端int16
     */
    public func readInt16(): Int16

    /*
     * 从这个源中删除两个字节，并返回一个小端int16
     * 返回值 Int16 - 小端int16
     */
    public func readInt16Le(): Int16

    /*
     * 从这个源中删除四个字节，并返回一个大端int32
     * 返回值 Int32 - 大端int32
     */
    public func readInt32(): Int32

    /*
     * 从这个源中删除四个字节，并返回一个小端int32
     * 返回值 Int32 - 小端int32
     */
    public func readInt32Le(): Int32

    /*
     * 从这个源中删除八个字节，并返回一个大端int64
     * 返回值 Int64 - 大端int64
     */
    public func readInt64(): Int64

    /*
     * 从这个源中删除八个字节，并返回一个小端int64
     * 返回值 Int64 - 小端int64
     */
    public func readInt64Le(): Int64

    /*
     * 从该源读取带符号的十进制形式的长字符串（即，以10为基数的字符串，可选前导“-”）。遇到非数字字符停止。
     * 返回值 Int64 - Int64
     */
    public func readDecimalInt64(): Int64

    /*
     * 以十六进制形式读取此源的长格式（即以16为基数的字符串）。遇到非十六进制字符停止。
     * 返回值 Int64 - Int64
     */
    public func readHexadecimalUInt64(): Int64

    /*
     * 从中删除所有字节并将其作为字节字符串返回
     * 返回值 ByteString - ByteString
     */
    public func readByteString(): ByteString  

    /*
     * 从中删除byteCount字节并将其作为字节字符串返回。
     * 参数 Int64 - byteCount
     * 返回值 ByteString - ByteString
     */
    public func readByteString(byteCount: Int64): ByteString 

    /*
     * 从中删除所有字节并将其作为字节数组返回
     * 返回值 Array<Byte> - 返回的字节数组
     */
    public func readByteArray(): Array<Byte>

    /*
     * 从中删除byteCount字节并将其作为字节数组返回。
     * 参数 Int64 - byteCount
     * 返回值 Array<Byte> - 返回的字节数组
     */
    public func readByteArray(byteCount: Int64): Array<Byte>

    /*
     * 从中精确删除BufferedSink长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数  Array<Byte> - 写入的字节数组
     */
    public func readFully(sink: Array<Byte>): Unit

    /*
     * 从中精确删除byteCount长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数 Buffer - sink 写入的数据源
     * 参数 Int64 - byteCount 写入的长度
     */
    public func readFully(sink: Buffer, byteCount: Int64): Unit

    /*
     * 从中删除所有字节并将它们附加到sink。返回写入接收器的总字节数，如果用完，则为0。
     * 参数 Sink - 写入的数据源
     * 返回值 Int64 - 返回字节数
     */
    public func readAll(sink: Sink): Int64

    /*
     * 删除其中的所有字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回空字符串
     * 返回值 String - String
     */
    public func readUtf8(): String

    /*
     * 删除其中的byteCount长度的字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回空字符串
     * 参数 Int64 - byteCount
     * 返回值 String - String
     */
    public func readUtf8(byteCount: Int64): String

    /*
     * 删除其中的所有字节，将其解码为默认UTF-8，并返回字符串
     * 返回值 String - String
     */
    public func readString(): String

    /*
     * 删除其中的byteCount长度的字节，将其解码为默认UTF-8，并返回字符串
     * 参数 Int64 - byteCount
     * 返回值 String - String
     */
    public func readString(byteCount: Int64): String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    public func readUtf8Line(): ?String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    public func readUtf8LineStrict(): ?String

    /*
     * 与readUtf8LineStrict（）类似，但这允许调用者指定允许的最长匹配。使用此选项可防止不包含“\n”或“\r\n”的流。返回的字符串最多只能包含UTF-8字节，扫描的最大字节数为limit+2。如果limit==0，则始终会引发EOFException，因为不会扫描任何字节。
     * 参数 Int64 - limit
     * 返回值 ?String - Option<String>
     */
    public func readUtf8LineStrict(limit: Int64): ?String

    /*
     * 删除并返回单个UTF-8代码点，根据需要读取1到4个字节。
     * 返回值 Int64 - 返回字节数
     */
    public func readUtf8CodePoint(): Int64

    /*
     * 相当于indexOf(value，0)。
     * 参数 Int8 - value
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(value: Int8): Int64

    /*
     * 返回缓冲区中fromIndex处或之后的第一个value的索引。这会根据需要扩展缓冲区，直到找到value。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(value: Int8, fromIndex: Int64): Int64

    /*
     * 如果在fromIndex到toIndex的范围内找到value，则返回value的索引。如果找不到value，或者如果fromIndex==toIndex，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 参数 Int64 - toIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(value: Int8, fromIndex: Int64, toIndex: Int64): Int64

    /*
     * 相当于indexOf(bytes，0)。
     * 参数 ByteString - bytes
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(bytes: ByteString): Int64

    /*
     * 返回缓冲区中fromIndex处或之后字节的第一个匹配项的索引。这会根据需要扩展缓冲区，直到找到字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - bytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(bytes: ByteString, fromIndex: Int64): Int64

    /*
     * 相当于indexOfElement(targetBytes, 0)
     * 参数 ByteString - targetBytes
     * 返回值 Int64 - 索引位置
     */
    public func indexOfElement(targetBytes: ByteString): Int64

    /*
     * 返回此缓冲区中位于fromIndex处或之后的第一个索引，该索引包含targetBytes中的任何字节。这会根据需要扩展缓冲区，直到找到目标字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - targetBytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64

    /*
     * 如果此源中偏移量处的字节等于字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 返回值 Bool - Bool
     */
    public func rangeEquals(offset: Int64, bytes: ByteString): Bool

    /*
     * 如果此源中偏移量处的byteCount字节等于bytesOffset处的字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 参数 Int64 - bytesOffset
     * 参数 Int64 - byteCount
     * 返回值 Bool - Bool
     */
    public func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool

    /*
     * 从此源读取并丢弃byteCount字节。如果源在请求的字节被跳过之前耗尽, 抛出EOFException.
     * 参数 byteCount - byteCount
     */
    public func skip(byteCount: Int64): Unit

    /*
     * 返回一个新的BufferedSource，它可以从该BufferedResource读取数据，而不使用它。一旦下次读取或关闭此源，返回的源将变为无效。例如，我们可以使用peek（）向前看并多次读取相同的数据。
     * 返回值 BufferedSource - 新的BufferedSource
     */
    public func peek(): BufferedSource 
}
```

#### 1.1.6 Buffer 实现类

内存中字节的集合。
将数据从一个缓冲区移动到另一个缓冲区时很快。这个类不是将字节从内存中的一个位置复制到另一个位置，而是更改底层字节数组的所有权。
此缓冲区随数据增长而增长。就像ArrayList一样，每个缓冲区都很小。它只消耗所需的内存。
```cangjie
public class Buffer <: Object & BufferedSource & BufferedSink & Equatable<Buffer> & ToString & Hashable {
    // size 成员变量
    prop let size: Int64

    /*
     * 构造函数
     */
    public init() 

    /*
     * 从该源读取带符号的十进制形式的长字符串（即，以10为基数的字符串，可选前导“-”）。遇到非数字字符停止。
     * 返回值 Int64 - Int64
     */
    public func readDecimalInt64(): Int64

    /*
     * 以十六进制形式读取此源的长格式（即以16为基数的字符串）。遇到非十六进制字符停止。
     * 返回值 Int64 - Int64
     */
    public func readHexadecimalUInt64(): Int64

    /*
     * 从Source中删除至少1个字节，并将它们附加到Sink中。返回读取的字节数，如果此Source已用完，则返回-1。
     * 参数 Buffer - okio的Buffer对象, Sink的实现类
     * 参数 Int64 - 计数器
     * 返回值 Int64 - 返回读取的字节数，如果此Source已用完，则返回-1。
     */
    public func read(sink: Buffer, byteCount: Int64): Int64

    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的。
     */
    public func close(): Unit 

    /*
     * 返回此接收器的超时对象
     * 返回值 Timeout - 超时对象
     */
    public func timeout(): Timeout

    /*
	 * 判断资源是否关闭 (Buffer缓冲对象, 没有关闭资源的操作, 调用时会抛异常)
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public func isClosed(): Bool

    /*
     * 返回此ByteBuffer的哈希值
     * 返回值 Int64 - Int64
     */
    public func hashCode(): Int64

    /*
     * 从Source中删除byteCount字节并将其附加到此Sink中。
     * 参数 Buffer - okio的Buffer对象, source的实现类
     * 参数 Int64 - 计数器
     */
    public func write(source: Buffer, bytecount: Int64): Unit

    /*
     * 判断buffer是否相等
     * 参数 Buffer - 另一个buffer对象
     * 返回值 Bool - 相等返回true， 反之返回false。
     */
    public func == (that: Buffer): Bool

    /*
     * 判断buffer是否不相等
     * 参数 Buffer - 另一个buffer对象
     * 返回值 Bool - 相等返回false， 反之返回true。
     */
    public func != (that: Buffer): Bool

    /*
     * 对象的toString函数
     * 返回值 String - 对象的字符串表示
     */
    public func toString(): String

    /*
     * 返回段中不可写的字节数。这是在不影响吞吐量的情况下可以立即刷新到基础接收器的字节数。
     * 返回值 Int64 - 返回字节数
     */
    public func completeSegmentByteCount(): Int64

    /*
     * 丢弃此缓冲区中的所有字节。在完成缓冲区时调用此方法会将其段返回到池中。
     * 返回值 Unit - Unit
     */
    public func clear(): Unit

    /*
     * 将此内容复制到out。
     * 参数 Buffer - out
     * 参数 Int64 - offset 偏移量
     * 参数 Int64 - byteCount 字节数
     * 返回值 Buffer - Buffer
     */
    public func copyTo(out: Buffer, offset: Int64, byteCount: Int64): Buffer

    /*
     * 返回位置处的字节。
     * 参数 Int64 - 索引
     * 返回值 Int8 - 返回的字节
     */
    public func getInt8(pos: Int64): Int8
    
    /*
     * 向该Buffer写入一个完整的字节数组。
     * 参数 source - 字节数组
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(source: Array<Byte>): BufferedSink 

    /*
     * 向该Buffer写入一个从offset开始byteCount长度的字节数组.
     * 参数 source - 字节数组
     * 参数 offset - 偏移量, 开始写入的位置
     * 参数 byteCount - 字节数, 写入的长度
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(source: Array<Byte>, offset: Int64, byteCount: Int64): BufferedSink

    /*
     * 从中删除所有字节，并将其作为字节字符串返回
     * 返回值 ByteString - ByteString
     */
    public func readByteString(): ByteString
    
    /*
     * 向该Buffer写入一个完整的字节字符串。
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(byteString: ByteString): BufferedSink 
    
    /*
     * 获取buffer类
     * 返回值 Buffer - Buffer类
     */
    public func getBuffer(): Buffer

    /*
     * 如果此源中没有更多字节，则返回true。这将阻塞，直到有字节要读取或源完全耗尽。
     * 返回值 Bool - bool
     */
    public func exhausted(): Bool

    /*
     * 当缓冲区至少包含byteCount字节时返回。如果Source在读取所需字节之前耗尽, 将抛出EOFException.
     * 参数 Int64 - byteCount 计数器
     */
    public func require(byteCount: Int64): Unit

    /*
     * 当缓冲区至少包含byteCount字节时，返回true，并根据需要进行扩展。如果源在读取请求的字节之前耗尽，则返回false。
     * 参数 Int64 - byteCount 计数器
     * 返回值 Bool - Bool
     */
    public func request(byteCount: Int64): Bool

    /*
     * 从Sink中复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - 读取的数组
     * 返回值 Int64 - 返回读取的长度
     */
    public func read(sink: Array<Byte>): Int64

    /*
     * 将Sink中的字节序列读入给定的ByteBuffer。
     * 参数 ByteBuffer - 读取的byteBuffer
     * 返回值 Int64 - 读取的长度
     */
    public func read(sink: ByteBuffer): Int64  

    /*
     * 从Sink中带有起始索引和结束索引的子序列复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - sink
     * 参数 Int64 - offset 偏移量
     * 参数 Int64 - byteCount 计数长度
     * 返回值 Int64 - 返回读取的字节数
     */
    public func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64

    /*
     * 从这个source中删除一个字节并返回它。
     * 返回值 Int8 - 返回的字节
     */
    public func readInt8(): Int8

    /*
     * 从这个源中删除两个字节，并返回一个大端int16
     * 返回值 Int16 - 大端int16
     */
    public func readInt16(): Int16

    /*
     * 从这个源中删除两个字节，并返回一个小端int16
     * 返回值 Int16 - 小端int16
     */
    public func readInt16Le(): Int16

    /*
     * 从这个源中删除四个字节，并返回一个大端int32
     * 返回值 Int32 - 大端int32
     */
    public func readInt32(): Int32

    /*
     * 从这个源中删除四个字节，并返回一个小端int32
     * 返回值 Int32 - 小端int32
     */
    public func readInt32Le(): Int32

    /*
     * 从这个源中删除八个字节，并返回一个大端int64
     * 返回值 Int64 - 大端int64
     */
    public func readInt64(): Int64

    /*
     * 从这个源中删除八个字节，并返回一个小端int64
     * 返回值 Int64 - 小端int64
     */
    public func readInt64Le(): Int64

    /*
     * 从中删除所有字节并将其作为字节字符串返回
     * 返回值 ByteString - ByteString
     */
    public func readByteString(): ByteString  

    /*
     * 从中删除byteCount字节并将其作为字节字符串返回。
     * 参数 Int64 - byteCount
     * 返回值 ByteString - ByteString
     */
    public func readByteString(byteCount: Int64): ByteString 

    /*
     * 从中删除所有字节并将其作为字节数组返回
     * 返回值 Array<Byte> - 返回的字节数组
     */
    public func readByteArray(): Array<Byte>

    /*
     * 从中删除byteCount字节并将其作为字节数组返回。
     * 参数 Int64 - byteCount
     * 返回值 Array<Byte> - 返回的字节数组
     */
    public func readByteArray(byteCount: Int64): Array<Byte>

    /*
     * 从中精确删除BufferedSink长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数  Array<Byte> - 写入的字节数组
     */
    public func readFully(sink: Array<Byte>): Unit

    /*
     * 从中精确删除byteCount长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数 Buffer - sink 写入的数据源
     * 参数 Int64 - byteCount 写入的长度
     */
    public func readFully(sink: Buffer, byteCount: Int64): Unit

    /*
     * 从中删除所有字节并将它们附加到sink。返回写入接收器的总字节数，如果用完，则为0。
     * 参数 Sink - 写入的数据源
     * 返回值 Int64 - 返回字节数
     */
    public func readAll(sink: Sink): Int64

    /*
     * 删除其中的所有字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回None
     * 返回值 String - String
     */
    public func readUtf8(): String

    /*
     * 删除其中的byteCount长度的字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回空字符串
     * 参数 Int64 - byteCount
     * 返回值 String - String
     */
    public func readUtf8(byteCount: Int64): String

    /*
     * 删除其中的所有字节，将其解码为默认UTF-8，并返回字符串
     * 返回值 String - String
     */
    public func readString(): String

    /*
     * 删除其中的byteCount长度的字节，将其解码为默认UTF-8，并返回字符串
     * 参数 Int64 - byteCount
     * 返回值 String - String
     */
    public func readString(byteCount: Int64): String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    public func readUtf8Line(): ?String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    public func readUtf8LineStrict(): ?String

    /*
     * 与readUtf8LineStrict（）类似，但这允许调用者指定允许的最长匹配。使用此选项可防止不包含“\n”或“\r\n”的流。返回的字符串最多只能包含UTF-8字节，扫描的最大字节数为limit+2。如果limit==0，则始终会引发EOFException，因为不会扫描任何字节。
     * 参数 Int64 - limit
     * 返回值 ?String - Option<String>
     */
    public func readUtf8LineStrict(limit: Int64): ?String

    /*
     * 删除并返回单个UTF-8代码点，根据需要读取1到4个字节。
     * 返回值 Int64 - 返回字节数
     */
    public func readUtf8CodePoint(): Int64

    /*
     * 相当于indexOf(value，0)。
     * 参数 Int8 - value
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(value: Int8): Int64

    /*
     * 返回缓冲区中fromIndex处或之后的第一个value的索引。这会根据需要扩展缓冲区，直到找到value。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(value: Int8, fromIndex: Int64): Int64

    /*
     * 如果在fromIndex到toIndex的范围内找到value，则返回value的索引。如果找不到value，或者如果fromIndex==toIndex，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 参数 Int64 - toIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(value: Int8, fromIndex: Int64, toIndex: Int64): Int64

    /*
     * 相当于indexOf(bytes，0)。
     * 参数 ByteString - bytes
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(bytes: ByteString): Int64

    /*
     * 返回缓冲区中fromIndex处或之后字节的第一个匹配项的索引。这会根据需要扩展缓冲区，直到找到字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - bytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(bytes: ByteString, fromIndex: Int64): Int64

    /*
     * 相当于indexOfElement(targetBytes, 0)
     * 参数 ByteString - targetBytes
     * 返回值 Int64 - 索引位置
     */
    public func indexOfElement(targetBytes: ByteString): Int64

    /*
     * 返回此缓冲区中位于fromIndex处或之后的第一个索引，该索引包含targetBytes中的任何字节。这会根据需要扩展缓冲区，直到找到目标字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - targetBytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64

    /*
     * 如果此源中偏移量处的字节等于字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 返回值 Bool - Bool
     */
    public func rangeEquals(offset: Int64, bytes: ByteString): Bool

    /*
     * 如果此源中偏移量处的byteCount字节等于bytesOffset处的字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 参数 Int64 - bytesOffset
     * 参数 Int64 - byteCount
     * 返回值 Bool - Bool
     */
    public func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool

    /*
     * 从此源读取并丢弃byteCount字节。如果源在请求的字节被跳过之前耗尽, 抛出EOFException.
     * 参数 byteCount - byteCount
     */
    public func skip(byteCount: Int64): Unit

    /*
     * 返回一个新的BufferedSource，它可以从该BufferedResource读取数据，而不使用它。一旦下次读取或关闭此源，返回的源将变为无效。例如，我们可以使用peek（）向前看并多次读取相同的数据。
     * 返回值 BufferedSource - 新的BufferedSource
     */
    public func peek(): BufferedSource 
    
        
    /*
     * 获取此BufferedSink的缓冲对象
     * 返回值 Buffer - Buffer
     */
    public func buffer (): Buffer

    /*
     * 向BufferedSink中写入一个完整的ByteString所包含的字节序列
     * 参数 Buffer - okio的ByteString对象
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(byteString: ByteString): BufferedSink  

    /*
     * 向BufferedSink中写入一个source中包含bytecount个的字节序列
     * 参数 Source - 读取的source
     * 参数 Int64 - 写入的计数器
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(source: Source, byteCount: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个完整source的字节序列
     * 参数 Buffer - 读取的source
     * 返回值 Int64 - Int64
     */
    public func writeAll(source: Source): Int64

    /*
     * 向BufferedSink中写入UTF-8编码的字符串.
     * 参数 String - 读取的String
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeUtf8(string: String): BufferedSink

    /*
     * 向BufferedSink中写入UTF-8编码带有起始和结束范围的字符串.
     * 参数 String - 读取的String
     * 参数 Int64 - 开始索引
     * 参数 Int64 - 结束索引
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink

    /*
     * 用UTF-8编码codePoint并将其写入此BufferedSink。
     * 参数 Int64 - UTF-8的数字表示形式
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeUtf8CodePoint(codePoInt64: Int64): BufferedSink 

    /*
     * 向BufferedSink中写入一个int8的字节
     * 参数 Int64 - 写入一个不超过int8.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt8(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt16(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt16Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt32(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt32Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt64(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt64Le(value: Int64): BufferedSink

    /*
     * 将BufferedSink所有缓冲数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    public func emit(): BufferedSink

    /*
     * 将完整Segment数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    public func emitCompleteSegments(): BufferedSink 
}
```

#### 1.1.7 ByteString 类

不可变的字节序列。
```cangjie
public open class ByteString <: Object & Hashable & ToString & Equatable<ByteString> {
    // size 成员变量
    prop let size: Int64

    /*
     * 构造一个ByteString。
     * 参数 Array<Byte> - Array<Byte> 数据源
     */
    public init (data: Array<Byte>)
    /*
     * 返回包含数据字节克隆的新字节字符串。
     * 参数 Array<Byte> - Array<Byte>
     * 返回值 ByteString - ByteString
     */
    public static func of (data: Array<Byte>): ByteString

    /*
     * 返回一个新的字节字符串，该字符串包含从偏移量开始的数据字节计数字节的副本。
     * 参数 Array<Byte> - 字节数据源
     * 参数 Int64 - offset 偏移量
     * 参数 Int64 - byteCount 字节长度
     * 返回值 ByteString - 返回新的byteString
     */
    public static func of(target: Array<Byte>, offset: Int64, byteCount: Int64): ByteString

    /*
     * 判断ByteString是否相等
     * 参数 ByteString - 另一个ByteString对象
     * 返回值 Bool - 相等返回true， 反之返回false。
     */
    operator public func == (that: ByteString): Bool

    /*
     * 判断ByteString是否不相等
     * 参数 ByteString - 另一个ByteString对象
     * 返回值 Bool - 相等返回false， 反之返回true。
     */
    operator public func != (that: ByteString): Bool

    /*
     * 返回此ByteBuffer的哈希值
     * 返回值 Int64 - Int64
     */
    public func hashCode (): Int64
    
    /*
     * 对象的toString函数
     * 返回值 String - 对象的字符串表示
     */
    public func toString (): String

    /*
     * 返回包含UTF-8字节的新字节字符串。
     * 参数 String - 字符串
     * 返回值 ByteString - ByteString
     */
    public static func encodeUtf8(s: String): ByteString

    /*
     * 通过将字节解码为UTF-8来构造新字符串
     * 返回值 String - 返回的新字符串
     */
    public func UTF8(): String

    /*
     * 通过将字节解码为UTF-8来构造新字符串。
     * 返回值 String - 字符串
     */
    public func base64 (): String

    /*
     * 对Base64编码的字节进行解码，并将其值作为字节字符串返回。如果base64不是base64编码的字节序列，则返回None。
     * 参数 String - 字符串
     * 返回值 ?ByteString - Option<ByteString>
     */
    public static func decodeBase64 (base64: String): ?ByteString

    /*
     * 返回此以十六进制编码的字节字符串
     * 返回值 String - 字节字符串
     */
    public func hex(): String

    /*
     * 对十六进制编码的字节进行解码，并以字节字符串的形式返回其值。
     * 参数 String - hex 十六进制字节
     * 返回值 ByteString - ByteString
     */
    public static func decodeHex(hex: String): ByteString

    /*
     * 从一个输入流中中读取byteCount字节并返回结果。如果input要读取的字节数少于byteCount个。抛出EOFException
     * 参数 InputStream - input
     * 参数 Int64 - byteCount 字节数
     * 返回值 ByteString - ByteString
     */
    public static func read(input: InputStream, byteCount: Int64): ByteString

    /*
     * 从一个输入流中读取返回ByteString
     * 相当于read(input, input.length)
     * 返回值 ByteString - ByteString
     */
    public static func read(input: InputStream): ByteString

    /*
     * 从path路径文件读取返回ByteString
     * 参数 String - 文件路径
     * 返回值 ByteString - ByteString
     */
    public static func read(path: String): ByteString

    /*
     * 返回与此字节字符串相等的字节字符串，但将字节“A”到“Z”替换为“a”到“z”中的相应字节。
     * 返回值 ByteString - ByteString
     */
    public func toAsciiLowercase (): ByteString

    /*
     * 返回与此字节字符串相等的字节字符串，但将字节“a”到“z”替换为“A”到“Z”中的相应字节。
     * 返回值 ByteString - ByteString
     */
    public func toAsciiUppercase (): ByteString

    /*
     * 返回一个字节字符串，该字符串是该字节字符串的子字符串，从指定的索引开始，直到该字符串结束。如果beginIndex为0，则返回此字节字符串。
     * 参数 Int64 - 索引
     * 返回值 ByteString - ByteString
     */
    public func substring(beginIndex: Int64): ByteString

    /*
     * 返回一个字节字符串，它是此字节字符串的子字符串，从指定的beginIndex开始，到指定的endIndex结束。如果beginIndex为0，endIndex为该字节字符串的长度，则返回该字节字符串。
     * 参数 Int64 - 索引
     * 参数 Int64 - 结束索引
     * 返回值 ByteString - ByteString
     */
    public func substring(beginIndex: Int64, endIndex: Int64): ByteString

    /*
     * 返回位置处的字节。
     * 参数 Int64 - 索引位置, 如果索引小于0 或者 超出了byteString的大小, 会抛 IndexOutOfBoundsException 异常.
     * 返回值 Byte - 返回的字节
     */
    public func getByte (pos: Int64): Byte

    /*
     * byteString的长度
     */
    public prop let size: Int64

    /*
     * 转化为字节数组
     * 返回值 Array<Byte> - Array<Byte>
     */
    public func toByteArray (): Array<Byte>

    /*
     * 把ByteString中数据写入到outpath的文件中
     * 参数 String - 文件路径
     */
    public func write (outPath: String): Unit

    /*
     * 把ByteString中数据写入到out中
     * 参数 OutputStream - 输出流
     */
    public func write (out: OutputStream): Unit

    /*
     * 把ByteString中数据写入到okio.Buffer中
     * 参数 okio.Buffer - buffer缓存
     */
    public func write (buffer: okio.Buffer): Unit

    /*
     * 如果自身ByteString的[offset..offset+byteCount）(左闭右开)中的字节等于其他ByteString的[otherOffset..otherOffset+byteCount）中的字节，则返回true。如果任一范围超出界限，则返回false。
     * 参数 Int64 - 索引
     * 返回值 Bool - bool值
     */
    public func rangeEquals(offset: Int64, other: ByteString, otherOffset: Int64, byteCount: Int64): Bool

    /*
     * 如果自身ByteString的内部数组[offset..offset+byteCount）(左闭右开)中的字节等于其他ByteString的[otherOffset..otherOffset+byteCount）中的字节，则返回true。如果任一范围超出界限，则返回false。
     * 参数 Int64 - 索引
     * 返回值 Bool - bool值
     */
    public func rangeEquals(offset: Int64, other: Array<Byte>, otherOffset: Int64, byteCount: Int64): Bool

    /*
     * 判断原字符串是否以 prefix 为前缀开始
     * 参数 prefix - 被判断的前缀，当 prefix 长度为 0 时，返回 true
     * 返回值 Bool - 如果字符串 prefix 是原字符串的前缀，返回 true，否则返回 false
     */
    public func startsWith(prefix: ByteString): Bool

    /*
     * 判断原字符串是否以 prefix 为前缀开始
     * 参数 prefix - 被判断的前缀，当 prefix 长度为 0 时，返回 true
     * 返回值 Bool - 如果字符串 prefix 是原字符串的前缀，返回 true，否则返回 false
     */
    public func startsWith(prefix: Array<Byte>): Bool

    /*
     * 判断原字符串是否以 suffix 为后缀结尾
     * 参数 suffix - 被判断的后缀，当 suffix 长度为 0 时，返回 true
     * 返回值 Bool - 如果字符串 suffix 是原字符串的后缀，返回 true，否则返回 false
     */
    public func endsWith (suffix: ByteString):Bool

    /*
     * 判断原字符串是否以 suffix 为后缀结尾
     * 参数 suffix - 被判断的后缀，当 suffix 长度为 0 时，返回 true
     * 返回值 Bool - 如果字符串 suffix 是原字符串的后缀，返回 true，否则返回 false
     */
    public func endsWith (suffix: Array<Byte>) :Bool

    /*
     * 返回指定 other 第一次出现的在原字符串的起始索引
     * 参数 ByteString - 搜索的byteString
     * 返回值 Int64 - 如果原字符串中没有 str 字符串，则返回-1
     */
    public func indexOf(other: ByteString): Int64

    /*
     * 返回指定 other 第一次出现的在原字符串的起始索引
     * 参数 ByteString - 搜索的byteString
     * 参数 Int64 - 参数 fromIndex - 以指定的索引 fromIndex 开始搜索，当 fromIndex 小于零正常返回，当 fromIndex 大于等于原字符串长度返回 -1
     * 返回值 Int64 - 如果原字符串中没有 str 字符串，则返回-1
     */
    public func indexOf(other: ByteString, fromIndex: Int64): Int64

    /*
     * 返回指定 other 第一次出现的在原字符串的起始索引
     * 参数  Array<Byte> - 搜索的Array<Byte>
     * 返回值 Int64 - 如果原字符串中没有 str 字符串，则返回-1
     */
    public func indexOf(other: Array<Byte>): Int64

    /*
     * 返回指定 other 第一次出现的在原字符串的起始索引
     * 参数 Array<Byte> - 搜索的Array<Byte>
     * 参数 Int64 - 参数 fromIndex - 以指定的索引 fromIndex 开始搜索，当 fromIndex 小于零正常返回，当 fromIndex 大于等于原字符串长度返回 -1
     * 返回值 Int64 - 如果原字符串中没有 str 字符串，则返回-1
     */
    public func indexOf(other: Array<Byte>, fromIndex: Int64): Int64

    /*
     * 返回指定 other 最后一次出现的在原ByteString内的索引
     * 参数 ByteString - 搜索的ByteString
     * 返回值 Int64 - 如果原字符串中没有 str 字符串，则返回-1
     */
    public func lastIndexOf(other: ByteString) : Int64

    /*
     * 返回指定 other 最后一次出现的在原ByteString内的索引
     * 参数 ByteString - 搜索的ByteString
     * 参数 Int64 - 参数 fromIndex - 以指定的索引 fromIndex 开始搜索，当 fromIndex 小于零正常返回，当 fromIndex 大于等于原字符串长度返回 -1
     * 返回值 Int64 - 如果原字符串中没有 str 字符串，则返回-1
     */
    public func lastIndexOf(other: ByteString, fromIndex: Int64): Int64

    /*
     * 返回指定 other 最后一次出现的在原ByteString内的索引
     * 参数 Array<Byte> - 搜索的 Array<Byte>
     * 返回值 Int64 - 如果原字符串中没有 str 字符串，则返回-1
     */
    public func lastIndexOf(other: Array<Byte>): Int64

    /*
     * 返回指定 other 最后一次出现的在原ByteString内的索引
     * 参数 Array<Byte> - 搜索的 Array<Byte>
     * 参数 Int64 - 参数 fromIndex - 以指定的索引 fromIndex 开始搜索，当 fromIndex 小于零正常返回，当 fromIndex 大于等于原字符串长度返回 -1
     * 返回值 Int64 - 如果原字符串中没有 str 字符串，则返回-1
     */
    public func lastIndexOf(other: Array<Byte>, fromIndex: Int64): Int64

    /*
     * 判断自身的内部数组与 o 的内部数组进行比较, 如果都相同则返回true, 否则返回false.
     * 参数 o - 被比较的对象
     * 返回值 Bool - bool
     */
    public func equals (o: ByteString): Bool
}
```

#### 1.1.8 RealBufferedSink 内部类 (此类属于 okio 私有内部类, 不可直接使用, 该类实现于 BufferedSink 接口. )
##### 1.1.8.1 使用方法
```cangjie 
    let realBufferedSink: BufferedSink = Okio.buffer(sink)
```
##### 1.1.8.2 接口说明
```cangjie
class RealBufferedSink <: BufferedSink {
    // buf 成员字段
    public let buf: okio.Buffer = Buffer()

    // sink 成员字段
    public let sink: Sink

    /*
     * 向该Buffer写入一个完整的字节数组。
     * 参数 source - 字节数组
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(source: Array): BufferedSink

    /*
     * 向该Buffer写入一个从offset开始byteCount长度的字节数组.
     * 参数 source - 字节数组
     * 参数 offset - 偏移量, 开始写入的位置
     * 参数 byteCount - 字节数, 写入的长度
     * 返回值 Buffer - Buffer
     */
    public func write(source: Array, offset: Int64, byteCount: Int64): BufferedSink

    /*
     * 清理sink里面内容，重写父类sink的flush()方法
     * 参数：source：Buffe对象
     * 返回值 Unit
     */
    public func flush(): Unit

    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的
     * 返回值 Unit
     */
    public func close(): Unit

    /*
     * 获取Timeout对象，重写父类sink的timeout()方法
     * 参数：source：Buffe对象
     * 返回值 Timeout对象
     */
    public func timeout(): Timeout

    /*
     * 向BufferedSink中写入一个source中包含bytecount个的字节序列
     * 参数 Source - 读取的source
     * 参数 Int64 - 写入的计数器
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(source: Buffer, byteCount: Int64): Unit

    /*
	 * 判断资源是否关闭，调用Resource接口的isClosed方法
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public func isClosed():Bool

    /*
     * 对象的toString函数
     * 返回值 String - 对象的字符串表示
     */
    public func toString (): String

    /*
     * 获取此BufferedSink的缓冲对象
     * 返回值 Buffer - Buffer
     */
    public func buffer (): Buffer

    /*
     * 向BufferedSink中写入一个完整的ByteString所包含的字节序列
     * 参数 Buffer - okio的ByteString对象
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(byteString: ByteString): BufferedSink  

    /*
     * 向BufferedSink中写入一个source中包含bytecount个的字节序列
     * 参数 Source - 读取的source
     * 参数 Int64 - 写入的计数器
     * 返回值 BufferedSink - BufferedSink
     */
    public func write(source: Source, byteCount: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个完整source的字节序列
     * 参数 Buffer - 读取的source
     * 返回值 Int64 - Int64
     */
    public func writeAll(source: Source): Int64

    /*
     * 向BufferedSink中写入UTF-8编码的字符串.
     * 参数 String - 读取的String
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeUtf8(string: String): BufferedSink

    /*
     * 向BufferedSink中写入UTF-8编码带有起始和结束范围的字符串.
     * 参数 String - 读取的String
     * 参数 Int64 - 开始索引
     * 参数 Int64 - 结束索引
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink

    /*
     * 用UTF-8编码codePoint并将其写入此BufferedSink。
     * 参数 Int64 - UTF-8的数字表示形式
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeUtf8CodePoint(codePoInt64: Int64): BufferedSink 

    /*
     * 向BufferedSink中写入一个int8的字节
     * 参数 Int64 - 写入一个不超过int8.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt8(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt16(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt16Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt32(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt32Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt64(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    public func writeInt64Le(value: Int64): BufferedSink

    /*
     * 将BufferedSink所有缓冲数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    public func emit(): BufferedSink

    /*
     * 将完整Segment数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    public func emitCompleteSegments(): BufferedSink 
}
```

#### 1.1.9 RealBufferedSource 内部类 (此类属于 okio 私有内部类, 不可直接使用, 该类实现于 BufferedSource 接口. )
##### 1.1.9.1 使用方法 
```cangjie
let realBufferedSource: RealBufferedSource = Okio.buffer(source)
```
##### 1.1.9.2 接口说明
```cangjie
class RealBufferedSource <: BufferedSource {

    // buf 成员字段
    let buf: Buffer = Buffer()

    // source 成员字段
    let source: Source

    /*
     * 从Source中删除至少1个字节，并将它们附加到Sink中。返回读取的字节数，如果此Source已用完，则返回-1。
     * 参数 Buffer - okio的Buffer对象, Sink的实现类
     * 参数 Int64 - 计数器
     * 返回值 Int64 - 返回读取的字节数，如果此Source已用完，则返回-1。
     */
    public func read (sink: Buffer, byteCount: Int64): Int64

    /*
     * 从该源读取带符号的十进制形式的长字符串（即，以10为基数的字符串，可选前导“-”）。遇到非数字字符停止。
     * 返回值 Int64 - Int64
     */
    public func readDecimalInt64(): Int64

    /*
     * 以十六进制形式读取此源的长格式（即以16为基数的字符串）。遇到非十六进制字符停止。
     * 返回值 Int64 - Int64
     */
    public func readHexadecimalUInt64(): Int64

    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的
     * 返回值 Unit
     */
    public func close (): Unit

    /*
     * 获取Timeout对象，重写父类sink的timeout()方法
     * 参数 source - Buffe对象
     * 返回值 Timeout对象
     */
    public func timeout(): Timeout

    /*
     * 对象的toString函数
     * 返回值 String - 对象的字符串表示
     */
    public func toString (): String

    /*
     * 判断资源是否关闭，调用Resource接口的isClosed方法
     * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
     */
    public func isClosed(): Bool

    /*
     * 获取buffer类
     * 返回值 Buffer - Buffer类
     */
    public func getBuffer(): Buffer

    /*
     * 如果此源中没有更多字节，则返回true。这将阻塞，直到有字节要读取或源完全耗尽。
     * 返回值 Bool - bool
     */
    public func exhausted(): Bool

    /*
     * 当缓冲区至少包含byteCount字节时返回。如果Source在读取所需字节之前耗尽, 将抛出EOFException.
     * 参数 Int64 - byteCount 计数器
     */
    public func require(byteCount: Int64): Unit

    /*
     * 当缓冲区至少包含byteCount字节时，返回true，并根据需要进行扩展。如果源在读取请求的字节之前耗尽，则返回false。
     * 参数 Int64 - byteCount 计数器
     * 返回值 Bool - Bool
     */
    public func request(byteCount: Int64): Bool

    /*
     * 从Sink中复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - 读取的数组
     * 返回值 Int64 - 返回读取的长度
     */
    public func read(sink: Array<Byte>): Int64

    /*
     * 将Sink中的字节序列读入给定的ByteBuffer。
     * 参数 ByteBuffer - 读取的byteBuffer
     * 返回值 Int64 - 读取的长度
     */
    public func read(sink: ByteBuffer): Int64  

    /*
     * 从Sink中带有起始索引和结束索引的子序列复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - sink
     * 参数 Int64 - offset 偏移量
     * 参数 Int64 - byteCount 计数长度
     * 返回值 Int64 - 返回读取的字节数
     */
    public func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64

    /*
     * 从这个source中删除一个字节并返回它。
     * 返回值 Int8 - 返回的字节
     */
    public func readInt8(): Int8

    /*
     * 从这个源中删除两个字节，并返回一个大端int16
     * 返回值 Int16 - 大端int16
     */
    public func readInt16(): Int16

    /*
     * 从这个源中删除两个字节，并返回一个小端int16
     * 返回值 Int16 - 小端int16
     */
    public func readInt16Le(): Int16

    /*
     * 从这个源中删除四个字节，并返回一个大端int32
     * 返回值 Int32 - 大端int32
     */
    public func readInt32(): Int32

    /*
     * 从这个源中删除四个字节，并返回一个小端int32
     * 返回值 Int32 - 小端int32
     */
    public func readInt32Le(): Int32

    /*
     * 从这个源中删除八个字节，并返回一个大端int64
     * 返回值 Int64 - 大端int64
     */
    public func readInt64(): Int64

    /*
     * 从这个源中删除八个字节，并返回一个小端int64
     * 返回值 Int64 - 小端int64
     */
    public func readInt64Le(): Int64

    /*
     * 从中删除所有字节并将其作为字节字符串返回
     * 返回值 ByteString - ByteString
     */
    public func readByteString(): ByteString  

    /*
     * 从中删除byteCount字节并将其作为字节字符串返回。
     * 参数 Int64 - byteCount
     * 返回值 ByteString - ByteString
     */
    public func readByteString(byteCount: Int64): ByteString 

    /*
     * 从中删除所有字节并将其作为字节数组返回
     * 返回值 Array<Byte> - 返回的字节数组
     */
    public func readByteArray(): Array<Byte>

    /*
     * 从中删除byteCount字节并将其作为字节数组返回。
     * 参数 Int64 - byteCount
     * 返回值 Array<Byte> - 返回的字节数组
     */
    public func readByteArray(byteCount: Int64): Array<Byte>

    /*
     * 从中精确删除BufferedSink长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数  Array<Byte> - 写入的字节数组
     */
    public func readFully(sink: Array<Byte>): Unit

    /*
     * 从中精确删除byteCount长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数 Buffer - sink 写入的数据源
     * 参数 Int64 - byteCount 写入的长度
     */
    public func readFully(sink: Buffer, byteCount: Int64): Unit

    /*
     * 从中删除所有字节并将它们附加到sink。返回写入接收器的总字节数，如果用完，则为0。
     * 参数 Sink - 写入的数据源
     * 返回值 Int64 - 返回字节数
     */
    public func readAll(sink: Sink): Int64

    /*
     * 删除其中的所有字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回空字符串
     * 返回值 String - String
     */
    public func readUtf8(): String

    /*
     * 删除其中的byteCount长度的字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回空字符串
     * 参数 Int64 - byteCount
     * 返回值 String - String
     */
    public func readUtf8(byteCount: Int64): String

    /*
     * 删除其中的所有字节，将其解码为默认UTF-8，并返回字符串
     * 返回值 String - String
     */
    public func readString(): String

    /*
     * 删除其中的byteCount长度的字节，将其解码为默认UTF-8，并返回字符串
     * 参数 Int64 - byteCount
     * 返回值 String - String
     */
    public func readString(byteCount: Int64): String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    public func readUtf8Line(): ?String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    public func readUtf8LineStrict(): ?String

    /*
     * 与readUtf8LineStrict（）类似，但这允许调用者指定允许的最长匹配。使用此选项可防止不包含“\n”或“\r\n”的流。返回的字符串最多只能包含UTF-8字节，扫描的最大字节数为limit+2。如果limit==0，则始终会引发EOFException，因为不会扫描任何字节。
     * 参数 Int64 - limit
     * 返回值 ?String - Option<String>
     */
    public func readUtf8LineStrict(limit: Int64): ?String

    /*
     * 删除并返回单个UTF-8代码点，根据需要读取1到4个字节。
     * 返回值 Int64 - 返回字节数
     */
    public func readUtf8CodePoint(): Int64

    /*
     * 相当于indexOf(value，0)。
     * 参数 Int8 - value
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(value: Int8): Int64

    /*
     * 返回缓冲区中fromIndex处或之后的第一个value的索引。这会根据需要扩展缓冲区，直到找到value。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(value: Int8, fromIndex: Int64): Int64

    /*
     * 如果在fromIndex到toIndex的范围内找到value，则返回value的索引。如果找不到value，或者如果fromIndex==toIndex，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 参数 Int64 - toIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(value: Int8, fromIndex: Int64, toIndex: Int64): Int64

    /*
     * 相当于indexOf(bytes，0)。
     * 参数 ByteString - bytes
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(bytes: ByteString): Int64

    /*
     * 返回缓冲区中fromIndex处或之后字节的第一个匹配项的索引。这会根据需要扩展缓冲区，直到找到字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - bytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOf(bytes: ByteString, fromIndex: Int64): Int64

    /*
     * 相当于indexOfElement(targetBytes, 0)
     * 参数 ByteString - targetBytes
     * 返回值 Int64 - 索引位置
     */
    public func indexOfElement(targetBytes: ByteString): Int64

    /*
     * 返回此缓冲区中位于fromIndex处或之后的第一个索引，该索引包含targetBytes中的任何字节。这会根据需要扩展缓冲区，直到找到目标字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - targetBytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    public func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64

    /*
     * 如果此源中偏移量处的字节等于字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 返回值 Bool - Bool
     */
    public func rangeEquals(offset: Int64, bytes: ByteString): Bool

    /*
     * 如果此源中偏移量处的byteCount字节等于bytesOffset处的字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 参数 Int64 - bytesOffset
     * 参数 Int64 - byteCount
     * 返回值 Bool - Bool
     */
    public func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool

    /*
     * 从此源读取并丢弃byteCount字节。如果源在请求的字节被跳过之前耗尽, 抛出EOFException.
     * 参数 byteCount - byteCount
     */
    public func skip(byteCount: Int64): Unit

    /*
     * 返回一个新的BufferedSource，它可以从该BufferedResource读取数据，而不使用它。一旦下次读取或关闭此源，返回的源将变为无效。例如，我们可以使用peek（）向前看并多次读取相同的数据。
     * 返回值 BufferedSource - 新的BufferedSource
     */
    public func peek(): BufferedSource 
}
```

#### 1.1.10 Utf8 类 

```cangjie
public class Utf8 {
    
    /*
     * 返回使用ByteString.encodeUtf8或Buffer.writeUtf8（字符串）时用于将字符串编码为UTF-8的字节数。
     * 参数 str - 源字符串
     * 返回值 Int64 - 字节数
     */
    static func size(str: String): Int64
     返回使用BufferedSink.writeUtf8（string，int，int）时用于将字符串片段编码为UTF-8的字节数。

    /*
     * 返回使用ByteString.encodeUtf8或Buffer.writeUtf8（字符串）时用于将字符串编码为UTF-8的字节数。
     * 参数 str - 源字符串
     * 参数 beginIndex - 起始索引
     * 参数 endIndex - 结束索引
     * 返回值 Int64 - 字节数
     */
    static func size(str: String, beginIndex: Int64, endIndex: Int64): Int64 
}
```

#### 1.1.11 nio 组件

```cangjie

/*
 * 数组拷贝函数
 * 参数 src - 源数组对象
 * 参数 srcPos - 源数组对象拷贝的起始索引
 * 参数 dest - 目标数组对象
 * 参数 destPos - 目标数组对象拷贝的起始索引
 * 参数 length - 拷贝的长度
 * 返回值 Unit
 */
public func ArrayCopy(src: Array, srcPos: Int64, dest: Array, destPos: Int64, length: Int64)

public class BufferOverflowException <: Exception {
    /*
     * 异常构造函数
     */
    public init () 
}

```

##### 1.1.11.1 abstract class Buffer

    缓冲区(Buffer)就是在内存中预留指定大小的存储空间用来对输入/输出(I/O)的数据作临时存储，这部分预留的内存空间就叫做缓冲区：
    使用缓冲区有这么两个好处：
    1、减少实际的物理读写次数
    2、缓冲区在创建时就被分配内存，这块内存区域一直被重用，可以减少动态分配和回收内存的次数

```cangjie
public abstract class Buffer <: Object & ToString {
    /*
     * 返回此缓冲区的容量。
     * 返回值 Int64 - 容量大小
     */
    public func capacity(): Int64

    /*
     * 返回此缓冲区的位置。
     * 返回值 Int64 - 位置
     */
    public func position(): Int64
    
    /*
     * 设置此缓冲区的位置。如果标记(mark)已定义且大于新位置(newPosition)，则丢弃该标记(mark)
     * 参数 newPosition - 新位置值；必须为非负且不大于当前限制(limit)
     * 返回值 Buffer - Buffer
     */
    public func position(newPosition: Int64): Buffer
    
    /*
     * 返回此缓冲区的限制。
     * 返回值 Int64 - 限制大小
     */
    public func limit(): Int64 
    
    /*
     * 设置此缓冲区的限制（limit）。
     * 如果位置（position）大于新限制（newlimit），则将其设置为新限制（limit）。
     * 如果标记（mark）已定义且大于新限制，则将丢弃该标记。
     * 参数 newPosition - 新的极限值；必须为非负，且不大于此缓冲区的容量（capacity）
     * 返回值 Buffer - Buffer
     */
    public func limit(newLimit: Int64): Buffer 
    
    /*
     * 返回此缓冲区的标记（mark）。
     * 返回值 Buffer - Buffer
     */
    public func mark(): Buffer
    
    /*
     * 将此缓冲区的位置重置为先前标记的位置，调用此方法既不会更改也不会丢弃标记的值。
     * 内部逻辑是把position设置成mark的值，相当于之前做过一个标记，现在要退回到之前标记的位置。
     * 返回值 Buffer - Buffer
     */
    public func reset(): Buffer
    
    /*
     * 重置初始化状态。它通常用于清除操作。
     * 此方法的功能是所有状态都将返回到初始状态。position=0， mark=-1，limit=capacity；
     * 注意，此方法与flip的区别在于limit的值是不一样的。
     * 返回值 Buffer - Buffer
     */
    public func clear(): Buffer
    
    /*
     * 翻转状态，将一个处于存数据状态的缓冲区变为一个处于准备取数据的状态，
     * 也就是让flip之后的position到limit这块区域变成之前的0到position这块
     * limit = position;position = 0;mark = -1;
     * 返回值 Buffer - Buffer
     */
    public func flip(): Buffer
    
    /*
     * 清零，一版用于写完之后的数据，想从起始位置开始读数据的情形
     * 把position设为0，mark设为-1，不改变limit的值。
     * 返回值 Buffer - Buffer
     */
    public func rewind(): Buffer
    
    /*
     * 返回limit和position之间相对位置差
     * 返回值 Int64 - 差
     */
    public func remaining(): Int64 
    
    /*
     * 返回是否还有未读内容
     * 返回值 Bool - 布尔值
     */
    public func hasRemaining(): Bool 
    
    /*
     * 返回此缓冲区中的第一个元素在缓冲区的底层实现数组中的偏移量 （可选操作）。
     * 如果存在实现此缓冲区的数组，则缓冲区位置 p 对应于数组索引 p + arrayOffset()。
     * 调用此方法之前要调用 hasArray 方法，以确保此缓冲区具有可访问的底层实现数组。
     * 返回值 Int64 - 偏移量
     */
    public func arrayOffset(): Int64
    
    /*
     * 实现此缓冲区的数组返回新的字节缓冲区
     * 新缓冲区的内容将从此缓冲区的当前位置开始。
     * 此缓冲区内容的更改在新缓冲区中是可见的，反之亦然；这两个缓冲区的位置、界限和标记值是相互独立的。
     * 新缓冲区的位置将为零，其容量和界限将为此缓冲区中所剩余的字节数量，其标记是不确定的。
     * 当且仅当此缓冲区为直接时，新缓冲区才是直接的，当且仅当此缓冲区为只读时，新缓冲区才是只读的。
     * 返回值 Int64 - Buffer
     */
    public func slice(): Buffer 
    
    /*
     * 创建共享此缓冲区内容的新的字节缓冲区。
     * 新缓冲区的内容将为此缓冲区的内容。
     * 此缓冲区内容的更改在新缓冲区中是可见的，反之亦然；这两个缓冲区的位置、界限和标记值是相互独立的。
     * 新缓冲区的容量、界限、位置和标记值将与此缓冲区相同。
     * 当且仅当此缓冲区为直接时，新缓冲区才是直接的，当且仅当此缓冲区为只读时，新缓冲区才是只读的。
     * 返回值 Buffer - Buffer
     */
    public func duplicate(): Buffer 
    
    /*
     * 返回支持此缓冲区的数组。
     * 此方法旨在允许更有效地将数组支持的缓冲区传递给本机代码。
     * 具体的实现子类会为该方法提供了更强类型的返回值。
     * 对该缓冲区内容的修改将导致返回数组的内容被修改，反之亦然。
     * 在调用此方法之前调用hasArray方法，以确保此缓冲区具有可访问的后备数组。
     * 返回值 Array<UInt8> - 数组
     */
    public func array(): Array<UInt8>
    
}
```

##### 1.1.11.2 abstract class ByteBuffer

```cangjie
public abstract class ByteBuffer <: Buffer & ToString & Hashable & Equatable<Buffer>  {
    /*
     * ByteBuffer类的主要入口函数.
     * 分配一个新的字节缓冲区。新缓冲区的位置将为零，其界限将为其容量，其标记是不确定的。它将具有一个底层实现数组，且其数组偏移量将为零。
     * 参数 capacity - 新缓冲区的容量，以字节为单位 
     * 返回值 ByteBuffer - ByteBuffer
     */
    public static func allocate(capacity: Int64): ByteBuffer
    
    /*
     * ByteBuffer类的主要入口函数.
     * 将 UInt8 数组包装到缓冲区中。新的缓冲区将由给定的 UInt8 数组支持。
     * 也就是说，缓冲区修改将导致数组修改，反之亦然。
     * 新缓冲区的容量将为array.length，其位置将为offset，其界限将为 offset + length，其标记是不确定的。
     * 其底层实现数组将为给定数组，并且其数组偏移量将为零。
     * 参数 array - 数组
     * 参数 offset - 要使用的子数组的偏移量；必须为非负且不大于array.length。将新缓冲区的位置设置为此值。
     * 参数 length - 要使用的子数组的长度；必须为非负且不大于array.length - offset。将新缓冲区的界限设置为offset + length。 
     * 返回值 ByteBuffer - ByteBuffer
     */
    public static func wrap(array: Array<UInt8>, offset: Int64, length: Int64): ByteBuffer 
    
    /*
     * ByteBuffer类的主要入口函数.
     * 相当于wrap(array, 0, array.size)
     * 参数 array - 数组
     * 返回值 ByteBuffer - ByteBuffer
     */
    public static func wrap(array: Array<UInt8>): ByteBuffer 
    
    /*
     * 实现此缓冲区的数组返回新的字节缓冲区
     * 新缓冲区的内容将从此缓冲区的当前位置开始。
     * 此缓冲区内容的更改在新缓冲区中是可见的，反之亦然；这两个缓冲区的位置、界限和标记值是相互独立的。
     * 新缓冲区的位置将为零，其容量和界限将为此缓冲区中所剩余的字节数量，其标记是不确定的。
     * 当且仅当此缓冲区为直接时，新缓冲区才是直接的，当且仅当此缓冲区为只读时，新缓冲区才是只读的。
     * 返回值 Int64 - Buffer
     */
    public func slice(): ByteBuffer
    
    /*
     * 创建共享此缓冲区内容的新的字节缓冲区。
     * 新缓冲区的内容将为此缓冲区的内容。
     * 此缓冲区内容的更改在新缓冲区中是可见的，反之亦然；这两个缓冲区的位置、界限和标记值是相互独立的。
     * 新缓冲区的容量、界限、位置和标记值将与此缓冲区相同。
     * 当且仅当此缓冲区为直接时，新缓冲区才是直接的，当且仅当此缓冲区为只读时，新缓冲区才是只读的。
     * 返回值 ByteBuffer - ByteBuffer
     */ 
    public func duplicate(): ByteBuffer
    
    
    /*
     * 创建共享此缓冲区内容的新的只读字节缓冲区。
     * 新缓冲区的内容将为此缓冲区的内容。
     * 此缓冲区内容的更改在新缓冲区中是可见的，但新缓冲区将是只读的并且不允许修改共享内容。
     * 两个缓冲区的位置、界限和标记值是相互独立的。
     * 新缓冲区的容量、界限、位置和标记值将与此缓冲区相同。
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func asReadOnlyBuffer(): ByteBuffer
    
    /*
     * 获取一个字节
     * 返回值 UInt8 - UInt8
     */
    public func get(): UInt8
    
    /*
     * 存储一个字节
     * 参数 b - UInt8
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func put(b: UInt8): ByteBuffer
    
    /*
     * 读取指定索引处的字节。 
     * 返回值 UInt8 - UInt8
     */
    public func get(index: Int64): UInt8
    
    /*
     * 将给定字节写入此缓冲区的给定索引处。如果 index 为负或不小于缓冲区界限, 将抛出 IndexOutOfBoundsException 。
     * 参数 index - 将在该位置写入字节的索引
     * 参数 b - 要写入的字节值
     * 返回值 Buffer - Buffer
     */
    public func put(index: Int64, b: UInt8): ByteBuffer
    
    /*
     * 存储一个 Int64（八个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - Int64
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putLong(value: Int64): ByteBuffer

    /*
     * 存储一个 Int32（四个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - Int32
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putInt(value: Int32): ByteBuffer
    
    /*
     * 存储一个 Int16（二个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - Int16
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putShort(value: Int16): ByteBuffer
    
    /*
     * 存储一个 UInt64（八个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - UInt64
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putUInt64(value: UInt64): ByteBuffer
    
    /*
     * 存储一个 UInt32（四个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - UInt32
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putUInt32(value: UInt32): ByteBuffer
    
    /*
     * 存储一个 UInt16（二个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - UInt16
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putUInt16(value: UInt16): ByteBuffer
    
    /*
     * 获取一个 Int64 值（八个字节）
     * 返回值 Int64 - Int64
     */
    public func getLong(): Int64
    
    /*
     * 获取一个 Int32 值（四个字节）
     * 返回值 Int32 - Int32
     */
    public func getInt(): Int32
    
    /*
     * 获取一个 Int16 值（二个字节）
     * 返回值 Int16 - Int16
     */
    public func getShort(): Int16
    
    /*
     * 获取一个 UInt64 值（八个字节）
     * 返回值 UInt64 - UInt64
     */
    public func getUInt64(): UInt64
    
    /*
     * 获取一个 UInt32 值（四个字节）
     * 返回值 UInt32 - UInt32
     */
    public func getUInt32(): UInt32
    
    /*
     * 获取一个 UInt16 值（二个字节）
     * 返回值 UInt16 - UInt16
     */
    public func getUInt16(): UInt16
    
    /*
     * 将此缓冲区的字节传输到给定的目标数组中。
     * 如果此缓冲中剩余的字节少于满足请求所需的字节（即如果 length > remaining()），则不传输字节且抛出Exception。
     * 参数 dst - 向其中写入字节的数组
     * 参数 offset - 要写入的第一个字节在数组中的偏移量；必须为非负且不大于  dst.size
     * 参数 length - 要写入到给定数组中的字节的最大数量；必须为非负且不大于  dst.size - offset
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func get(dst: Array<UInt8>, offset: Int64, length: Int64) : ByteBuffer 
    
    /*
     * 相当于 get(dst, 0, dst.size)
     * 参数 dst - 向其中写入字节的数组
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func get(dst: Array<UInt8>): ByteBuffer
     
    /*
     * 将给定src缓冲区中的剩余字节传输到此缓冲区中。
     * 参数 src - 要从中读取字节的源缓冲区；不能为当前的缓冲区
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func put(src: ByteBuffer) : ByteBuffer 
    
    /*
     * 将给定src数组中的剩余字节传输到此缓冲区中。
     * 参数 src - 要从中读取字节的数组
     * 参数 offset - 要读取的第一个字节在数组中的偏移量；必须为非负且不大于  array.size
     * 参数 length - 要从给定数组读取的字节的数量；必须为非负且不大于  array.size - offset
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func put(src: Array<UInt8>, offset:Int64, length: Int64): ByteBuffer 

    /*
     * 返回此缓冲区中的第一个元素在缓冲区的底层实现数组中的偏移量 （可选操作）。
     * 如果存在实现此缓冲区的数组，则缓冲区位置 p 对应于数组索引 p + arrayOffset()。
     * 调用此方法之前要调用 hasArray 方法，以确保此缓冲区具有可访问的底层实现数组。
     * 返回值 Int64 - 偏移量
     */
    public func arrayOffset(): Int64 
    
    /*
     * 设置此缓冲区的位置。如果标记(mark)已定义且大于新位置(newPosition)，则丢弃该标记(mark)
     * 参数 newPosition - 新位置值；必须为非负且不大于当前限制(limit)
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func position(newPosition: Int64): ByteBuffer

    /*
     * 设置此缓冲区的限制（limit）。
     * 如果位置（position）大于新限制（newlimit），则将其设置为新限制（limit）。
     * 如果标记（mark）已定义且大于新限制，则将丢弃该标记。
     * 参数 newPosition - 新的极限值；必须为非负，且不大于此缓冲区的容量（capacity）
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func limit(newLimit: Int64): ByteBuffer 
    
    /*
     * 将此缓冲区的位置重置为先前标记的位置，调用此方法既不会更改也不会丢弃标记的值。
     * 内部逻辑是把position设置成mark的值，相当于之前做过一个标记，现在要退回到之前标记的位置。
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func reset(): ByteBuffer 
    
    /*
     * 重置初始化状态。它通常用于清除操作。
     * 此方法的功能是所有状态都将返回到初始状态。position=0， mark=-1，limit=capacity；
     * 注意，此方法与flip的区别在于limit的值是不一样的。
     * 返回值 Unit
     */
    public func clear(): Unit
    
    /*
     * 翻转状态，将一个处于存数据状态的缓冲区变为一个处于准备取数据的状态，
     * 也就是让flip之后的position到limit这块区域变成之前的0到position这块
     * limit = position;position = 0;mark = -1;
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func flip(): ByteBuffer
    
    /*
     * 清零，一版用于写完之后的数据，想从起始位置开始读数据的情形
     * 把position设为0，mark设为-1，不改变limit的值。
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func rewind(): ByteBuffer
    
    /*
     * 压缩此缓冲区 （可选操作）。
     * 把从 position 到 limit 中的内容移到 0 到 limit - position 的区域内，position 和 limit 的取值也分别变成 limit - position、capacity。
     * 如果先将 positon 设置到 limit，再 compact，那么相当于 clear()
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func compact(): ByteBuffer
    
    /*
     * 打印ByteBuffer信息
     * 返回值 String - String
     */
    public func toString(): String 
    
    /*
     * 返回此ByteBuffer的哈希值
     * 返回值 Int64 - Int64
     */
    public func hashCode(): Int64 
    
    /*
     * 判断两个ByteBuffer是否是一个对象
     * 返回值 Bool - 相等返回true
     */
    public func ==(that: Buffer): Bool 
    
    /*
     * 判断两个ByteBuffer是否是一个对象
     * 返回值 Bool - 相等返回false
     */
    public func !=(that: Buffer): Bool 
    
    /*
     * 实现此缓冲区的数组返回新的字节缓冲区, 其内容是此缓冲区内容的共享子序列。
     * 新缓冲区的内容将从该缓冲区中的位置索引开始，并包含长度元素。
     * 对该缓冲区内容的更改将在新缓冲区中可见，反之亦然；两个缓冲区的位置、限制和标记值将是独立的。
     * 参数 index - 此缓冲区的开始索引
     * 参数 length - 长度
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func slice(index: Int64, length: Int64): ByteBuffer
}
```

##### 1.1.11.3 HeapByteBuffer 内部实现类 (此类实现 ByteBuffer 抽象类的内部类)

```cangjie
public open class HeapByteBuffer <: ByteBuffer & ToString {
    /*
     * ByteBuffer类的主要入口函数.
     * 分配一个新的字节缓冲区。新缓冲区的位置将为零，其界限将为其容量，其标记是不确定的。它将具有一个底层实现数组，且其数组偏移量将为零。
     * 参数 capacity - 新缓冲区的容量，以字节为单位 
     * 返回值 ByteBuffer - ByteBuffer
     */
    public static func allocate(capacity: Int64): ByteBuffer
    
    /*
     * ByteBuffer类的主要入口函数.
     * 将 UInt8 数组包装到缓冲区中。新的缓冲区将由给定的 UInt8 数组支持。
     * 也就是说，缓冲区修改将导致数组修改，反之亦然。
     * 新缓冲区的容量将为array.length，其位置将为offset，其界限将为 offset + length，其标记是不确定的。
     * 其底层实现数组将为给定数组，并且其数组偏移量将为零。
     * 参数 array - 数组
     * 参数 offset - 要使用的子数组的偏移量；必须为非负且不大于array.length。将新缓冲区的位置设置为此值。
     * 参数 length - 要使用的子数组的长度；必须为非负且不大于array.length - offset。将新缓冲区的界限设置为offset + length。 
     * 返回值 ByteBuffer - ByteBuffer
     */
    public static func wrap(array: Array<UInt8>, offset: Int64, length: Int64): ByteBuffer 
    
    /*
     * ByteBuffer类的主要入口函数.
     * 相当于wrap(array, 0, array.size)
     * 参数 array - 数组
     * 返回值 ByteBuffer - ByteBuffer
     */
    public static func wrap(array: Array<UInt8>): ByteBuffer 
    
    /*
     * 实现此缓冲区的数组返回新的字节缓冲区
     * 新缓冲区的内容将从此缓冲区的当前位置开始。
     * 此缓冲区内容的更改在新缓冲区中是可见的，反之亦然；这两个缓冲区的位置、界限和标记值是相互独立的。
     * 新缓冲区的位置将为零，其容量和界限将为此缓冲区中所剩余的字节数量，其标记是不确定的。
     * 当且仅当此缓冲区为直接时，新缓冲区才是直接的，当且仅当此缓冲区为只读时，新缓冲区才是只读的。
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func slice(): ByteBuffer
    
    /*
     * 创建共享此缓冲区内容的新的字节缓冲区。
     * 新缓冲区的内容将为此缓冲区的内容。
     * 此缓冲区内容的更改在新缓冲区中是可见的，反之亦然；这两个缓冲区的位置、界限和标记值是相互独立的。
     * 新缓冲区的容量、界限、位置和标记值将与此缓冲区相同。
     * 当且仅当此缓冲区为直接时，新缓冲区才是直接的，当且仅当此缓冲区为只读时，新缓冲区才是只读的。
     * 返回值 ByteBuffer - ByteBuffer
     */ 
    public func duplicate(): ByteBuffer
    
    
    /*
     * 创建共享此缓冲区内容的新的只读字节缓冲区。
     * 新缓冲区的内容将为此缓冲区的内容。
     * 此缓冲区内容的更改在新缓冲区中是可见的，但新缓冲区将是只读的并且不允许修改共享内容。
     * 两个缓冲区的位置、界限和标记值是相互独立的。
     * 新缓冲区的容量、界限、位置和标记值将与此缓冲区相同。
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func asReadOnlyBuffer(): ByteBuffer
    
    /*
     * 获取一个字节
     * 返回值 UInt8 - UInt8
     */
    public func get(): UInt8
    
    /*
     * 存储一个字节
     * 参数 b - UInt8
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func put(b: UInt8): ByteBuffer
    
    /*
     * 读取指定索引处的字节。 
     * 参数 index - Int64 索引
     * 返回值 UInt8 - UInt8
     */
    public func get(index: Int64): UInt8
    
    /*
     * 将给定字节写入此缓冲区的给定索引处。如果 index 为负或不小于缓冲区界限, 将抛出 IndexOutOfBoundsException 。
     * 参数 index - 将在该位置写入字节的索引
     * 参数 b - 要写入的字节值
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func put(index: Int64, b: UInt8): ByteBuffer
    
    /*
     * 存储一个 Int64（八个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - Int64
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putLong(value: Int64): ByteBuffer

    /*
     * 存储一个 Int32（四个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - Int32
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putInt(value: Int32): ByteBuffer
    
    /*
     * 存储一个 Int16（二个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - Int16
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putShort(value: Int16): ByteBuffer
    
    /*
     * 存储一个 UInt64（八个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - UInt64
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putUInt64(value: UInt64): ByteBuffer
    
    /*
     * 存储一个 UInt32（四个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - UInt32
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putUInt32(value: UInt32): ByteBuffer
    
    /*
     * 存储一个 UInt16（二个字节），只支持 Big-Endian（大端）写入操作
     * 参数 value - UInt16
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func putUInt16(value: UInt16): ByteBuffer
    
    /*
     * 获取一个 Int64 值（八个字节）
     * 返回值 Int64 - Int64
     */
    public func getLong(): Int64
    
    /*
     * 获取一个 Int32 值（四个字节）
     * 返回值 Int32 - Int32
     */
    public func getInt(): Int32
    
    /*
     * 获取一个 Int16 值（二个字节）
     * 返回值 Int16 - Int16
     */
    public func getShort(): Int16
    
    /*
     * 获取一个 UInt64 值（八个字节）
     * 返回值 UInt64 - UInt64
     */
    public func getUInt64(): UInt64
    
    /*
     * 获取一个 UInt32 值（四个字节）
     * 返回值 UInt32 - UInt32
     */
    public func getUInt32(): UInt32
    
    /*
     * 获取一个 UInt16 值（二个字节）
     * 返回值 UInt16 - UInt16
     */
    public func getUInt16(): UInt16
    
    /*
     * 将此缓冲区的字节传输到给定的目标数组中。
     * 如果此缓冲中剩余的字节少于满足请求所需的字节（即如果 length > remaining()），则不传输字节且抛出Exception。
     * 参数 dst - 向其中写入字节的数组
     * 参数 offset - 要写入的第一个字节在数组中的偏移量；必须为非负且不大于  dst.size
     * 参数 length - 要写入到给定数组中的字节的最大数量；必须为非负且不大于  dst.size - offset
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func get(dst: Array<UInt8>, offset: Int64, length: Int64) : ByteBuffer 
    
    /*
     * 相当于 get(dst, 0, dst.size)
     * 参数 dst - 向其中写入字节的数组
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func get(dst: Array<UInt8>): ByteBuffer
     
    /*
     * 将给定src缓冲区中的剩余字节传输到此缓冲区中。
     * 参数 src - 要从中读取字节的源缓冲区；不能为当前的缓冲区
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func put(src: ByteBuffer) : ByteBuffer 
    
    /*
     * 将给定src数组中的剩余字节传输到此缓冲区中。
     * 参数 src - 要从中读取字节的数组
     * 参数 offset - 要读取的第一个字节在数组中的偏移量；必须为非负且不大于  array.size
     * 参数 length - 要从给定数组读取的字节的数量；必须为非负且不大于  array.size - offset
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func put(src: Array<UInt8>, offset:Int64, length: Int64): ByteBuffer 

    /*
     * 相当于 put(src, 0, src.size)
     * 参数 src - 要从中读取字节的数组
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func put(src: Array<UInt8>): ByteBuffer
    
    /*
     * 判断是否可通过一个可访问的 byte 数组实现此缓冲区。
     * 返回值 Bool - 如果可访问返回 true
     */
    public func hasArray(): Bool 
    
    /*
     * 返回支持此缓冲区的数组。
     * 此方法旨在允许更有效地将数组支持的缓冲区传递给本机代码。
     * 具体的实现子类会为该方法提供了更强类型的返回值。
     * 对该缓冲区内容的修改将导致返回数组的内容被修改，反之亦然。
     * 在调用此方法之前调用hasArray方法，以确保此缓冲区具有可访问的后备数组。
     * 返回值 Array<UInt8> - 数组
     */
    public func array(): Array<UInt8> 
    
    /*
     * 返回此缓冲区中的第一个元素在缓冲区的底层实现数组中的偏移量 （可选操作）。
     * 如果存在实现此缓冲区的数组，则缓冲区位置 p 对应于数组索引 p + arrayOffset()。
     * 调用此方法之前要调用 hasArray 方法，以确保此缓冲区具有可访问的底层实现数组。
     * 返回值 Int64 - 偏移量
     */
    public func arrayOffset(): Int64 
    
    /*
     * 设置此缓冲区的位置。如果标记(mark)已定义且大于新位置(newPosition)，则丢弃该标记(mark)
     * 参数 newPosition - 新位置值；必须为非负且不大于当前限制(limit)
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func position(newPosition: Int64): ByteBuffer

    /*
     * 设置此缓冲区的限制（limit）。
     * 如果位置（position）大于新限制（newlimit），则将其设置为新限制（limit）。
     * 如果标记（mark）已定义且大于新限制，则将丢弃该标记。
     * 参数 newPosition - 新的极限值；必须为非负，且不大于此缓冲区的容量（capacity）
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func limit(newLimit: Int64): ByteBuffer 
    
    /*
     * 将此缓冲区的位置重置为先前标记的位置，调用此方法既不会更改也不会丢弃标记的值。
     * 内部逻辑是把position设置成mark的值，相当于之前做过一个标记，现在要退回到之前标记的位置。
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func reset(): ByteBuffer 
    
    /*
     * 重置初始化状态。它通常用于清除操作。
     * 此方法的功能是所有状态都将返回到初始状态。position=0， mark=-1，limit=capacity；
     * 注意，此方法与flip的区别在于limit的值是不一样的。
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func clear(): Unit
    
    /*
     * 翻转状态，将一个处于存数据状态的缓冲区变为一个处于准备取数据的状态，
     * 也就是让flip之后的position到limit这块区域变成之前的0到position这块
     * limit = position;position = 0;mark = -1;
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func flip(): ByteBuffer
    
    /*
     * 清零，一版用于写完之后的数据，想从起始位置开始读数据的情形
     * 把position设为0，mark设为-1，不改变limit的值。
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func rewind(): ByteBuffer
    
    /*
     * 压缩此缓冲区 （可选操作）。
     * 把从 position 到 limit 中的内容移到 0 到 limit - position 的区域内，position 和 limit 的取值也分别变成 limit - position、capacity。
     * 如果先将 positon 设置到 limit，再 compact，那么相当于 clear()
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func compact(): ByteBuffer
    
    /*
     * 打印ByteBuffer信息
     * 返回值 String - String
     */
    public func toString(): String 
    
    /*
     * 返回此ByteBuffer的哈希值
     * 返回值 Int64 - Int64
     */
    public func hashCode(): Int64 
    
    /*
     * 判断两个ByteBuffer是否是一个对象
     * 返回值 Bool - 相等返回true
     */
    public func ==(that: Buffer): Bool 
    
    /*
     * 判断两个ByteBuffer是否是一个对象
     * 返回值 Bool - 相等返回false
     */
    public func !=(that: Buffer): Bool 
    
    /*
     * 实现此缓冲区的数组返回新的字节缓冲区, 其内容是此缓冲区内容的共享子序列。
     * 新缓冲区的内容将从该缓冲区中的位置索引开始，并包含长度元素。
     * 对该缓冲区内容的更改将在新缓冲区中可见，反之亦然；两个缓冲区的位置、限制和标记值将是独立的。
     * 参数 index - 此缓冲区的开始索引
     * 参数 length - 长度
     * 返回值 ByteBuffer - ByteBuffer
     */
    public func slice(index: Int64, length: Int64): ByteBuffer
```

#### 1.1.12 Segment 类 
```cangjie
public class Segment <: Object & Equatable<Segment> {

    /*
     * 构造一个Segment。
     */
    public init() {

    /*
     * 构造一个Segment。
     * 参数 data - 源数组
     * 参数 pos - 此段中要读取的应用程序数据字节的下一个字节
     * 参数 limit - 准备写入的可用数据的第一个字节。
     * 参数 shared - 如果其他段或字节字符串使用相同的字节数组，则为True
     * 参数 owner - 如果此段拥有字节数组并可以附加到它，则为True，扩展了限制。
     */
    public init(data: Array<UInt8>, pos: Int64, limit: Int64, shared: Bool, owner: Bool)

    /*
     * 在循环链接列表中的此段之后追加段。返回推送的Segment段。
     * 参数 segment - Segment对象
     * 返回值 Segment - Segment对象
     */
    public func push(segment: Segment): Segment


    /*
     * 删除循环链接列表的此段并返回其后续部分。如果列表现在为空，则返回None。
     * 返回值 ?Segment - Segment对象
     */
    public func pop(): ?Segment 

    /*
     * 将循环链接列表的头部拆分为两段。第一段包含[pos..pos+byteCount]中的数据。第二段包含[pos+byteCount..limit]中的数据。
     * 参数 Int64 - 字节数
     * 返回值 Segment - Segment对象
     */
    public func split(byteCount: Int64): Segment

    /*
     * 当结尾和它的前身可能都不到一半时。这将复制数据，以便可以回收段。
     * 返回值 Unit
     */
    public func compact() 

    /*
     * 将此段中的byteCount字节移动到接收器。
     * 参数 sink - 接收器
     * 参数 byteCount - 字节数
     * 返回值 Unit
     */
    public func writeTo(sink: Segment, byteCount: Int64)

    /*
     * 判断两个Segment是否是一个对象
     * 返回值 Bool - 相等返回true
     */
    operator public func ==(that: Segment): Bool 

    /*
     * 判断两个Segment是否是一个对象
     * 返回值 Bool - 相等返回false
     */ 
    operator public func !=(that: Segment): Bool 
}
```
#### 1.1.13 SocketBuffer 类

```cangjie
public open class SocketBuffer <: InputStream & OutputStream & Resource & ToString {
    // length 成员字段
    prop let length: Int64

    /*
     * 构造一个SocketBuffer。
     * 参数 Socket - Socket
     */
    public init(sockClient: Socket) 

    /*
     * 构造一个SocketBuffer。
     * 参数 Socket - Socket
     */
    public init(sockClient: TlsSocket)

    /*
     * 写出到socket字节数组
     * 参数 Array<Byte> - 字节数组
     */
    public func write(buffer: Array<Byte>): Unit

    /*
     * 暂存在socketbuffer中的字节数组刷出去到socket中
     */
    public func flush(): Unit

    /*
     * 读数据到字节数组中
     * 参数 Array<Byte> - 字节数组
     * 返回值 Int64 - 字节数组的长度
     */
    public func read(buffer: Array<Byte>): Int64

    /*
     * 返回该socketbuffer是否是关闭的
     * 返回值 Bool - 关闭为true
     */
    public func isClosed(): Bool

    /*
     * 关闭此源并释放此源持有的资源
     */
    public func close(): Unit

    /*
     * 打印SocketBuffer信息
     * 返回值 String - String
     */
    public func toString(): String
}
```
### 1.2 示例
```cangjie
from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*
main() {
    var file = File("demo.txt", OpenOption.Create(true))
    Okio.buffer(Okio.sink(file))
        .writeUtf8("abcdefghijklmn \n")
        .writeUtf8("中国 \n")
        .writeUtf8("1234")
        .close();

    file = File("demo.txt", OpenOption.Open(true, true))
    let bufferedSource = Okio.buffer(Okio.source(file));
    println(bufferedSource.readUtf8Line())
    println(bufferedSource.readUtf8Line())
    println(bufferedSource.readUtf8Line())
}
```
### 2 提供解/压缩功能

前置条件：NA 

场景：

1. 解/压缩功能

约束：

性能： 支持版本几何性能持平

可靠性： NA

#### 2.1 主要接口

```cangjie
public class GzipSink <: Sink {

    /*
     * 构造一个GzipSink。
     * 参数：sink： Sink接口
     */
    public init(sink: Sink)
    
    /*
     * GzipSink的压缩功能，参数byteCount需要大于零，内部调用DeflaterSink类的write方法
     * 参数：source：Buffe让对象
     * 参数 byteCount： 需要压缩的长度
     * 返回值 Unit
     */
    public func write(source: Buffer,byteCount: Int64): Unit

}
public class GzipSource <: Source {

     /*
     * 构造一个GzipSource。
     * 参数 source： 原Source对象
     */
    public init(source:Source)
    
    /*
     * GzipSource的解压功能，参数byteCount需要大于零，内部调用InflaterSource类的read方法
     * 参数 sink： 压缩后的Buffer对象
     * 参数 byteCount： 需要解压出的长度
     * 返回值 Int64 - 解压后的字节数
     */
    public func read(sink: Buffer,byteCount: Int64): Int64
}
```

#### 2.2相关接口

```cangjie
GzipSink 类 实现了Sink接口

  public class GzipSink <: Sink { 
    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的
     * 返回值 Unit
     */
    public override func close(): Unit
    /*
     * 清理sink里面内容，重写父类sink的flush()方法
     * 参数：source：Buffe对象
     * 返回值 Unit
     */
    public override func flush(): Unit
    /*
     * 获取Timeout对象，重写父类sink的timeout()方法
     * 参数：source：Buffe对象
     * 返回值 Timeout对象
     */
    public override func timeout(): Timeout
    
    /*
	 * 判断资源是否关闭，调用Resource接口的isClosed方法
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public override func isClosed(): Bool
    
    /*
     * 获取String类型，重写toString()方法。
     * 返回值 String类型的sink对象
     */
    public override func toString():String
  }
    
    
DeflaterSink 类 实现了Sink接口，封装了具体的压缩方法
  public class DeflaterSink <: Sink {

    /*
     * 构造一个DeflaterSink。
     * 参数：sink：Sink 对象
     * 参数：deflater：Deflater 对象
     */
    public init(sink: Sink)
    
    /*
	 * 判断资源是否关闭，调用Resource接口的isClosed方法
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public override func isClosed(): Bool
    
    /*
     * DeflaterSink 提供的压缩功能，参数byteCount需要大于零
     * 参数：source：Buffe让对象
     * 参数 byteCount： 需要压缩的长度
     * 返回值 Unit
     */
    public func write(source: Buffer,byteCount: Int64): Unit

  }

  
GzipSource 类 实现了Source接口
  public class GzipSource <: Source {
  
  	/*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的
     * 返回值 Unit
     */
    public override func close(): Unit
    
    /*
     * 获取Timeout对象，重写父类sink的timeout()方法。
     * 参数：source：Buffe对象
     * 返回值 Timeout对象
     */
    public override func timeout(): Timeout
    
    /*
	 * 判断资源是否关闭，调用Resource接口的isClosed方法
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public override func isClosed(): Bool
    
    /*
     * 获取String类型，重写toString()方法。
     * 返回值 String类型的sink对象
     */
    public override func toString():String
  }
  
InflaterSource 类 实现了Source接口，封装了具体的解压缩方法

  public class InflaterSource <: Source {
    /*
     * 构造一个InflaterSource
     * 参数 source： 原Source对象
     */
    public init(source:Source)
    
    /*
     * InflaterSource 的解压功能，参数byteCount需要大于零
     * 参数 sink： 压缩后的Buffer对象
     * 参数 byteCount： 需要解压出的长度
     * 返回值 Int64 - 解压后的字节数
     */
    public func read(sink: Buffer,byteCount: Int64): Int64
    
    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的
     * 返回值 Unit
     */
    public override func close(): Unit
    
    /*
     * 获取Timeout对象，重写父类sink的timeout()方法。
     * 参数：source：Buffe对象
     * 返回值 Timeout对象
     */
    public override func timeout(): Timeout
    
    /*
	 * 判断资源是否关闭，调用Resource接口的isClosed方法
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public override func isClosed(): Bool
    
    /*
     * 获取String类型，重写toString()方法。
     * 返回值 String类型的sink对象
     */
    public override func toString():String
  }
```

#### 2.3 示例

```cangjie
from okio import okio.*
from std import os.posix.*
from std import io.*
from compress import zlib.*
from std import fs.*

main () {
    let data: Buffer = Buffer()
    let testString: String = "Test whether gzipsink can be compressed"
    data.writeUtf8(testString)
    let buffer: Buffer = Buffer()
    let gs: GzipSink = GzipSink(buffer) 
    let str1 = gs.write(data,data.size)
    let str3 = gs.timeout()
    gs.flush()
    gs.close()
    gs.isClosed()
    println(gs.toString())
    gs.toString()
    return 0
}

```

### 3 提供转发功能开发

前置条件：NA

场景：

1. 提供转发功能开发

约束：

性能： 支持版本几何性能持平

可靠性： NA

#### 3.1 主要接口

```cangjie
public abstract class ForwardingSink <: Sink {
	
	/*
     * 构造 Sink 对象
     * 返回值 Sink 对象
     */
    public init(): Sink

	/*
     * 从Source中删除byteCount字节并将其附加到此Sink中
     * 参数 Buffer - okio的Buffer对象, source的实现类
     * 参数 byteCount - Int64 写入长度
     */
    public override open public func write(source: Buffer,byteCount: Int64): Unit
    
}

public abstract class ForwardingSource <: Source{

	/*
     * 构造 Source 对象
     * 返回值 Source 对象
     */
    public init(): Source
    
    /*
     * 从Source中删除至少1个字节，并将它们附加到Sink中。返回读取的字节数，如果此Source已用完，则返回-1
     * 参数 Buffer - okio的Buffer对象, Sink的实现类
     * 参数 Int64 - 读取的长度
     * 返回值 Int64 - 返回读取的字节数，如果此Source已用完，则返回-1
     */
    public override open public func read(sink: Buffer,byteCount:Int64): Int64
}
```

#### 3.2相关接口

```cnagjie
ForwardingSink 类 实现Sink接口，多出获取Sink对象的方法

  public abstract class ForwardingSink <: Sink {
  	/*
     * 获取Sink对象
     * 返回值 Sink对象
     */
    public func delegate(): Sink
    
	/*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的
     * 返回值 Unit
     */
    public override func close(): Unit
    
     /*
	 * 判断资源是否关闭，调用Resource接口的isClosed方法
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public override func isClosed(): Bool
    
    /*
     * 清理sink里面内容，重写父类sink的flush()方法
     * 参数：source：Buffe对象
     * 返回值 Unit
     */
    public override func flush(): Unit
    
    /*
     * 获取Timeout对象，重写父类sink的timeout()方法
     * 参数：source：Buffe对象
     * 返回值 Timeout对象
     */
    public override func timeout(): Timeout
    
    /*
     * 获取String类型，重写toString()方法。
     * 返回值 String类型的sink对象
     */
    public override func toString():String
 }
  
ForwardingSource 类 实现Source接口，多出获取Sink对象的方法
  
  public abstract class ForwardingSource <: Source{
  	/*
     * 获取Source对象
     * 返回值 Source对象
     */
    public func delegate(): Source
    
    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的
     * 返回值 Unit
     */
    public override func close(): Unit
    
     /*
	 * 判断资源是否关闭，调用Resource接口的isClosed方法
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public override func isClosed(): Bool
    
    /*
     * 获取Timeout对象，重写父类sink的timeout()方法
     * 参数：source：Buffe对象
     * 返回值 Timeout对象
     */
    public override func timeout(): Timeout
    
    /*
     * 获取String类型，重写toString()方法。
     * 返回值 String类型的sink对象
     */
    public override func toString():String
 }
 
ForwardingTimeout 类 继承了Timeout类

  public class ForwardingTimeout <: Timeout {
  	/*
     * 构造 ForwardingTimeout 对象
     * 参数 assignment - Timeout对象
     * 返回值 ForwardingTimeout 对象
     */
    public init(assignment: Timeout)
    
 	/*
     * 获取Timeout对象
     * 返回值 Timeout 对象
     */
    public func delegate(): Timeout
    
    /*
     * 给Timeout对象赋值。
     * 参数 assignment - Timeout 超时对象
     * 返回值 ForwardingTimeout 对象
     */
    public func  setDelegate(assignment: Timeout):ForwardingTimeout
    
    /*
     * 获取Timeout对象，重写父类Timeout的timeout(timeout: Int64)方法
     * 参数 timeout - Int64 计数器
     * 返回值 Timeout 对象
     */
    public override func timeout(timeout: Int64):Timeout
    
    /*
     * 获取超时时间纳秒值，重写父类Timeout的timeoutNanos()方法
     * 返回值 Int64 超时时间纳秒值
     */
    public override func timeoutNanos(): Int64
    
    /*
     * 获取是否有截止日期，重写父类Timeout的hasDeadline()方法
     * 返回值 Bool - 如果是 true，否则返回 false
     */
    public override func hasDeadline():Bool
    
    /*
     * 获取截止日期纳秒值，重写父类Timeout的deadlineNanoTime()方法
     * 返回值 Int64 截止日期纳秒值
     */
    public override func deadlineNanoTime():Int64

    /*
     * 获取Timeout对象，重写父类Timeout的deadlineNanoTime（deadlineNanoTime: Int64）方法
     * 参数 deadlineNanoTime - Int64 截至日期纳秒
     * 返回值 Timeout 对象
     */
    public override func deadlineNanoTime(deadlineNanoTime: Int64):Timeout

    /*
     * 清理Timeout变量timeoutnanost，使timeoutnanost值变为零，重写父类clearTimeout()方法
     * 返回值 Timeout 对象
     */
    public override func clearTimeout(): Timeout
    
    /*
     * 清理Timeout变量hasdeadline，使hasdeadline值变为false，重写父类clearDeadline()方法
     * 返回值 Timeout 对象
     */
    public override func clearDeadline(): Timeout
    
    /*
     * 抛出预期，如果hasdeadline为true且deadlinenanotime小于等于当前时间则抛出异常，重写父类throwIfReached()方法
     * 返回值 Unit
     */
    public override func throwIfReached()
  }
```

#### 3.3 示例

```cangjie
from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
main () {
    let bu: Buffer = Buffer()
    let bu1: Buffer = Buffer()
    let s: String = "forwarding test"
    bu1.writeUtf8(s)
    let fwd: ForwardingSink = ForwardingSink(bu)
    let f1 = fwd.delegate()
    let f2 = fwd.write(bu1 , bu1.size)
    let f3 = fwd.flush()
    let f4 = fwd.timeout()
    let f5 = fwd.close()
    let f7 = fwd.toString()

    let bu2: Buffer = Buffer()
    let fws: ForwardingSource = ForwardingSource(bu)
    let s1 = fws.delegate()
    let s2 = fws.read(bu2 , bu.size)
    let s3 = fws.timeout()
    let s4 = fws.close()
    let s5 = fws.toString()
    let s6 = fws.isClosed()
    return 0
}

```

### 4 提供加密/哈希算法功能，和管道工具

前置条件：NA 

场景：

1. 加密/哈希算法

2. 管道工具

约束：

性能： 支持版本几何性能持平

可靠性： NA

#### 4.1 加密/ sha族算法

##### 4.1.1 主要接口

```cangjie
HashingSink类 继承了ForwardingSink抽象类，调用具体算法，返回响应的哈希值

public class HashingSink <: ForwardingSink {

    /*
     * 获取一个使用过时的MD5哈希算法生成128位哈希的接收器
     * 参数sink Sink 对象
     * 返回值 HashingSink 对象
     */
    public static func md5(sink: Sink): HashingSink
    /*
     * 获取一个使用过时的sha1哈希算法生成160位哈希的接收器
     * 参数sink Sink 对象
     * 返回值 HashingSink 对象
     */
    public static func sha1(sink: Sink): HashingSink

    /*
     * 获取一个使用过时的sha256哈希算法生成256位哈希的接收器
     * 参数sink Sink 对象
     * 返回值 HashingSink 对象
     */
    public static func sha256(sink: Sink): HashingSink
    
     /*
     * 获取一个使用过时的sha512哈希算法生成512位哈希的接收器
     * 参数sink Sink 对象
     * 返回值 HashingSink 对象
     */
    public static func sha512(sink: Sink): HashingSink
    
    /*
     * 获取一个使用SHA-1 HMAC算法生成160位哈希的接收器。
     * 参数sink Sink 对象，key - String类型的秘钥
     * 返回值 HashingSink 对象
     */
    public static func hmacSha1(sink: Sink , key: String): HashingSink 
    
    /*
     * 获取一个使用SHA-256 HMAC算法生成256位哈希的接收器。
     * 参数sink Sink 对象，key - String类型的秘钥
     * 返回值 HashingSink 对象
     */
    public static func hmacSha256(sink: Sink , key: String): HashingSink 
    
    /*
     * 获取一个使用SHA-512 HMAC算法生成512位哈希的接收器。
     * 参数sink Sink 对象，key - String类型的秘钥
     * 返回值 HashingSink 对象
     */
    public static func hmacSha512(sink: Sink , key: String): HashingSink
    
    /*
     * 将数据写入接收器中
     * 参数source - Buffer对象，byteCount-Int64 需要加密长度
     */
    public override func write(source: Buffer , byteCount: Int64)
    
    /*
     * 调用MD5加密算法对数据加密，加密后的数据封装在字符串中，然后调用write方法将数据写入接收器中
     * 参数source - Buffer对象，byteCount-Int64 需要加密长度
     */
    public func writeMD5(source: Buffer , byteCount: Int64)
    
    /*
     * 调用SHA1加密算法对数据加密，加密后的数据封装在字符串中，然后调用write方法将数据写入接收器中
     * 参数source - Buffer对象，byteCount-Int64 需要加密长度
     */
    public func writeSHA1(source: Buffer , byteCount: Int64)
    
    /*
     * 调用SHA256加密算法对数据加密，加密后的数据封装在字符串中，然后调用write方法将数据写入接收器中
     * 参数source - Buffer对象，byteCount-Int64 需要加密长度
     */
    public func writeSHA256(source: Buffer , byteCount: Int64)
    
    /*
     * 调用SHA512加密算法对数据加密，加密后的数据封装在字符串中，然后调用write方法将数据写入接收器中
     * 参数source - Buffer对象，byteCount-Int64 需要加密长度
     */
    public func writeSHA512(source: Buffer , byteCount: Int64)
    
    /*
     * 调用hmacSha1加密算法对数据加密，加密后的数据封装在字符串中，然后调用write方法将数据写入接收器中
     * 参数source - Buffer对象，byteCount-Int64 需要加密长度
     */
    public func writehmacSha1(source: Buffer , byteCount: Int64)
    
    /*
     * 调用hmacSha256加密算法对数据加密，加密后的数据封装在字符串中，然后调用write方法将数据写入接收器中
     * 参数source - Buffer对象，byteCount-Int64 需要加密长度
     */
    public func writehmacSha256(source: Buffer , byteCount: Int64)
    
     /*
     * 调用hmacSha512加密算法对数据加密，加密后的数据封装在字符串中，然后调用write方法将数据写入接收器中
     * 参数source - Buffer对象，byteCount-Int64 需要加密长度
     */
    public func writehmacSha512(source: Buffer , byteCount: Int64)
    
    /*
     * 获取加密后的结果
     * 
     * 返回值：加密后的 String 类型数据
     */
    public func hash(): String
    
    /*
	 * 判断资源是否关闭，调用Resource接口的isClosed方法
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public override func isClosed(): Bool
  }
  
HashingSource 类 继承了ForwardingSource抽象类，调用具体算法，返回响应的哈希值

  public class HashingSource <: ForwardingSource {
  	/*
     * 获取一个使用过时的MD5哈希算法生成128位哈希的接收器。
     * 参数source - Source对象
     * 返回值 HashingSource对象
     */
    public static func md5(source:Source):HashingSource
    /*
     * 获取一个使用过时的sha1哈希算法生成160位哈希的接收器。
     * 参数source - Source对象
     * 返回值 HashingSource对象
     */
    public static func sha1(source: Source): HashingSource

    /*
     * 获取一个使用过时的sha256哈希算法生成256位哈希的接收器。
     * 参数source - Source对象
     * 返回值 HashingSource对象
     */
    public static func sha256(source: Source): HashingSource
    
    /*
     * 获取一个使用SHA-1 HMAC算法生成160位哈希的接收器。
     * 参数source - Source对象，key - String类型的秘钥
     * 返回值 HashingSource对象
     */
    public static func hmacSha1(source: Source,key: String):HashingSource 
    
    /*
     * 获取一个使用SHA-256 HMAC算法生成256位哈希的接收器。
     * 参数source - Source对象，key - String类型的秘钥
     * 返回值 HashingSource对象
     */
    public static func hmacSha256(source:Source,key:String):HashingSource
    
    /*
     * 将数据读取到Buffer中
     * 参数sink - Buffer对象，byteCount - Int64 写入长度
     * 返回值 返回读取的字节数
     */
    public override func read(sink: Buffer,byteCount: Int64):Int64
    
    /*
     * 调用MD5加密算法对read方法读取的数据加密
     * 返回值 Unit
     */
    public func readMD5(): Unit 
    
    /*
     * 调用SHA1加密算法对read方法读取的数据加密
     * 返回值 Unit
     */
    public func readSHA1(): Unit 
    
    /*
     * 调用SHA256加密算法对read方法读取的数据加密
     * 返回值 Unit
     */
    public func readSHA256(): Unit 
    
    /*
     * 调用readhmacSha1加密算法对read方法读取的数据加密
     * 返回值 Unit
     */
    public func readhmacSha1(): Unit
    
    /*
     * 调用readhmacSha256加密算法对read方法读取的数据加密
     * 返回值 Unit
     */
    public func readhmacSha256(): Unit
    
    /*
     * 获取加密后的结果
     * 
     * 返回值 加密后的 String 类型数据
     */
    public func hash(): String
    
    /*
	 * 判断资源是否关闭，调用Resource接口的isClosed方法
	 * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
	 */
    public override func isClosed(): Bool
    
  }
```

##### 4.1.2 示例

```cangjie
main () {
	var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let hashingSink: HashingSink = HashingSink.md5(sink)
    source.writeUtf8("helloworld")
    hashingSink.writeMD5(source, 10)
    let a: String = hashingSink.hash()
    if(a != "fc5e038d38a57032085441e7fe7010b0") {
        return -1
    }
    return 0
}
```

#### 4.2 管道扩展类

##### 4.2.1 主要接口

```cangjie
Pipe 类 okio管道类，使用一个缓冲区来解耦源和接收器。该缓冲区具有用户指定的大小。当生产线程的运行速度超过消费线程时，缓冲区会被填满，并最终写入接收器，直到消	 	费线程赶上。对称地，如果消费者超出了它的生产者读块，直到有数据可读。
  public class Pipe {

    /*
     * 构造 Pipe 对象
     * 参数 bufferSize - Int64 用户制定的缓冲区大小
     */
     public init(bufferSize: Int64)
 	/*
     * 获取source对象
     * 返回值 Source 对象
     */
    public func source(): Source 
    
    /*
     * 获取sink对象
     * 返回值 Sink 对象
     */
    public func sink(): Sink
    
    /*
     * 将管道的缓冲内容写入 sink接收器，然后用 sink接收器替换此管道的源，如果管道关闭抛出异常。
     * 参数 sink - Sink 对象
     */
    public func fold(sink: Sink) 
 }

```

##### 4.2.2 示例

```cangjie
main () {
	let pi: Pipe = Pipe(100)
    let bu: Buffer = Buffer()
    let abcString: String = "abc"
    let abc: Array<UInt8> = abcString.toUtf8Array()
    pi.sink().write(bu.write(abc),3)
    pi.sink().flush()
    let pipeSource: BufferedSource = Okio.buffer(pi.source())
    if("abc" != pipeSource.readUtf8(3)) {
        return 1
    }
     return 0
}
```

### 5 定义异常类

#### 5.1 主要接口
```cangjie
public class ArrayIndexOutOfBoundsException <: Exception {

    /*
     * 得到一个 ArrayIndexOutOfBoundsException 实例
     */
    public init()

    /*
     * 得到一个 ArrayIndexOutOfBoundsException 实例
     * 参数 message - 预定义消息
     */
    public init(string: String) 
}

public class EOFException <: Exception {
    /*
     * 得到一个 EOFException 实例
     */
    public init()

    /*
     * 得到一个 EOFException 实例
     * 参数 message - 预定义消息
     */
    public init(string: String) 
}

public class InterruptedException <: Exception {
    /*
     * 得到一个 InterruptedException 实例
     */
    public init()
    /*
     * 得到一个 InterruptedException 实例
     * 参数 message - 预定义消息
     */
    public init(string: String) 
}

public class IllegalStateException <: Exception {
    /*
     * 得到一个 IllegalStateException 实例
     */
    public init()

    /*
     * 得到一个 IllegalStateException 实例
     * 参数 message - 预定义消息
     */
    public init(string: String) 
}

public class NumberFormatException <: Exception {
    /*
     * 得到一个 NumberFormatException 实例
     * 参数 message - 预定义消息
     */
    public init()

    /*
     * 得到一个 NumberFormatException 实例
     * 参数 message - 预定义消息
     */
    public init(string: String) 
}

public class AssertionException <: Exception {
    /*
     * 得到一个 AssertionException 实例
     * 参数 message - 预定义消息
     */
    public init()

    /*
     * 得到一个 AssertionException 实例
     * 参数 message - 预定义消息
     */
    public init(string: String) 
}
```

