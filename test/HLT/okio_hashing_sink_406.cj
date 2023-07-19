// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_hashing_sink_406 {

    @TestCase 
    // 返回一个使用过时的MD5哈希算法生成128位哈希的接收器。
    func okio_HashingSink_write_221(): Unit {

        println("---------------------------okio_HashingSink_md5_221-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.md5(sink)
        source.writeUtf8("hello world")
        hashingSink.write(source, 11)
        var exc = ""
        try{
        sink.isClosed()
        }catch(e: Exception){
            exc = e.message
        }
         @Assert(exc , "isClosed not support." )
        println(sink.toString())
        @Assert(sink.toString(),"[size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")
    }

}
