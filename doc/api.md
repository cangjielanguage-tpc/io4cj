# okio api文档
## 模块 okio

核心类api说明

Okio 类

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
    public static func sink(socket: Socket): Sink (下个迭代转测)

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
    public static func source(socket: Socket): Source  (下个迭代转测)

    /*
     * 返回写入File的Source。
     * 参数 File - 标准库std的文件对象
     * 返回值 Source - Source对象
     */
    public static func source(file: File): Source
}
```

Source 接口

此接口在功能上等同于cangjie标准库的std.io.InputStream
```cangjie
public interface Source <: Resource {
    /*
     * 关闭此源并释放此源持有的资源。读取封闭源是一个错误。多次关闭Source是安全的。
     */
    func close(): Unit (下个迭代转测)

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
    func timeout(): Timeout (下个迭代转测)
}
```

Sink 接口

此接口在功能上等同于cangjie标准库的std.io.OutputStream
```cangjie
public interface Sink <: Resource {

    /*
     * 将所有缓冲字节推送到SInk的目标中, 并释放此Sink持有的资源。写入已关闭的Sink是错误的。多次关闭Sink是安全的。
     */
    func close(): Unit   (下个迭代转测)

    /*
     * 将所有缓冲字节推送到SInk的目标中。
     */
    func flush(): Unit  (下个迭代转测)

    /*
     * 返回此接收器的超时对象
     * 返回值 Timeout - 超时对象
     */
    func timeout(): Timeout  (下个迭代转测)

    /*
     * 从Source中删除byteCount字节并将其附加到此Sink中。
     * 参数 Buffer - okio的Buffer对象, source的实现类
     * 参数 Int64 - 计数器
     */
    func write(source: Buffer, byteCount: Int64): Unit
}
```

BufferedSink 抽象类

一种在内部保留缓冲区的接收器，以便调用者可以进行较小的写操作，而不会降低性能。
```cangjie
public interface BufferedSink <: Sink {
    /*
     * 向BufferedSink中写入一个完整的ByteString所包含的字节序列
     * 参数 Buffer - okio的ByteString对象
     * 返回值 BufferedSink - BufferedSink
     */
    func write(byteString: ByteString): BufferedSink  (下个迭代转测)

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
    func writeUtf8CodePoint(codePoInt64: Int64): BufferedSink (下个迭代转测)

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
    func emitCompleteSegments(): BufferedSink (下个迭代转测)

}
```

BufferedSource 抽象类

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
    func read(sink: ByteBuffer): Int64  (下个迭代转测)

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
    func readByteString(): ByteString  (下个迭代转测)

    /*
     * 从中删除byteCount字节并将其作为字节字符串返回。
     * 参数 Int64 - byteCount
     * 返回值 ByteString - ByteString
     */
    func readByteString(byteCount: Int64): ByteString (下个迭代转测)

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

Buffer 实现类

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
}
```

ByteString 类

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
