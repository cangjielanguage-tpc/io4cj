# okio api文档
## 模块 okio

核心类api说明

### Okio 类

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
     * 返回写入Socket的Sink。此方法支持超时。当套接字写入超时时，Socket由看门狗线程异步关闭。
     * 参数 Socket - 标准库套接字对象
     * 返回值 Sink - Sink对象
     */
    public static func sink(socket: Socket): Sink 

    /*
     * 返回写入File的Sink。
     * 参数 File - 标准库std的文件对象
     * 返回值 Sink - Sink对象
     */
    public static func sink(file: File): Sink

    /*
     * 返回从Socket读取的Source。此方法支持超时。当套接字读取超时时，套接字由看门狗线程异步关闭。
     * 参数 Socket - 标准库套接字对象
     * 返回值 Source - Source对象
     */
    public static func source(socket: Socket): Source  

    /*
     * 返回写入File的Source。
     * 参数 File - 标准库std的文件对象
     * 返回值 Source - Source对象
     */
    public static func source(file: File): Source
}
```

### Source 接口

此接口在功能上等同于cangjie标准库的std.io.InputStream
```cangjie
public interface Source <: Resource {
    /*
     * 关闭此源并释放此源持有的资源。读取封闭源是一个错误。多次关闭Source是安全的。
     */
    func close(): Unit 

    /*
     * 从Source中删除至少1个字节，并将它们附加到Sink中。返回读取的字节数，如果此Source已用完，则返回-1。
     * 参数 Buffer - okio的Buffer对象, Sink的实现类
     * 参数 Int64 - 计数器
     * 返回值 Int64 - 返回读取的字节数，如果此Source已用完，则返回-1。
     */
    func read(sink: Buffer, byteCount: Int64): Int64

    /*
     * 返回此Source的超时对象。
     * 返回值 Timeout - 超时对象
     */
    func timeout(): Timeout 
}
```

### Sink 接口

此接口在功能上等同于cangjie标准库的std.io.OutputStream
```cangjie
public interface Sink <: Resource {

    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的。
     */
    func close(): Unit   

    /*
     * 将所有缓冲字节推送到SInk的目标中。
     */
    func flush(): Unit  

    /*
     * 返回此接收器的超时对象
     * 返回值 Timeout - 超时对象
     */
    func timeout(): Timeout  

    /*
     * 从Source中删除byteCount字节并将其附加到此Sink中。
     * 参数 Buffer - okio的Buffer对象, source的实现类
     * 参数 Int64 - 计数器
     */
    func write(source: Buffer, byteCount: Int64): Unit
}
```

### BufferedSink 接口

一种在内部保留缓冲区的接收器，以便调用者可以进行较小的写操作，而不会降低性能。
```cangjie
public interface BufferedSink <: Sink {
    
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
    func write(byteString: ByteString): BufferedSink  

