#! /bin/bash
crypto4cj_path=$(cd `dirname $0`; pwd)
#crypto4cj_path=$(pwd)


# check libcryto.so
if [ ! -d "${crypto4cj_path}/lib/" ];then
    mkdir ${crypto4cj_path}/lib
    echo "Please copy libcryto.dll to the folder ${crypto4cj_path}/lib."
    exit 1
fi

if [ ! -f "${crypto4cj_path}/lib/libcrypto.dll" ];then
    echo "Please copy libcryto.dll to the folder ${crypto4cj_path}/lib."
    exit 1
fi

# crypto4cj
cd  ${crypto4cj_path}/
echo start build crypto4cj
cjpm build -V
cp ${crypto4cj_path}/lib/*.dll ${crypto4cj_path}/target/release/crypto4cj/
echo end build crypto4cj
