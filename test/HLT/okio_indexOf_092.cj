// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_indexOf_092{

    @TestCase
    func okio_indexOf_092(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.indexOf(16,1,10))
            @Assert(a_buffer.indexOf(16,1,10),5)
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        // @Assert(exc.contains("fromIndex: 1 is greater than toIndex: 1 or less than 0"),true)
    }  
    @TestCase
    func okio_indexOf_092_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.indexOf(16,1,10))
            @Assert(bufferedSource.indexOf(16,1,10),5)
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        // @Assert(exc.contains("fromIndex: 1 is greater than toIndex: 1 or less than 0"),true)
    } 
}