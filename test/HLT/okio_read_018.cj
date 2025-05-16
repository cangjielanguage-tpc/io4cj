// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_read_018{

    @TestCase
    func okio_read_018(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(6, repeat: 0)
        @Assert(a_buffer.read(arrb2),Int64(6))
        let arrb3:Array<Byte> = [6,5,4,3,2,16]
        @Assert(arrb2,arrb3)
        println(a_buffer.size)
        @Assert(a_buffer.size,1)
        println(a_buffer.exhausted())
        @Assert(a_buffer.exhausted(),false)
    }
    @TestCase
    func okio_read_018_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(6, repeat: 0)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)

        @Assert(bufferedSource.read(arrb2),Int64(6))
        let arrb3:Array<Byte> = [6,5,4,3,2,16]
        @Assert(arrb2,arrb3)
        println(bufferedSource.exhausted())
        @Assert(bufferedSource.exhausted(),false)
    }
}