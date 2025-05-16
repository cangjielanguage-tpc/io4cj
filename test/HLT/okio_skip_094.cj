// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_skip_094{

    @TestCase
    func okio_skip_094(): Unit {
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer)
            @Assert(a_buffer.toString(),"[size=7] [6, 0, 4, 3, 5, 16, 5]")
            println(a_buffer.skip(-1))
            println(a_buffer)
            @Assert(a_buffer.toString(),"[size=7] [6, 0, 4, 3, 5, 16, 5]")
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }
    @TestCase
    func okio_skip_094_2(): Unit {
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.request(1))
            println(bufferedSource)
            @Assert(bufferedSource.toString(),"RealBufferedSource: [size=7] [6, 0, 4, 3, 5, 16, 5]")
            println(bufferedSource.skip(-1))
            println(bufferedSource)
            @Assert(bufferedSource.toString(),"RealBufferedSource: [size=7] [6, 0, 4, 3, 5, 16, 5]")
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }
}