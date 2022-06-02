<p align="center">
<img src="./doc/assets/logo.png" width="30%" >
</p>
<p align="center">
<img alt="" src="https://badg.now.sh/badge/release/v0.0.1?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/build/pass?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/cjc/v0.29.3?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/cjcov/0%25?color=red" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/project/open?color=green" style="display: inline-block;" />
</p>




## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

Okio是OkHttp的低层IO库，Okio是对仓颉io库的补充，使访问、存储和处理数据变得更加容易。核心概念是source和sink，分别类似于仓颉的ReadStream和WriteStream。

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
│   └── Template.cj
└── test   
    ├── HLT
    ├── LLT
    └── UT
```

- `doc`是库的设计文档、提案、库的使用文档
- `src`是库源码目录
- `test`是存放测试用例，包括HLT用例、LLT 用例和UT用例

### 接口说明

主要是核心类和成员函数说明

#### class xxx

##### func yyy

成员函数功能描述

```cangjie
func yyy(): Unit
```

##### func zzz

成员函数功能描述

```cangjie
func zzz(): Unit
```

#### class xxx

##### func yyy

成员函数功能描述

```cangjie
func yyy(): Unit
```

##### func zzz

成员函数功能描述

```cangjie
func zzz(): Unit
```

#### func xxxx

Top level函数功能描述

```cangjie
func xxxx(): Unit
```

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/>编译执行

### 编译

编译描述和具体shell命令

```shell
cpm update
cpm build
```

### xx示例

示例描述

```cangjie
import xxx.*

```

执行结果如下：

```shell
xxx
```



## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/>参与贡献

主要写参与贡献的人以及个人主页链接

[@chinesebear](https://gitee.com/chinesebear)