    /*
     * 向BufferedSink中写入一个source中包含bytecount个的字节序列
     * 参数 Source - 读取的source
     * 参数 Int64 - 写入的计数器
     * 返回值 BufferedSink - BufferedSink
     */
    func write(source: Source, byteCount: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个完整source的字节序列
     * 参数 Buffer - 读取的source
     * 返回值 Int64 - Int64
     */
    func writeAll(source: Source): Int64

    /*
     * 向BufferedSink中写入UTF-8编码的字符串.
     * 参数 String - 读取的String
     * 返回值 BufferedSink - BufferedSink
     */
    func writeUtf8(string: String): BufferedSink

    /*
     * 向BufferedSink中写入UTF-8编码带有起始和结束范围的字符串.
     * 参数 String - 读取的String
     * 参数 Int64 - 开始索引
     * 参数 Int64 - 结束索引
     * 返回值 BufferedSink - BufferedSink
     */
    func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink

    /*
     * 用UTF-8编码codePoint并将其写入此BufferedSink。
     * 参数 Int64 - UTF-8的数字表示形式
     * 返回值 BufferedSink - BufferedSink
     */
    func writeUtf8CodePoint(codePoInt64: Int64): BufferedSink 

    /*
     * 向BufferedSink中写入一个int8的字节
     * 参数 Int64 - 写入一个不超过int8.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt8(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt16(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt16Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt32(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt32Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt64(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt64Le(value: Int64): BufferedSink

    /*
     * 将BufferedSink所有缓冲数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    func emit(): BufferedSink

    /*
     * 将完整Segment数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    func emitCompleteSegments(): BufferedSink 

}
```

### BufferedSource 接口

一种在内部保留缓冲区的源，以便调用者可以进行较小的读取而不影响性能。它还允许客户端提前读取，在使用输入之前尽可能多地缓冲。
```cangjie
public interface BufferedSource <: Source & ToString {

    /*
     * 获取buffer类
     * 返回值 Buffer - Buffer类
     */
    func getBuffer(): Buffer

    /*
     * 如果此源中没有更多字节，则返回true。这将阻塞，直到有字节要读取或源完全耗尽。
     * 返回值 Bool - bool
     */
    func exhausted(): Bool

    /*
     * 当缓冲区至少包含byteCount字节时返回。如果Source在读取所需字节之前耗尽, 将抛出EOFException.
     * 参数 Int64 - byteCount 计数器
     */
    func require(byteCount: Int64): Unit

    /*
     * 当缓冲区至少包含byteCount字节时，返回true，并根据需要进行扩展。如果源在读取请求的字节之前耗尽，则返回false。
     * 参数 Int64 - byteCount 计数器
     * 返回值 Bool - Bool
     */
    func request(byteCount: Int64): Bool

    /*
     * 从Sink中复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - 读取的数组
     * 返回值 Int64 - 返回读取的长度
     */
    func read(sink: Array<Byte>): Int64

    /*
     * 将Sink中的字节序列读入给定的ByteBuffer。
     * 参数 ByteBuffer - 读取的byteBuffer
     * 返回值 Int64 - 读取的长度
     */
    func read(sink: ByteBuffer): Int64  

    /*
     * 从Sink中带有起始索引和结束索引的子序列复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - sink
     * 参数 Int64 - offset 偏移量
     * 参数 Int64 - byteCount 计数长度
     * 返回值 Int64 - 返回读取的字节数
     */
    func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64

    /*
     * 从这个source中删除一个字节并返回它。
     * 返回值 Int8 - 返回的字节
     */
    func readInt8(): Int8

    /*
     * 从这个源中删除两个字节，并返回一个大端int16
     * 返回值 Int16 - 大端int16
     */
    func readInt16(): Int16

    /*
     * 从这个源中删除两个字节，并返回一个小端int16
     * 返回值 Int16 - 小端int16
     */
    func readInt16Le(): Int16

    /*
     * 从这个源中删除四个字节，并返回一个大端int32
     * 返回值 Int32 - 大端int32
     */
    func readInt32(): Int32

    /*
     * 从这个源中删除四个字节，并返回一个小端int32
     * 返回值 Int32 - 小端int32
     */
    func readInt32Le(): Int32

    /*
     * 从这个源中删除八个字节，并返回一个大端int64
     * 返回值 Int64 - 大端int64
     */
    func readInt64(): Int64

    /*
     * 从这个源中删除八个字节，并返回一个小端int64
     * 返回值 Int64 - 小端int64
     */
    func readInt64Le(): Int64

    /*
     * 从中删除所有字节并将其作为字节字符串返回
     * 返回值 ByteString - ByteString
     */
    func readByteString(): ByteString  

    /*
     * 从中删除byteCount字节并将其作为字节字符串返回。
     * 参数 Int64 - byteCount
     * 返回值 ByteString - ByteString
     */
    func readByteString(byteCount: Int64): ByteString 

    /*
     * 从中删除所有字节并将其作为字节数组返回
     * 返回值 Array<Byte> - 返回的字节数组
     */
    func readByteArray(): Array<Byte>

    /*
     * 从中删除byteCount字节并将其作为字节数组返回。
     * 参数 Int64 - byteCount
     * 返回值 Array<Byte> - 返回的字节数组
     */
    func readByteArray(byteCount: Int64): Array<Byte>

    /*
     * 从中精确删除BufferedSink长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数  Array<Byte> - 写入的字节数组
     */
    func readFully(sink: Array<Byte>): Unit

    /*
     * 从中精确删除byteCount长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数 Buffer - sink 写入的数据源
     * 参数 Int64 - byteCount 写入的长度
     */
    func readFully(sink: Buffer, byteCount: Int64): Unit

    /*
     * 从中删除所有字节并将它们附加到sink。返回写入接收器的总字节数，如果用完，则为0。
     * 参数 Sink - 写入的数据源
     * 返回值 Int64 - 返回字节数
     */
    func readAll(sink: Sink): Int64

    /*
     * 删除其中的所有字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回None
     * 返回值 ?String - Option<String>
     */
    func readUtf8(): ?String

    /*
     * 删除其中的byteCount长度的字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回None
     * 参数 Int64 - byteCount
     * 返回值 ?String - Option<String>
     */
    func readUtf8(byteCount: Int64): ?String

    /*
     * 删除其中的所有字节，将其解码为默认UTF-8，并返回字符串
     * 返回值 ?String - Option<String>
     */
    func readString(): ?String

    /*
     * 删除其中的byteCount长度的字节，将其解码为默认UTF-8，并返回字符串
     * 参数 Int64 - byteCount
     * 返回值 ?String - Option<String>
     */
    readString(byteCount: Int64): ?String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    func readUtf8Line(): ?String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    func readUtf8LineStrict(): ?String

    /*
     * 与readUtf8LineStrict（）类似，但这允许调用者指定允许的最长匹配。使用此选项可防止不包含“\n”或“\r\n”的流。返回的字符串最多只能包含UTF-8字节，扫描的最大字节数为limit+2。如果limit==0，则始终会引发EOFException，因为不会扫描任何字节。
     * 参数 Int64 - limit
     * 返回值 ?String - Option<String>
     */
    func readUtf8LineStrict(limit: Int64): ?String

    /*
     * 删除并返回单个UTF-8代码点，根据需要读取1到4个字节。
     * 返回值 Int64 - 返回字节数
     */
    func readUtf8CodePoint(): Int64 （下个迭代转测）

    /*
     * 相当于indexOf(value，0)。
     * 参数 Int8 - value
     * 返回值 Int64 - 索引位置
     */
    func indexOf(value: Int8): Int64

    /*
     * 返回缓冲区中fromIndex处或之后的第一个value的索引。这会根据需要扩展缓冲区，直到找到value。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOf(value: Int8, fromIndex: Int64): Int64

    /*
     * 如果在fromIndex到toIndex的范围内找到value，则返回value的索引。如果找不到value，或者如果fromIndex==toIndex，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 参数 Int64 - toIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOf(value: Int8, fromIndex: Int64, toIndex: Int64): Int64

    /*
     * 相当于indexOf(bytes，0)。
     * 参数 ByteString - bytes
     * 返回值 Int64 - 索引位置
     */
    func indexOf(bytes: ByteString): Int64 （下个迭代转测）

    /*
     * 返回缓冲区中fromIndex处或之后字节的第一个匹配项的索引。这会根据需要扩展缓冲区，直到找到字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - bytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOf(bytes: ByteString, fromIndex: Int64): Int64  （下个迭代转测）

    /*
     * 相当于indexOfElement(targetBytes, 0)
     * 参数 ByteString - targetBytes
     * 返回值 Int64 - 索引位置
     */
    func indexOfElement(targetBytes: ByteString): Int64  （下个迭代转测）

    /*
     * 返回此缓冲区中位于fromIndex处或之后的第一个索引，该索引包含targetBytes中的任何字节。这会根据需要扩展缓冲区，直到找到目标字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - targetBytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64  （下个迭代转测）

    /*
     * 如果此源中偏移量处的字节等于字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 返回值 Bool - Bool
     */
    func rangeEquals(offset: Int64, bytes: ByteString): Bool  （下个迭代转测）

    /*
     * 如果此源中偏移量处的byteCount字节等于bytesOffset处的字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 参数 Int64 - bytesOffset
     * 参数 Int64 - byteCount
     * 返回值 Bool - Bool
     */
    func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool  （下个迭代转测）

    /*
     * 从此源读取并丢弃byteCount字节。如果源在请求的字节被跳过之前耗尽, 抛出EOFException.
     * 参数 Int64 - byteCount
     */
    func skip(byteCount: Int64): Unit

    /*
     * 返回一个新的BufferedSource，它可以从该BufferedResource读取数据，而不使用它。一旦下次读取或关闭此源，返回的源将变为无效。例如，我们可以使用peek（）向前看并多次读取相同的数据。
     * 返回值 BufferedSource - 新的BufferedSource
     */
    func peek(): BufferedSource  (930版本不支持新的BufferedSource直接打印输出 只能使用read方法读取)
}
```

### Buffer 实现类

内存中字节的集合。
将数据从一个缓冲区移动到另一个缓冲区时很快。这个类不是将字节从内存中的一个位置复制到另一个位置，而是更改底层字节数组的所有权。
此缓冲区随数据增长而增长。就像ArrayList一样，每个缓冲区都很小。它只消耗所需的内存。
```cangjie
public class Buffer <: Object & BufferedSource & BufferedSink & Equatable<Buffer> & ToString & Hashable {

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
     * 返回值 Buffer - Buffer
     */
    public func write(source: Array<Byte>): BufferedSink 

    /*
     * 向该Buffer写入一个从offset开始byteCount长度的字节数组.
     * 参数 source - 字节数组
     * 参数 offset - 偏移量, 开始写入的位置
     * 参数 byteCount - 字节数, 写入的长度
     * 返回值 Buffer - Buffer
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
    func getBuffer(): Buffer

    /*
     * 如果此源中没有更多字节，则返回true。这将阻塞，直到有字节要读取或源完全耗尽。
     * 返回值 Bool - bool
     */
    func exhausted(): Bool

    /*
     * 当缓冲区至少包含byteCount字节时返回。如果Source在读取所需字节之前耗尽, 将抛出EOFException.
     * 参数 Int64 - byteCount 计数器
     */
    func require(byteCount: Int64): Unit

