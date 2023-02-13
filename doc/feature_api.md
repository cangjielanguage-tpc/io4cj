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
### 1.2 示例
```cangjie
from std import io.*
from std import time.*
from okio import okio.*
main() {
    var file = File("demo.txt", Write, ForceCreate)
    Okio.buffer(Okio.sink(file))
        .writeUtf8("abcdefghijklmn \n")
        .writeUtf8("中国 \n")
        .writeUtf8("1234")
        .close();

    file = File("demo.txt", Read, Open)
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

### 2.1 主要接口

```cangjie
public class DeflaterSink <: Sink {

    /*
     * 构造一个DeflaterSink。
     */
    public init(sink: Sink , deflater: Deflater)

}
public class InflaterSource <: Source {

    /*
     * 构造一个InflaterSource。
     * 参数Source 数据源
     * 参数Inflater 
     */
    public init(source: Source)

    /*
     * 将buffer中的数据压缩到Segment对象中，并保存到BufferedSink对象中
     *返回解压缩后的字节数
     */
    public func read(sink: Buffer , byteCount: Int64): Int64
}
```

### 2.2 示例
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

### 3.1 主要接口

```cangjie
public abstract class ForwardingSink <: Sink {
	
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
    
}

public abstract class ForwardingSource <: Source{

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
}
```

### 3.2 示例
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

### 4.1 主要接口

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
}
```
### 4.2 示例
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

