// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_exhausted_003{

    @TestCase//exhausted(): Bool BufferedSource 有字节 & BufferedSource 没有更多字节
    func okio_exhausted_003(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()

        println(a_buffer.exhausted())
        @Assert(a_buffer.exhausted(),true)
        a_buffer.write(arrb)
        println(a_buffer.exhausted())
        @Assert(a_buffer.exhausted(),false)
    }
    @TestCase//exhausted(): Bool BufferedSource 有字节 & BufferedSource 没有更多字节
    func okio_exhausted_003_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        println("---------------------------------------------------------------")
        let a_buffer2 = Buffer()
        let source: Source = a_buffer2
        let bufferedSource: BufferedSource = Okio.buffer(source)
        println(bufferedSource.exhausted())
        @Assert(bufferedSource.exhausted(),true)
        a_buffer2.write(arrb)
        println(bufferedSource.exhausted())
        @Assert(bufferedSource.exhausted(),false)

        var exc = ""
        bufferedSource.close()
        try{
            bufferedSource.exhausted()
        } catch (e:IllegalArgumentException) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc,"closed")
    }
}