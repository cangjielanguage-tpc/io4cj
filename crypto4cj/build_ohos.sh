#! /bin/bash
crypto4cj_path=$(cd `dirname $0`; pwd)
#crypto4cj_path=$(pwd)


# check libcryto.so
if [ ! -d "${crypto4cj_path}/lib/" ];then
    mkdir ${crypto4cj_path}/lib
    echo "Please copy libcryto.so to the folder ${crypto4cj_path}/lib."
    exit 1
fi

if [ ! -f "${crypto4cj_path}/lib/libcrypto.so" ];then
    echo "Please copy libcryto.so to the folder ${crypto4cj_path}/lib."
    exit 1
fi

# "/usr1/ohos/llvm/bin/"为ohos编译路径，
# "/usr1/ohos/llvm/include/aarch64-linux-ohos"为ohos头文件路径，请自行修改
./configure --cc="/usr1/ohos/llvm/bin/clang" --cross-prefix="/usr1/ohos/llvm/bin/llvm-" \
--target=aarch64-linux-ohos --cflags="-I/usr1/ohos/llvm/include/aarch64-linux-ohos"
make

# crypto4cj
cd  ${crypto4cj_path}/
echo start build crypto4cj
cjpm build -V
cp ${crypto4cj_path}/lib/*.so ${crypto4cj_path}/target/release/crypto4cj/
echo end build crypto4cj
