<div align="center">
<h1>Okio</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.35.6-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-85.1%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

Okio是OkHttp的低层IO库，Okio是对仓颉io库的补充，使访问、存储和处理数据变得更加容易。核心概念是source和sink，分别类似于仓颉的InputStream和OutputStream。

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



##    <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 软件架构

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
│   ├── design.md  
│   ├── proposal.md
│   └── xxx_lib.md 
├── src
│   ├── nio
│   └── okio
└── test   
    ├── HLT
    ├── LLT
    └── UT
```

- `doc`是库的设计文档、提案、库的使用文档 、LLT 覆盖率报告(1. okio 中存在包内可见的私有实现类, 成员函数调用之间都是包内可见函数, 外部LLT测试用例调用不到 2. okio中开启spawn时 LLT测试用例覆盖不到.  导致覆盖率未达到90%. )
- `src`是库源码目录
- `test`是存放测试用例，包括HLT用例、LLT 用例和UT用例

### 接口说明

主要是核心类和成员函数说明，详情见 [API](./doc/api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/>编译执行

### 编译

设置好cjc和cpm的编译环境

```shell
cd okio
cpm build
```
#### 测试demo脚本
```shell
#!/bin/bash
okio_home=`pwd`
okio_home_lib=${okio_home}/build/okio
export LD_LIBRARY_PATH=$okio_home_lib:$LD_LIBRARY_PATH
cjc --import-path $okio_home_lib/.. -L $okio_home_lib -l okio_nio -l okio_okio $1 -o a.out -g
time ./a.out
```
#### 文件读写示例
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
from okio import okio.*
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