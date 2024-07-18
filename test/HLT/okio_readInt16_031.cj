// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readInt16_031{

    @TestCase
    func okio_readInt16_031(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.readInt16(),Int16((6<<8) | 5))
        @Assert(a_buffer.size,5)
        @Assert(a_buffer.exhausted(),false)
    }
    @TestCase
    func okio_readInt16_031_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readInt16(),Int16((6<<8) | 5))
        @Assert(bufferedSource.exhausted(),false)

        var exc = ""
        try{
            bufferedSource.close()
            bufferedSource.readInt16()
        } catch (e:Exception){
            exc = e.message
            println("e.message : ${e.message}")
        }
        @Assert(exc,"closed")
    }
}