    /*
     * 当缓冲区至少包含byteCount字节时，返回true，并根据需要进行扩展。如果源在读取请求的字节之前耗尽，则返回false。
     * 参数 Int64 - byteCount 计数器
     * 返回值 Bool - Bool
     */
    func request(byteCount: Int64): Bool

    /*
     * 从Sink中复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - 读取的数组
     * 返回值 Int64 - 返回读取的长度
     */
    func read(sink: Array<Byte>): Int64

    /*
     * 将Sink中的字节序列读入给定的ByteBuffer。
     * 参数 ByteBuffer - 读取的byteBuffer
     * 返回值 Int64 - 读取的长度
     */
    func read(sink: ByteBuffer): Int64  

    /*
     * 从Sink中带有起始索引和结束索引的子序列复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - sink
     * 参数 Int64 - offset 偏移量
     * 参数 Int64 - byteCount 计数长度
     * 返回值 Int64 - 返回读取的字节数
     */
    func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64

    /*
     * 从这个source中删除一个字节并返回它。
     * 返回值 Int8 - 返回的字节
     */
    func readInt8(): Int8

    /*
     * 从这个源中删除两个字节，并返回一个大端int16
     * 返回值 Int16 - 大端int16
     */
    func readInt16(): Int16

    /*
     * 从这个源中删除两个字节，并返回一个小端int16
     * 返回值 Int16 - 小端int16
     */
    func readInt16Le(): Int16

    /*
     * 从这个源中删除四个字节，并返回一个大端int32
     * 返回值 Int32 - 大端int32
     */
    func readInt32(): Int32

    /*
     * 从这个源中删除四个字节，并返回一个小端int32
     * 返回值 Int32 - 小端int32
     */
    func readInt32Le(): Int32

    /*
     * 从这个源中删除八个字节，并返回一个大端int64
     * 返回值 Int64 - 大端int64
     */
    func readInt64(): Int64

    /*
     * 从这个源中删除八个字节，并返回一个小端int64
     * 返回值 Int64 - 小端int64
     */
    func readInt64Le(): Int64

    /*
     * 从中删除所有字节并将其作为字节字符串返回
     * 返回值 ByteString - ByteString
     */
    func readByteString(): ByteString  

    /*
     * 从中删除byteCount字节并将其作为字节字符串返回。
     * 参数 Int64 - byteCount
     * 返回值 ByteString - ByteString
     */
    func readByteString(byteCount: Int64): ByteString 

    /*
     * 从中删除所有字节并将其作为字节数组返回
     * 返回值 Array<Byte> - 返回的字节数组
     */
    func readByteArray(): Array<Byte>

    /*
     * 从中删除byteCount字节并将其作为字节数组返回。
     * 参数 Int64 - byteCount
     * 返回值 Array<Byte> - 返回的字节数组
     */
    func readByteArray(byteCount: Int64): Array<Byte>

    /*
     * 从中精确删除BufferedSink长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数  Array<Byte> - 写入的字节数组
     */
    func readFully(sink: Array<Byte>): Unit

    /*
     * 从中精确删除byteCount长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数 Buffer - sink 写入的数据源
     * 参数 Int64 - byteCount 写入的长度
     */
    func readFully(sink: Buffer, byteCount: Int64): Unit

    /*
     * 从中删除所有字节并将它们附加到sink。返回写入接收器的总字节数，如果用完，则为0。
     * 参数 Sink - 写入的数据源
     * 返回值 Int64 - 返回字节数
     */
    func readAll(sink: Sink): Int64

    /*
     * 删除其中的所有字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回None
     * 返回值 ?String - Option<String>
     */
    func readUtf8(): ?String

    /*
     * 删除其中的byteCount长度的字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回None
     * 参数 Int64 - byteCount
     * 返回值 ?String - Option<String>
     */
    func readUtf8(byteCount: Int64): ?String

    /*
     * 删除其中的所有字节，将其解码为默认UTF-8，并返回字符串
     * 返回值 ?String - Option<String>
     */
    func readString(): ?String

    /*
     * 删除其中的byteCount长度的字节，将其解码为默认UTF-8，并返回字符串
     * 参数 Int64 - byteCount
     * 返回值 ?String - Option<String>
     */
    readString(byteCount: Int64): ?String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    func readUtf8Line(): ?String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    func readUtf8LineStrict(): ?String

    /*
     * 与readUtf8LineStrict（）类似，但这允许调用者指定允许的最长匹配。使用此选项可防止不包含“\n”或“\r\n”的流。返回的字符串最多只能包含UTF-8字节，扫描的最大字节数为limit+2。如果limit==0，则始终会引发EOFException，因为不会扫描任何字节。
     * 参数 Int64 - limit
     * 返回值 ?String - Option<String>
     */
    func readUtf8LineStrict(limit: Int64): ?String

    /*
     * 删除并返回单个UTF-8代码点，根据需要读取1到4个字节。
     * 返回值 Int64 - 返回字节数
     */
    func readUtf8CodePoint(): Int64 （下个迭代转测）

    /*
     * 相当于indexOf(value，0)。
     * 参数 Int8 - value
     * 返回值 Int64 - 索引位置
     */
    func indexOf(value: Int8): Int64

    /*
     * 返回缓冲区中fromIndex处或之后的第一个value的索引。这会根据需要扩展缓冲区，直到找到value。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOf(value: Int8, fromIndex: Int64): Int64

    /*
     * 如果在fromIndex到toIndex的范围内找到value，则返回value的索引。如果找不到value，或者如果fromIndex==toIndex，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 参数 Int64 - toIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOf(value: Int8, fromIndex: Int64, toIndex: Int64): Int64

    /*
     * 相当于indexOf(bytes，0)。
     * 参数 ByteString - bytes
     * 返回值 Int64 - 索引位置
     */
    func indexOf(bytes: ByteString): Int64 （下个迭代转测）

    /*
     * 返回缓冲区中fromIndex处或之后字节的第一个匹配项的索引。这会根据需要扩展缓冲区，直到找到字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - bytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOf(bytes: ByteString, fromIndex: Int64): Int64  （下个迭代转测）

    /*
     * 相当于indexOfElement(targetBytes, 0)
     * 参数 ByteString - targetBytes
     * 返回值 Int64 - 索引位置
     */
    func indexOfElement(targetBytes: ByteString): Int64  （下个迭代转测）

    /*
     * 返回此缓冲区中位于fromIndex处或之后的第一个索引，该索引包含targetBytes中的任何字节。这会根据需要扩展缓冲区，直到找到目标字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - targetBytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64  （下个迭代转测）

    /*
     * 如果此源中偏移量处的字节等于字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 返回值 Bool - Bool
     */
    func rangeEquals(offset: Int64, bytes: ByteString): Bool  （下个迭代转测）

    /*
     * 如果此源中偏移量处的byteCount字节等于bytesOffset处的字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 参数 Int64 - bytesOffset
     * 参数 Int64 - byteCount
     * 返回值 Bool - Bool
     */
    func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool  （下个迭代转测）

    /*
     * 从此源读取并丢弃byteCount字节。如果源在请求的字节被跳过之前耗尽, 抛出EOFException.
     * 参数 Int64 - byteCount
     */
    func skip(byteCount: Int64): Unit

