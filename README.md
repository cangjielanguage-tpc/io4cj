<div align="center">
<h1>io4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.50.3-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-85.4%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

io4cj是HttpClient的底层IO库，io4cj是对仓颉io库的补充，使访问、存储和处理数据变得更加容易。核心概念是source和sink，分别类似于仓颉的InputStream和OutputStream。

参考项目：[https://square.github.io/okio/](https://link.segmentfault.com/?enc=2VN47riy2Ak%2Fwy47iNAgWQ%3D%3D.%2BGZbqetBcijDGsPLatrZBzGOj7YkIAubAWAzDAettzY%3D) 。

参考文档：https://segmentfault.com/a/1190000038470543

### 特性

- 🚀 buffer

- 💪 cipher

- 💪 hashing

- 💪forwarding

- 💪gzip

- 💪 deflate/inflate

### 路线

<p align="center">
<img src="./doc/assets/milestone.png" width="100%" >
</p>



##    <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

### 架构图

<p align="center">
<img src="./doc/assets/framework.png" width="100%" >
</p>
<p align="center">
<img src="./doc/assets/okio_framework.jpg" width="100%" >
</p>


### 源码目录

```shell
.
├── README.md
├── doc
│   ├── assets 
│	├── cjcov 
│   ├── design.md  
│   └── feature_api.md
├── src
│   ├── nio
│	│	├── Buffer.cj
│	│	├── ByteBuffer.cj
│	│	└── HeapByteBuffer.cj
│   └── okio
│ 	│ 	├── asyncTimeout.cj
│	│	├── buffer.cj
│ 	│ 	├── buffered_sink.cj
│	│	├── buffered_source.cj
│ 	│ 	├── byte_string.cj
│	│	├── deflater_sink.cj
│ 	│ 	├── exception.cj
│	│	├── forwarding_sink.cj
│ 	│ 	├── forwarding_source.cj
│	│	├── forwarding_timeout.cj
│ 	│ 	├── gzip_sink.cj
│	│	├── gzip_source.cj
│ 	│ 	├── hashing_sink.cj
│	│	├── hashing_source.cj
│	│	├── inflater_source.cj
│ 	│ 	├── okio.cj
│	│	├── PeekSource.cj
│ 	│ 	├── pipe.cj
│	│	├── pushable_timeout.cj
│ 	│ 	├── RealBufferedSink.cj
│	│	├── RealBufferedSource.cj
│ 	│ 	├── segment_pool.cj
│	│	├── segment.cj
│ 	│ 	├── sink.cj
│	│	├── SocketStream.cj
│ 	│ 	├── source.cj
│	│	├── timeout.cj
│ 	│ 	├── utf8.cj
│	│	└── util.cj
└── test   
│   ├── HLT
│   ├── LLT
│   └── UT
├── CHANGELOG.md
├── gitee_gate.cfg
├── LICENSE.txt
├── module.json
├── .gitignore
├── README.md
└── README.OpenSource
```

- `doc`是库的设计文档、库的使用文档 、LLT 覆盖率报告(1. io4cj 中存在包内可见的私有实现类, 成员函数调用之间都是包内可见函数, 外部LLT测试用例调用不到 2. io4cj中开启spawn时 LLT测试用例覆盖不到.  导致覆盖率未达到90%. )
- `src`是库源码目录
- `test`存放 HLT 测试用例、LLT 自测用例和 UT 单元测试用例

### 接口说明

主要是核心类和成员函数说明，详情见 [feature_api](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/>使用说明

### 编译

#### Linux环境编译

```cangjie
git clone https://gitee.com/HW-PLLab/io4cj.git  ---> 拉取代码
git clone https://gitee.com/HW-PLLab/testJekins.git  ---> 拉取编译脚本
cd io4cj                               ---> 进入到io4cj目录下
cp -r ../testJekins/src/ci_test .     ---> 将ci_test复制到io4cj的根目录

python3 ci_test/main.py build   ---> 编译
```

#### Windows编译

```cangjie
git clone https://gitee.com/HW-PLLab/io4cj.git  ---> 拉取代码
# io4cj依赖cryptocj, 需要在module.json中requires项配置cryptocj目录(依赖的cryptocj版本为v0.0.6 需预编译cryptocj)
# 然后在io4cj目录build
cd io4cj                               ---> 进入到io4cj目录下

cpm build -V   ---> 编译
cpm test - V   ---> 执行 test/LLT 用例
```

test/LLT 用例书写参考：https://gitee.com/HW-PLLab/cangjie-library-pages/wikis 的门禁测试脚本使用方式

#### 测试demo脚本
```shell
#!/bin/bash
io4cj_home=`pwd`
io4cj_home_lib=${io4cj_home}/build/io4cj
export LD_LIBRARY_PATH=$io4cj_home_lib:$LD_LIBRARY_PATH
cjc --import-path $io4cj_home_lib/.. -L $io4cj_home_lib -l io4cj_nio -l io4cj_okio $1 -o a.out -g
time ./a.out
```
## 功能示例
```cangjie
from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*
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

##### 执行结果如下：

```shell
abcdefghijklmn 
中国 
1234
```

#### 文件拷贝示例

```cangjie
from std import io.*
from std import time.*
from io4cj import okio.*
main() {
    let a = Time.now().unixNano() / 1000000  // 计算开始时间
    let file = File("apache-tomcat-8.5.81.rar", Read, Open)
    let bs = ByteString.read(file, file.length)
    var file2 = File("apache-tomcat-8.5.81-2.rar", Write, ForceCreate)
    bs.write(file2)
    let b = Time.now().unixNano() / 1000000  // 计算结束时间
    println(b)
    println(a)
    println(b-a)
}
```
#### 执行结果如下: 
```shell
1663827401063
1663827401032
31
```

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/>参与贡献

参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。