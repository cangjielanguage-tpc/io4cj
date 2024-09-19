// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_read_024{

    @TestCase
    func okio_read_024(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(7, repeat: 0)
        @Assert(a_buffer.read(arrb2,5,0),0)
        println(arrb2)
        println(a_buffer.size)
        println(a_buffer.exhausted())
        let arrb3 :Array<Byte> = [0, 0, 0, 0, 0, 0, 0]
        @Assert(arrb2,arrb3)
        @Assert(a_buffer.size,7)
        @Assert(a_buffer.exhausted(),false)

    }
    @TestCase
    func okio_read_024_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(7, repeat: 0)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.read(arrb2,5,0),0)
        println(arrb2)
        println(bufferedSource.exhausted())
        let arrb3 :Array<Byte> = [0, 0, 0, 0, 0, 0, 0]
        @Assert(arrb2,arrb3)
        @Assert(bufferedSource.exhausted(),false)

    }
}