    /*
     * 返回一个新的BufferedSource，它可以从该BufferedResource读取数据，而不使用它。一旦下次读取或关闭此源，返回的源将变为无效。例如，我们可以使用peek（）向前看并多次读取相同的数据。
     * 返回值 BufferedSource - 新的BufferedSource
     */
    func peek(): BufferedSource  (930版本不支持新的BufferedSource直接打印输出 只能使用read方法读取)
    
        
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
    func write(byteString: ByteString): BufferedSink  

    /*
     * 向BufferedSink中写入一个source中包含bytecount个的字节序列
     * 参数 Source - 读取的source
     * 参数 Int64 - 写入的计数器
     * 返回值 BufferedSink - BufferedSink
     */
    func write(source: Source, byteCount: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个完整source的字节序列
     * 参数 Buffer - 读取的source
     * 返回值 Int64 - Int64
     */
    func writeAll(source: Source): Int64

    /*
     * 向BufferedSink中写入UTF-8编码的字符串.
     * 参数 String - 读取的String
     * 返回值 BufferedSink - BufferedSink
     */
    func writeUtf8(string: String): BufferedSink

    /*
     * 向BufferedSink中写入UTF-8编码带有起始和结束范围的字符串.
     * 参数 String - 读取的String
     * 参数 Int64 - 开始索引
     * 参数 Int64 - 结束索引
     * 返回值 BufferedSink - BufferedSink
     */
    func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink

    /*
     * 用UTF-8编码codePoint并将其写入此BufferedSink。
     * 参数 Int64 - UTF-8的数字表示形式
     * 返回值 BufferedSink - BufferedSink
     */
    func writeUtf8CodePoint(codePoInt64: Int64): BufferedSink 

    /*
     * 向BufferedSink中写入一个int8的字节
     * 参数 Int64 - 写入一个不超过int8.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt8(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt16(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt16Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt32(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt32Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt64(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt64Le(value: Int64): BufferedSink

    /*
     * 将BufferedSink所有缓冲数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    func emit(): BufferedSink

    /*
     * 将完整Segment数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    func emitCompleteSegments(): BufferedSink 
}
```

### ByteString 类

不可变的字节序列。
```cangjie
public open class ByteString <: Object & Hashable & ToString & Equatable<ByteString> {
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

### RealBufferedSink 内部类 (此类属于 okio 私有内部类, 不可直接使用, 该类实现于 BufferedSink 接口. )
#### 使用方法
```cangjie 
    let realBufferedSink: BufferedSink = Okio.buffer(sink)
```
#### 接口说明
```cangjie
class RealBufferedSink <: BufferedSink {
    
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
    func write(byteString: ByteString): BufferedSink  

    /*
     * 向BufferedSink中写入一个source中包含bytecount个的字节序列
     * 参数 Source - 读取的source
     * 参数 Int64 - 写入的计数器
     * 返回值 BufferedSink - BufferedSink
     */
    func write(source: Source, byteCount: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个完整source的字节序列
     * 参数 Buffer - 读取的source
     * 返回值 Int64 - Int64
     */
    func writeAll(source: Source): Int64

    /*
     * 向BufferedSink中写入UTF-8编码的字符串.
     * 参数 String - 读取的String
     * 返回值 BufferedSink - BufferedSink
     */
    func writeUtf8(string: String): BufferedSink

    /*
     * 向BufferedSink中写入UTF-8编码带有起始和结束范围的字符串.
     * 参数 String - 读取的String
     * 参数 Int64 - 开始索引
     * 参数 Int64 - 结束索引
     * 返回值 BufferedSink - BufferedSink
     */
    func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink

    /*
     * 用UTF-8编码codePoint并将其写入此BufferedSink。
     * 参数 Int64 - UTF-8的数字表示形式
     * 返回值 BufferedSink - BufferedSink
     */
    func writeUtf8CodePoint(codePoInt64: Int64): BufferedSink 

    /*
     * 向BufferedSink中写入一个int8的字节
     * 参数 Int64 - 写入一个不超过int8.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt8(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt16(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int16的字节
     * 参数 Int64 - 写入一个不超过int16.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt16Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt32(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int32的字节
     * 参数 Int64 - 写入一个不超过int32.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt32Le(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个大端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt64(value: Int64): BufferedSink

    /*
     * 向BufferedSink中写入一个小端int64的字节
     * 参数 Int64 - 写入一个不超过int64.max的数字
     * 返回值 BufferedSink - BufferedSink
     */
    func writeInt64Le(value: Int64): BufferedSink

    /*
     * 将BufferedSink所有缓冲数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    func emit(): BufferedSink

    /*
     * 将完整Segment数据写入Sink中（如果存在）
     * 返回值 BufferedSink - BufferedSink
     */
    func emitCompleteSegments(): BufferedSink 
}
```

### RealBufferedSource 内部类 (此类属于 okio 私有内部类, 不可直接使用, 该类实现于 BufferedSource 接口. )
#### 使用方法 
```cangjie
let realBufferedSource: RealBufferedSource = Okio.buffer(source)
```
#### 接口说明
```cangjie
class RealBufferedSource <: BufferedSource {
    /*
     * 获取buffer类
     * 返回值 Buffer - Buffer类
     */
    func getBuffer(): Buffer

    /*
     * 如果此源中没有更多字节，则返回true。这将阻塞，直到有字节要读取或源完全耗尽。
     * 返回值 Bool - bool
     */
    func exhausted(): Bool

    /*
     * 当缓冲区至少包含byteCount字节时返回。如果Source在读取所需字节之前耗尽, 将抛出EOFException.
     * 参数 Int64 - byteCount 计数器
     */
    func require(byteCount: Int64): Unit

    /*
     * 当缓冲区至少包含byteCount字节时，返回true，并根据需要进行扩展。如果源在读取请求的字节之前耗尽，则返回false。
     * 参数 Int64 - byteCount 计数器
     * 返回值 Bool - Bool
     */
    func request(byteCount: Int64): Bool

    /*
     * 从Sink中复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - 读取的数组
     * 返回值 Int64 - 返回读取的长度
     */
    func read(sink: Array<Byte>): Int64

    /*
     * 将Sink中的字节序列读入给定的ByteBuffer。
     * 参数 ByteBuffer - 读取的byteBuffer
     * 返回值 Int64 - 读取的长度
     */
    func read(sink: ByteBuffer): Int64  

    /*
     * 从Sink中带有起始索引和结束索引的子序列复制到数组中。返回读取的字节数，如果此源已用完，则返回-1。
     * 参数 Array<Byte> - sink
     * 参数 Int64 - offset 偏移量
     * 参数 Int64 - byteCount 计数长度
     * 返回值 Int64 - 返回读取的字节数
     */
    func read(sink: Array<Byte>, offset: Int64, byteCount: Int64): Int64

    /*
     * 从这个source中删除一个字节并返回它。
     * 返回值 Int8 - 返回的字节
     */
    func readInt8(): Int8

    /*
     * 从这个源中删除两个字节，并返回一个大端int16
     * 返回值 Int16 - 大端int16
     */
    func readInt16(): Int16

    /*
     * 从这个源中删除两个字节，并返回一个小端int16
     * 返回值 Int16 - 小端int16
     */
    func readInt16Le(): Int16

    /*
     * 从这个源中删除四个字节，并返回一个大端int32
     * 返回值 Int32 - 大端int32
     */
    func readInt32(): Int32

    /*
     * 从这个源中删除四个字节，并返回一个小端int32
     * 返回值 Int32 - 小端int32
     */
    func readInt32Le(): Int32

    /*
     * 从这个源中删除八个字节，并返回一个大端int64
     * 返回值 Int64 - 大端int64
     */
    func readInt64(): Int64

    /*
     * 从这个源中删除八个字节，并返回一个小端int64
     * 返回值 Int64 - 小端int64
     */
    func readInt64Le(): Int64

    /*
     * 从中删除所有字节并将其作为字节字符串返回
     * 返回值 ByteString - ByteString
     */
    func readByteString(): ByteString  

    /*
     * 从中删除byteCount字节并将其作为字节字符串返回。
     * 参数 Int64 - byteCount
     * 返回值 ByteString - ByteString
     */
    func readByteString(byteCount: Int64): ByteString 

    /*
     * 从中删除所有字节并将其作为字节数组返回
     * 返回值 Array<Byte> - 返回的字节数组
     */
    func readByteArray(): Array<Byte>

    /*
     * 从中删除byteCount字节并将其作为字节数组返回。
     * 参数 Int64 - byteCount
     * 返回值 Array<Byte> - 返回的字节数组
     */
    func readByteArray(byteCount: Int64): Array<Byte>

    /*
     * 从中精确删除BufferedSink长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数  Array<Byte> - 写入的字节数组
     */
    func readFully(sink: Array<Byte>): Unit

    /*
     * 从中精确删除byteCount长度的字节，并将其复制到数组中。如果无法读取请求的字节数，抛出EOFException。
     * 参数 Buffer - sink 写入的数据源
     * 参数 Int64 - byteCount 写入的长度
     */
    func readFully(sink: Buffer, byteCount: Int64): Unit

    /*
     * 从中删除所有字节并将它们附加到sink。返回写入接收器的总字节数，如果用完，则为0。
     * 参数 Sink - 写入的数据源
     * 返回值 Int64 - 返回字节数
     */
    func readAll(sink: Sink): Int64

    /*
     * 删除其中的所有字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回None
     * 返回值 ?String - Option<String>
     */
    func readUtf8(): ?String

    /*
     * 删除其中的byteCount长度的字节，将其解码为UTF-8，并返回字符串。如果此源为空，则返回None
     * 参数 Int64 - byteCount
     * 返回值 ?String - Option<String>
     */
    func readUtf8(byteCount: Int64): ?String

    /*
     * 删除其中的所有字节，将其解码为默认UTF-8，并返回字符串
     * 返回值 ?String - Option<String>
     */
    func readString(): ?String

    /*
     * 删除其中的byteCount长度的字节，将其解码为默认UTF-8，并返回字符串
     * 参数 Int64 - byteCount
     * 返回值 ?String - Option<String>
     */
    readString(byteCount: Int64): ?String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    func readUtf8Line(): ?String

    /*
     * 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
     * 返回值 ?String - Option<String>
     */
    func readUtf8LineStrict(): ?String

    /*
     * 与readUtf8LineStrict（）类似，但这允许调用者指定允许的最长匹配。使用此选项可防止不包含“\n”或“\r\n”的流。返回的字符串最多只能包含UTF-8字节，扫描的最大字节数为limit+2。如果limit==0，则始终会引发EOFException，因为不会扫描任何字节。
     * 参数 Int64 - limit
     * 返回值 ?String - Option<String>
     */
    func readUtf8LineStrict(limit: Int64): ?String

    /*
     * 删除并返回单个UTF-8代码点，根据需要读取1到4个字节。
     * 返回值 Int64 - 返回字节数
     */
    func readUtf8CodePoint(): Int64 （下个迭代转测）

    /*
     * 相当于indexOf(value，0)。
     * 参数 Int8 - value
     * 返回值 Int64 - 索引位置
     */
    func indexOf(value: Int8): Int64

    /*
     * 返回缓冲区中fromIndex处或之后的第一个value的索引。这会根据需要扩展缓冲区，直到找到value。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOf(value: Int8, fromIndex: Int64): Int64

    /*
     * 如果在fromIndex到toIndex的范围内找到value，则返回value的索引。如果找不到value，或者如果fromIndex==toIndex，则返回-1。
     * 参数 Int8 - value
     * 参数 Int64 - fromIndex
     * 参数 Int64 - toIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOf(value: Int8, fromIndex: Int64, toIndex: Int64): Int64

    /*
     * 相当于indexOf(bytes，0)。
     * 参数 ByteString - bytes
     * 返回值 Int64 - 索引位置
     */
    func indexOf(bytes: ByteString): Int64 （下个迭代转测）

    /*
     * 返回缓冲区中fromIndex处或之后字节的第一个匹配项的索引。这会根据需要扩展缓冲区，直到找到字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - bytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOf(bytes: ByteString, fromIndex: Int64): Int64  （下个迭代转测）

    /*
     * 相当于indexOfElement(targetBytes, 0)
     * 参数 ByteString - targetBytes
     * 返回值 Int64 - 索引位置
     */
    func indexOfElement(targetBytes: ByteString): Int64  （下个迭代转测）

    /*
     * 返回此缓冲区中位于fromIndex处或之后的第一个索引，该索引包含targetBytes中的任何字节。这会根据需要扩展缓冲区，直到找到目标字节。这会将无限数量的字节读入缓冲区。如果流在找到请求的字节之前耗尽，则返回-1。
     * 参数 ByteString - targetBytes
     * 参数 Int64 - fromIndex
     * 返回值 Int64 - 索引位置
     */
    func indexOfElement(targetBytes: ByteString, fromIndex: Int64): Int64  （下个迭代转测）

    /*
     * 如果此源中偏移量处的字节等于字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 返回值 Bool - Bool
     */
    func rangeEquals(offset: Int64, bytes: ByteString): Bool  （下个迭代转测）

    /*
     * 如果此源中偏移量处的byteCount字节等于bytesOffset处的字节，则返回true。这会根据需要扩展缓冲区，直到一个字节不匹配，所有字节都匹配，或者如果流在足够的字节确定匹配之前耗尽。
     * 参数 Int64 - offset
     * 参数 ByteString - bytes
     * 参数 Int64 - bytesOffset
     * 参数 Int64 - byteCount
     * 返回值 Bool - Bool
     */
    func rangeEquals(offset: Int64, bytes: ByteString, bytesOffset: Int64, byteCount: Int64): Bool  （下个迭代转测）

    /*
     * 从此源读取并丢弃byteCount字节。如果源在请求的字节被跳过之前耗尽, 抛出EOFException.
     * 参数 Int64 - byteCount
     */
    func skip(byteCount: Int64): Unit

    /*
     * 返回一个新的BufferedSource，它可以从该BufferedResource读取数据，而不使用它。一旦下次读取或关闭此源，返回的源将变为无效。例如，我们可以使用peek（）向前看并多次读取相同的数据。
     * 返回值 BufferedSource - 新的BufferedSource
     */
    func peek(): BufferedSource  (930版本不支持新的BufferedSource直接打印输出 只能使用read方法读取)
}
```



### ForwardingTimeout 类

继承了Timeout类

```cangjie
 public class ForwardingTimeout <: Timeout {

    /*
     * 构造一个ForwardingTimeout。
     */
    public init(assignment: Timeout)
 	/*
     * 获取Timeout对象。
     */
    public func delegate(): Timeout
    
    /*
     * 给Timeout对象赋值。
     * 参数Timeout 超时对象对象。
     */
    public func  setDelegate(assignment: Timeout):ForwardingTimeout
    
    /*
     * 获取Timeout对象，重写父类Timeout的timeout(timeout: Int64)方法。
     * 参数 Int64 - 计数器
     */
    public override func timeout(timeout: Int64):Timeout
    
    /*
     * 返回超时时间纳秒值，重写父类Timeout的timeoutNanos()方法。
     */
    public override func timeoutNanos(): Int64
    
    /*
     * 返回是否有截止日期，重写父类Timeout的hasDeadline()方法。
     * 返回值 Bool - 如果是 true，否则返回 false
     */
    public override func hasDeadline():Bool
    
    /*
     * 返回截止日期纳秒值，重写父类Timeout的deadlineNanoTime()方法。
     */
    public override func deadlineNanoTime():Int64

    /*
     * 截止日期纳秒值，重写父类Timeout的deadlineNanoTime（deadlineNanoTime: Int64）方法。
     * 参数 Int64 - 截至日期纳秒
     * 返回值 Timeout。
     */
    public override func deadlineNanoTime(deadlineNanoTime: Int64):Timeout

    /*
     * 清理Timeout变量timeoutnanost，使timeoutnanost值变为零，重写父类clearTimeout()方法。
     */
    public override func clearTimeout(): Timeout
    
    /*
     * 清理Timeout变量hasdeadline，使hasdeadline值变为false，重写父类clearDeadline()方法。
     */
    public override func clearDeadline(): Timeout
    
    /*
     * 抛出预期，如果hasdeadline为true且deadlinenanotime小于等于当前时间则抛出异常，重写父类throwIfReached()方法。
     */
    public override func throwIfReached()
}
```

### GzipSink 类

实现了Sink接口

```cangjie
public class GzipSink <: Sink {

    /*
     * 构造一个GzipSink。
     * 参数：sink： Sink接口
     */
    public init(sink: Sink)
    /*
     * GzipSink的压缩功能，参数byteCount需要大于零。
     * 参数：source：Buffe让对象
     */
    public func write(source: Buffer,byteCount: Int64): Unit

    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的。
     */
    public override func close(): Unit
    /*
     * 清理sink里面内容，重写父类sink的flush()方法。
     * 参数：source：Buffe让对象
     */
    public override func flush(): Unit
    /*
     * 获取Timeout对象，重写父类sink的timeout()方法。
     * 参数：source：Buffe让对象
     */
    public override func timeout(): Timeout
    /*
     *判断资源是否关闭
    * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
     */
    public override func isClosed(): Bool
    
    /*
     * 获取String类型，重写toString()方法。
     */
    public override func toString():String
    
}
```

### DeflaterSink

实现了Sink接口，封装了具体的压缩方法

```cangjie
public class DeflaterSink <: Sink {

    /*
     * 构造一个DeflaterSink。
     */
    public init(sink: Sink , deflater: Deflater)

    /*
    * 判断资源是否关闭
    * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
    */
    public func isClosed(): Bool
    
    /*
     * 判断是否需要输入数据
     */
    public func end():Unit

}
```

### GzipSource 类

实现了Source接口，

```cangjie

public class GzipSource <: Source {

    /*
     * 构造一个GzipSource。
     */
    public init(source:Source)
    /*
     * GzipSource的解压功能，参数byteCount需要大于零。
     */
    public func read(sink: Buffer,byteCount: Int64): Int64
    
    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的。
     */
    public override func close(): Unit
    /*
     * 获取Timeout对象，重写父类Source的timeout()方法。
     * 参数：source：Buffe让对象
     */
    public override func timeout(): Timeout
    /*
     *判断资源是否关闭
    * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
     */
    public override func isClosed(): Bool
    /*
     * 获取String类型，重写toString()方法。
     */
    public override func toString():String

}
```

### InflaterSource

实现了Source接口，封装了具体的解压缩方法

```cangjie
public class InflaterSource <: Source {

    /*
     * 构造一个InflaterSource。
     * 参数Source 数据源
     * 参数Inflater 
     */
    public init(source: Source)
    /*
    * 判断资源是否关闭
    * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
    */
    public func isClosed(): Bool

    /*
     * 将buffer中的数据压缩到Segment对象中，并保存到BufferedSink对象中
     *返回解压缩后的字节数
     */
    public func read(sink: Buffer , byteCount: Int64): Int64
    
    /*
     * 从此源读取并丢弃byteCount字节
     */
    private func releaseInflatedBytes():Unit
    
    /*
     * 获取Timeout对象，重写父类Source的timeout()方法。
     * 参数：source：Buffe让对象
     */
    public override func timeout(): Timeout
    
    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的。
     */
    public override func close(): Unit
    
    /*
     * 获取String类型，重写toString()方法。
     */
    public override func toString():String

}
```

### ForwardingSink 类

实现Sink接口，多出获取Sink对象的方法

```cangjie
public open class ForwardingSink <: Sink {
	
	/*
     * 获取Sink对象。
     */
    public func delegate(): Sink

	/*
     * 从Source中删除byteCount字节并将其附加到此Sink中。
     * 参数 Buffer - okio的Buffer对象, source的实现类
     * 参数 Int64 - 计数器
     */
    public override open func write(source: Buffer,byteCount: Int64): Unit
    
    /*
     * 将所有缓冲字节推送到SInk的目标中。
     */
    public override func flush(): Unit
    
    /*
     * 返回此接收器的超时对象
     * 返回值 Timeout - 超时对象
     */
    public override func timeout(): Timeout
   
    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的。
     */
    public override func close(): Unit
    
    /*
     * 重写的toString方法
     * 返回值 重写的toString格式数据
     */
    func timeout(): Timeout  
    
    /*
    * 判断资源是否关闭
    * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
    */
    public open func isClosed(): Bool
}
```

### ForwardingSource 类

实现Source接口，多出获取Sink对象的方法

```cangjie
public open class ForwardingSource <: Source{

	/*
     * 获取Source对象。
     */
    public func delegate(): Source
    
    /*
     * 从Source中删除至少1个字节，并将它们附加到Sink中。返回读取的字节数，如果此Source已用完，则返回-1。
     * 参数 Buffer - okio的Buffer对象, Sink的实现类
     * 参数 Int64 - 计数器
     * 返回值 Int64 - 返回读取的字节数，如果此Source已用完，则返回-1。
     */
    public override open func read(sink: Buffer,byteCount:Int64): Int64
    
    /*
     * 返回此Source的超时对象。
     * 返回值 Timeout - 超时对象
     */
    public override func timeout(): Timeout
    
    /*
     * 关闭此源并释放此源持有的资源。读取封闭源是一个错误。多次关闭Source是安全的。
     */
    func close(): Unit 
	
	/*
     * 重写的toString方法
     * 返回值 重写的toString格式数据
     */
    func timeout(): Timeout  
    
    /*
    * 判断资源是否关闭
    * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
    */
    public open func isClosed(): Bool
    
}
```

### HashingSink

继承了ForwardingSink抽象类，调用具体算法，返回响应的哈希值

```cangjie
public class HashingSink <: ForwardingSink {

    /*
     * 返回一个使用过时的MD5哈希算法生成128位哈希的接收器。
     * 参数sink 接收器
     */
    public static func md5(sink: Sink): HashingSink
    /*
     * 返回一个使用过时的sha1哈希算法生成160位哈希的接收器。
     * 参数sink 接收器
     */
    public static func sha1(sink: Sink): HashingSink

    /*
     * 返回一个使用过时的sha256哈希算法生成256位哈希的接收器。
     * 参数sink 接收器
     */
    public static func sha256(sink: Sink): HashingSink
    
     /*
     * 返回一个使用过时的sha512哈希算法生成512位哈希的接收器。
     * 参数sink 接收器
     */
    public static func sha512(sink: Sink): HashingSink
    
    /*
     * 返回一个使用SHA-1 HMAC算法生成160位哈希的接收器。
     * 参数sink 接收器，key：字符串形式的秘钥
     */
    public static func hmacSha1(sink: Sink , key: String): HashingSink 
    
    /*
     * 返回一个使用SHA-256 HMAC算法生成256位哈希的接收器。
     * 参数sink 接收器，key：字符串形式的秘钥
     */
    public static func hmacSha256(sink: Sink , key: String): HashingSink 
    
    /*
     * 返回一个使用SHA-512 HMAC算法生成512位哈希的接收器。
     * 参数sink 接收器，key：字符串形式的秘钥 
     */
    public static func hmacSha512(sink: Sink , key: String): HashingSink 
    
    /*
     * 将数据写入接收器中
     * 参数source 有内容的Buffer对象，byteCount：Int64
     */
    public override func write(source: Buffer , byteCount: Int64)
    
    /*
     * 调用MD5加密算法对数据加密，加密后的数据封装在字符串中；
     * 调用write方法将数据写入接收器中
     * 参数source 有内容的Buffer对象，byteCount：Int64
     */
    public func writeMD5(source: Buffer , byteCount: Int64)
    
    /*
     * 调用SHA1加密算法对数据加密，加密后的数据封装在字符串中；
     * 调用write方法将数据写入接收器中
     * 参数source 有内容的Buffer对象，byteCount：Int64
     */
    public func writeSHA1(source: Buffer , byteCount: Int64)
    
    /*
     * 调用SHA256加密算法对数据加密，加密后的数据封装在字符串中；
     * 调用write方法将数据写入接收器中
     * 参数source 有内容的Buffer对象，byteCount：Int64
     */
    public func writeSHA256(source: Buffer , byteCount: Int64)
    
    /*
     * 调用SHA512加密算法对数据加密，加密后的数据封装在字符串中；
     * 调用write方法将数据写入接收器中
     * 参数source 有内容的Buffer对象，byteCount：Int64
     */
    public func writeSHA512(source: Buffer , byteCount: Int64)
    
    /*
     * 调用hmacSha1加密算法对数据加密，加密后的数据封装在字符串中；
     * 调用write方法将数据写入接收器中
     * 参数source 有内容的Buffer对象，byteCount：Int64
     */
    public func writehmacSha1(source: Buffer , byteCount: Int64)
    
    /*
     * 调用hmacSha256加密算法对数据加密，加密后的数据封装在字符串中；
     * 调用write方法将数据写入接收器中
     * 参数source 有内容的Buffer对象，byteCount：Int64
     */
    public func writehmacSha256(source: Buffer , byteCount: Int64)
    
     /*
     * 调用hmacSha512加密算法对数据加密，加密后的数据封装在字符串中；
     * 调用write方法将数据写入接收器中
     * 参数source 有内容的Buffer对象，byteCount：Int64
     */
    public func writehmacSha512(source: Buffer , byteCount: Int64)
    
    /*
     * 返回加密后的结果
     * 
     * 返回值：加密后的String数据
     */
    public func hash(): String
    
    /*
     *判断资源是否关闭
    * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
     *//*
     * 返回加密后的结果
     * 
     * 返回值：加密后的String数据
     */
    public override func isClosed(): Bool 

}
示例：main () {
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
输出结果：
	0

```

### HashingSource

继承了ForwardingSource抽象类，调用具体算法，返回响应的哈希值

```cangjie
public class HashingSource <: ForwardingSource {

    /*
     * 返回一个使用过时的MD5哈希算法生成128位哈希的接收器。
     * 参数source 数据源
     */
    public static func md5(source:Source):HashingSource
    /*
     * 返回一个使用过时的sha1哈希算法生成160位哈希的接收器。
     * 参数source 数据源
     */
    public static func sha1(source: Source): HashingSource

    /*
     * 返回一个使用过时的sha256哈希算法生成256位哈希的接收器。
     * 参数source 数据源
     */
    public static func sha256(source: Source): HashingSource
    
    /*
     * 返回一个使用SHA-1 HMAC算法生成160位哈希的接收器。
     * 参数source 数据源，key：字符串形式的秘钥
     */
    public static func hmacSha1(source: Source,key: String):HashingSource 
    
    /*
     * 返回一个使用SHA-256 HMAC算法生成256位哈希的接收器。
     * 参数source 数据源，key：字符串形式的秘钥
     */
    public static func hmacSha256(source:Source,key:String):HashingSource
    
    /*
     * 将数据读取到Buffer中
     * 参数sink 空的的Buffer对象，byteCount：Int64
     * 返回值： 返回读取的字节数
     */
    public override func read(sink: Buffer,byteCount: Int64):Int64
    
    /*
     * 调用MD5加密算法对read方法读取的数据加密，加密后的数据封装在字符串中；
     * 返回值：Unit
     */
    public func readMD5(): Unit 
    
    /*
     * 调用SHA1加密算法对read方法读取的数据加密，加密后的数据封装在字符串中；
     * 返回值：Unit
     */
    public func readSHA1(): Unit 
    
    /*
     * 调用SHA256加密算法对read方法读取的数据加密，加密后的数据封装在字符串中；
     * 返回值：Unit
     */
    public func readSHA256(): Unit 
    
    /*
     * 调用readhmacSha1加密算法对read方法读取的数据加密，加密后的数据封装在字符串中；
     * 返回值：Unit
     */
    public func readhmacSha1(): Unit
    
    /*
     * 调用readhmacSha256加密算法对read方法读取的数据加密，加密后的数据封装在字符串中；
     * 返回值：Unit
     */
    public func readhmacSha256(): Unit
    
    /*
     * 返回加密后的结果
     * 
     * 返回值：加密后的String数据
     */
    public func hash(): String
    
    /*
     *判断资源是否关闭
    * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
     */
    public override func isClosed(): Bool 

}
示例：main () {
	var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let hashingSource: HashingSource = HashingSource.md5(source)
    source.writeUtf8("helloworld")
    let result: Int64 = hashingSource.read(sink, 0x7fffffffffffffff)
    hashingSource.readMD5()
    let a: String = hashingSource.hash()
    if(result != 10){
        return 2
    }
    if(a != "fc5e038d38a57032085441e7fe7010b0") {
        return 1
    }
     return 0
}
输出结果：
	0
```

### Pipe 类

okio管道类，使用一个缓冲区来解耦源和接收器。该缓冲区具有用户指定的大小。当生产线程的运行速度超过消费线程时，缓冲区会被填满，并最终写入接收器，直到消费线程赶上。对称地，如果消费者超出了它的生产者读块，直到有数据可读。

```cangjie
public class Pipe {

    /*
     * 构造一个Pipe
     * 参数：用户制定的缓冲区大小
     */
     public init(bufferSize: Int64)
 	/*
     * 获取source对象。
     */
    public func source(): Source 
    
    /*
     * 获取sink对象。
     */
    public func sink(): Sink
    
    /*
     * 将此管道的任何缓冲内容写入 sink，然后用 sink替换此管道的源。
     * 参数 sink 接收器
     */
    public func fold(sink: Sink) 
 }
 
class PipeSink <: Sink {
    /*
     * 将Buffer中的数据写入sink
     * 参数：source,Buffer中的数据，byteCount: Int64
     * 返回值：Unit
     */
    public override func write(source: Buffer , byteCount: Int64): Unit
    
    /*
     * 将所有缓冲字节推送到SInk的目标中。
     * 
     */
    public override func flush()
    
    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的。
     */
     public override func close() 

    /*
     * 返回Timeout对象
     */
   public override func timeout(): Timeout
    /*
     *判断资源是否关闭
     * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
     */
   public override func isClosed(): Bool
   
   /*
     * 返回toString方法
     */
   public override func toString():String
}

class PipeSource <: Source {

	/*
     * 将sink中的数据写入Buffer中
     * 参数：source,空的Buffer对象，byteCount: Int64
     * 返回值：读取的字节数
     */
	public override func read(sink: Buffer , byteCount: Int64): Int64 
	
	/*
     * 关闭此源并释放此源持有的资源。读取封闭源是一个错误。多次关闭Source是安全的。
     */
	public override func close()
	
	/*
     * 返回Timeout对象
     */
	public override func timeout(): Timeout
	
	/*
     *判断资源是否关闭
     * 返回值 Bool - 如果已经关闭返回 true，否则返回 false
     */
   public override func isClosed(): Bool
   
   /*
     * 返回toString方法
     */
   public override func toString():String
}
示例：main () {
	let pi: Pipe = Pipe(100)
    let bu: Buffer = Buffer()
    let abcString: String = "abc"
    let abc: Array<UInt8> = abcString.toUtf8Array()
    pi.sink().write(bu.write(abc),3)
    pi.sink().flush()
    let pipeSource: BufferedSource = Okio.buffer(pi.source())
    if("abc" != pipeSource.readUtf8(3).getOrThrow()) {
        return 1
    }
     return 0
}
输出结果：
	0
	
```

### 

## nio 组件

### abstract class Buffer

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
     * 指示返回此缓冲区是否为只读。
     * 返回值 Bool - 布尔值
     */
    public func isReadOnly(): Bool 
    
    /*
     * 返回此缓冲区中的第一个元素在缓冲区的底层实现数组中的偏移量 （可选操作）。
     * 如果存在实现此缓冲区的数组，则缓冲区位置 p 对应于数组索引 p + arrayOffset()。
     * 调用此方法之前要调用 hasArray 方法，以确保此缓冲区具有可访问的底层实现数组。
     * 返回值 Int64 - 偏移量
     */
    public func arrayOffset(): Int64
    
    /*
     * 判断此字节缓冲区是否为直接的。
     * 返回值 Bool - 当且仅当此缓冲区为直接时，返回 true
     */
    public func isDirect(): Bool
    
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

### abstract class ByteBuffer

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
     * 返回值 Buffer - Buffer
     */ 
    public func duplicate(): Buffer
    
    
    /*
     * 创建共享此缓冲区内容的新的只读字节缓冲区。
     * 新缓冲区的内容将为此缓冲区的内容。
     * 此缓冲区内容的更改在新缓冲区中是可见的，但新缓冲区将是只读的并且不允许修改共享内容。
     * 两个缓冲区的位置、界限和标记值是相互独立的。
     * 新缓冲区的容量、界限、位置和标记值将与此缓冲区相同。
     * 返回值 Buffer - Buffer
     */
    public func asReadOnlyBuffer(): Buffer
    
    /*
     * 获取一个字节
     * 返回值 UInt8 - UInt8
     */
    public func get(): UInt8
    
    /*
     * 存储一个字节
     * 参数 b - UInt8
     * 返回值 Buffer - Buffer
     */
    public func put(b: UInt8): Buffer
    
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
    public func put(index: Int64, b: UInt8): Buffer
    
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
     * 返回值 Buffer - Buffer
     */
    public func get(dst: Array<UInt8>, offset: Int64, length: Int64) : Buffer 
    
    /*
     * 相当于 get(dst, 0, dst.size)
     * 参数 dst - 向其中写入字节的数组
     * 返回值 Buffer - Buffer
     */
    public func get(dst: Array<UInt8>): Buffer
     
    /*
     * 将给定src缓冲区中的剩余字节传输到此缓冲区中。
     * 参数 src - 要从中读取字节的源缓冲区；不能为当前的缓冲区
     * 返回值 Buffer - Buffer
     */
    public func put(src: ByteBuffer) : ByteBuffer 
    
    /*
     * 将给定src数组中的剩余字节传输到此缓冲区中。
     * 参数 src - 要从中读取字节的数组
     * 参数 offset - 要读取的第一个字节在数组中的偏移量；必须为非负且不大于  array.size
     * 参数 length - 要从给定数组读取的字节的数量；必须为非负且不大于  array.size - offset
     * 返回值 Buffer - Buffer
     */
    public func put(src: Array<UInt8>, offset:Int64, length: Int64): Buffer 

    /*
     * 相当于 put(src, 0, src.size)
     * 参数 src - 要从中读取字节的数组
     * 返回值 Buffer - Buffer
     */
    public func put(src: Array<UInt8>): Buffer
    
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
     * 返回值 Buffer - Buffer
     */
    public func position(newPosition: Int64): Buffer

    /*
     * 设置此缓冲区的限制（limit）。
     * 如果位置（position）大于新限制（newlimit），则将其设置为新限制（limit）。
     * 如果标记（mark）已定义且大于新限制，则将丢弃该标记。
     * 参数 newPosition - 新的极限值；必须为非负，且不大于此缓冲区的容量（capacity）
     * 返回值 Buffer - Buffer
     */
    public func limit(newLimit: Int64): Buffer 
    
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
    public func clear(): Unit
    
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



