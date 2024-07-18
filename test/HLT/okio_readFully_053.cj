// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readFully_053{

    @TestCase
    func okio_readFully_053(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2:Array<Byte> = Array<Byte>(7,item:0)
        @Assert(a_buffer.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        a_buffer.readFully(arrb2)
        let arrb3:Array<Byte> = [6,5,4,3,2,16,7]
        @Assert(arrb2,arrb3)
        @Assert(a_buffer.size,2)
        @Assert(a_buffer.exhausted(),false)
    }
    @TestCase
    func okio_readFully_053_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        let arrb2:Array<Byte> = Array<Byte>(7,item:0)
        // @Assert(a_buffer.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        bufferedSource.readFully(arrb2)
        let arrb3:Array<Byte> = [6,5,4,3,2,16,7]
        @Assert(arrb2,arrb3)
        @Assert(bufferedSource.exhausted(),false)

        var exc = ""
        try{
            let arrb4:Array<Byte> = Array<Byte>(7,item:0)
            a_buffer.write(arrb)
            bufferedSource.close()
            bufferedSource.readFully(arrb4)
            println(arrb4)
        } catch (e:Exception){
            exc = e.message
            println("e.message : ${"EOFException"}")
        }
        @Assert(exc,"closed")
    }
}