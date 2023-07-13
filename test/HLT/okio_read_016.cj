// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_016{

    @TestCase
    func okio_read_016(): Unit {
        println("----------------------------------------okio_read_016---------------------------------")
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
        @Assert(a_buffer.read(arrb2),Int64(7))
        println(arrb2)
        @Assert(arrb2,arrb)
        println(a_buffer.size)
        @Assert(a_buffer.size,0)
        println(a_buffer.exhausted())
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_read_016_2(): Unit {
        println("----------------------------------------okio_read_016_2---------------------------------")
        let arrb3:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer2 = Buffer()
        a_buffer2.write(arrb3)
        let arrb4 :Array<Byte> = Array<Byte>(7,item:0)

        let source: Source = a_buffer2
        let bufferedSource: BufferedSource = Okio.buffer(source)

        @Assert(bufferedSource.read(arrb4),Int64(7))
        println(arrb4)
        @Assert(arrb4,arrb3)

        println(bufferedSource.exhausted())
        @Assert(bufferedSource.exhausted(),true)

        // 需求裁剪 接口不对外
        // var exc = ""
        // try{
        //     let arrb3:Array<Byte> = [6,5,4,3,2,16,7]
        //     let a_buffer2 = Buffer()
        //     a_buffer2.write(arrb3)
        //     let arrb4 :Array<Byte> = Array<Byte>(7,item:0)

        //     let source: Source = a_buffer2
        //     let bufferedSource: BufferedSource = Okio.buffer(source)
        //     bufferedSource.close()
        //     bufferedSource.read(arrb4)
        //     println(arrb4) //不符合常理

        // } catch (e:Exception) {
        //     e.printStackTrace()
        //     println(e.message)
        //     exc = e.message
        // }
        // @Assert(exc,"closed")

    }
}