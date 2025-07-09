## 1.0.2
- 升级io4cj到1.0.0

## 1.0.1
- 升级io4cj到60.5
- 修改bug

## 1.0.0
- 升级io4cj到58.3
- 修改bug

## v0.0.3
- 升级io4cj到55.3
- 修改bug

## v0.0.2
- 升级io4cj到54.3
- 修改bug

## v0.0.1
- 支持读文件、写文件
- 支持buffer
-【新增】ByteString类
-【缺陷】操作符重载接口 == 与！= 返回结果相同
-【缺陷】indexOf 和lastIndexOf 共重载8个接口 进行2个以上字符对比时预期结果不正确
-【文档】api文档 write (outPath: String)接口 书写错误
-【功能】ByteString 类 equals功能与竞品库不一致
-【功能】ByteString 类of接口及其重载接口 竞品库是静态方法 仓颉io4cj库非静态方法
-【新增】HashingSink HashingSource ForwardingSink ForwardingSource ForwardingTimeout DeflaterSink InflaterSource GzipSink GzipSource 类
-【修复】HashingSink 类private var closed 恒等于false
-【修复】public func writeMD5(source: BufferbyteCount: Int64) 接口byteCount参数无效
-【修复】ForwardingSink toString() 方法第一个字段竞品库是获取实例对象类名 仓颉使用固定字符串sink
-【修复】api文档描述 isDirect isReadOnly hasArray arrayOffset等接口描述与实际功能不符
-【修复】okio 组件 Pipe类初始化接口init 当入参-1时报错信息错误 提示maxBufferSize < 1: 0
-【修复】nio组件 put(src: ByteBuffer) : ByteBuffer接口 如果src是ByteBuffer对象本身 异常信息有误
-【修复】nio组件ByteBuffer类get put接口当超过缓存范围后调用，没有正确的异常信息
-【修复】public func read(sink: Buffer , byteCount: Int64): Int64，将byteCount设置为1，结果和标准库不一致
-【修复】public init(assignment: Timeout)中，当Timeout为空时，结构和标准库不一样
-【修复】duplicate 接口 asReadOnlyBuffer接口返回值类型与java不一致
-【修复】ByteBuffer.wrap接口异常信息与java竞品不一致
-【修复】var deflaterSink: DeflaterSink = DeflaterSink (sink,deflater)中，deflater没有构造方法，无法构造DeflaterSink
-【修复】RealBufferedSource类readFully接口：当RealBufferedSource实例关闭后（调用close()），调用readFully接口不抛异常，与竞品java okio库不一致
-【修复】DeflaterSink中public func write(source: Buffer,byteCount: Int64): Unit压缩后解压功能和标准库不一致
-【修复】GzipSource类中， public func read(sink: Buffer,byteCount: Int64): Int64为解压功能，误写为压缩
-【缺陷】BufferedSource 中readUtf8()接口返回值类型?String 实际逻辑不存在返回none的情况
-【缺陷】RealBufferedSource类 readFully接口 当sink长度>buffer长度 抛出Exception 建议改成EOFException


