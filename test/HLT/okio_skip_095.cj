// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_skip_095{

    @TestCase
    func okio_skip_095(): Unit {
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer)
            @Assert(a_buffer.toString(),"[size=7] [6, 0, 4, 3, 5, 16, 5]")
            println(a_buffer.skip(0))
            println(a_buffer)
            @Assert(a_buffer.toString(),"[size=7] [6, 0, 4, 3, 5, 16, 5]")
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }
    @TestCase
    func okio_skip_095_2(): Unit {
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.request(1))
            println(bufferedSource)
            @Assert(bufferedSource.toString(),"RealBufferedSource: [size=7] [6, 0, 4, 3, 5, 16, 5]")
            println(bufferedSource.skip(0))
            println(bufferedSource)
            @Assert(bufferedSource.toString(),"RealBufferedSource: [size=7] [6, 0, 4, 3, 5, 16, 5]")
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }
}