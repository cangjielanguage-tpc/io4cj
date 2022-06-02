## OkHttp的低层IO库

OkHttp的低层IO库——Okio，Okio是对仓颉io库的补充，使访问、存储和处理数据变得更加容易。 

参考项目：[https://square.github.io/okio/](https://link.segmentfault.com/?enc=2VN47riy2Ak%2Fwy47iNAgWQ%3D%3D.%2BGZbqetBcijDGsPLatrZBzGOj7YkIAubAWAzDAettzY%3D) 。

参考文档：https://segmentfault.com/a/1190000038470543

### ByteString与Buffer

Okio是围绕这两种类型构建的，它们将大量功能集成到了简单的API中：

**ByteString** 是一个不可变的字节序列，String的基础是字符，而ByteString就像是String的兄弟一样，它可以轻松将二进制数据视为某些值。这个类非常聪明：它知道如何对自己进行十六进制，base64和UTF-8编码和解码。

**Buffer** 是可变的字节序列。与ArrayList一样，无需预先设置缓冲区大小。以队列的方式读取和写入缓冲区：将数据写入末尾，然后从队列头部读取。没有必要去管理读取位置，范围或容量。

在内部，ByteString和Buffer做一些巧妙的事情来节省CPU和内存。 如果将UTF-8字符串编码为ByteString，它会缓存对该字符串的引用，以便以后进行解码时无需做任何工作。

缓冲区被实现为段的链表。当您将数据从一个缓冲区移到另一个缓冲区时，它会重新分配段的所有权，而不是跨缓冲区复制数据。这种方法对多线程程序特别有用：与网络请求相关的线程可以与工作线程交换数据，而无需任何复制或多余的操作。

```cangjie
open public class ByteString {
	open fun asByteBuffer(): ArrayList<Byte>
	func base64(): String
	func base64Url(): String
	...
} 
interface BufferedSource <: Source {
	abstract override func close(): Unit
	abstract func exhausted(): Bool
	abstract func indexOf(b: Byte): Int64
	abstract func read(p0: ByteBuffer): Int64
	...
}
interface BufferedSink <: Sink {
	abstract override func close(): Unit
	abstract func emit(): BufferedSink
	abstract override func flush()
	abstract fun write(p0: ByteBuffer): Int64
	...
}
```



### Source与Sink

对流进行分层来处理加密和压缩等转换，Source和Sink，分别类似于仓颉的ReadStream和WriteStream

- 超时（Timeout）：流提供了对底层I/O超时机制的访问。与java.io的socket字节流不同，read()和write()方法都给予超时机制。
- 实现简单： Source只声明了三个方法：read()、close()和timeout()。没有像available()或单字节读取这样会导致性能下降问题。
- 使用方便：虽然source和sink中只有三个方法需要实现，但是调用方可以实现Bufferedsource和Bufferedsink接口，这两个接口提供了丰富API能够满足你所需要的一切。
- 字节流和字符流的处理没有直观的区别：因为它们都是数据。你可以以字节、UTF-8字符串、big-endian的32位整数、little-endian的短整数等任何你想要的形式进行读写；再也不需要InputStreamReader！
- 测试简单： Buffer类同时实现了BufferedSource和BufferedSink，因此测试代码简单明了。

Sources 和 Sinks分别与InputStream和OutputStream交互操作。你可以将任何Source看做InputStream ，也可以将任何InputStream当做Source。对于Sink和Outputstream也是如此。

```cangjie
open public interface Sink <: ReadStream {
	abstract override func close(): Unit
	abstract func flush(): Unit
	abstract func timeout(): Duration
	abstract func write(source: Buffer, byteCount: Int64): Unit
	...
}
open public interface Source <: ReadStream {
	abstract override func close(): Unit
	abstract override func read(sink: Buffer, byteCount: Int64): Int64
	abstract override func timeout(): Duration
	...
}
```

