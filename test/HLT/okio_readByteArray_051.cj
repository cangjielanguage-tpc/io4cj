// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readByteArray_051{

    @TestCase
    func okio_readByteArray_051(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        @Assert(a_buffer.readByteArray(9),arrb)
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_readByteArray_051_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)

        // @Assert(bufferedSource.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        @Assert(bufferedSource.readByteArray(9),arrb)
        @Assert(bufferedSource.exhausted(),true)
    }
}