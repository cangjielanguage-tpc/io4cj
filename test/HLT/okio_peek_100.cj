// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_peek_100{

    @TestCase
    func okio_peek_100(): Unit {
        var exc = ""
        try {
            File.delete("../../testData/okio_peek_100.txt")
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }

        let a_buffer = Buffer()
        a_buffer.write("abcdefhigklmn".toUtf8Array())

        var file = File.create("../../testData/okio_peek_100.txt")
        let sink: Sink = Okio.sink(file)
        a_buffer.readAll(sink)
        sink.close()

        file = File.openRead("../../testData/okio_peek_100.txt")
        var reals = Okio.buffer(Okio.source(file))
        
        // println("reals.readUtf8(3)")
        // println(reals.readUtf8(3))
        @Assert(reals.readUtf8(3),"abc")

        // println("let peek  = reals.peek()")
        let peek  = reals.peek()

        // println("peek.readUtf8(3)")
        // println(peek.readUtf8(3))
        @Assert(peek.readUtf8(3),"def")

        // println("reals.readUtf8(3)")
        // println(reals.readUtf8(3))
        @Assert(reals.readUtf8(3),"def")
        
        // println("reals.close()")
        reals.close()
        
        // println("peek.readUtf8(3)")
        // println(peek.readUtf8(3))
        @Assert(peek.readUtf8(3),"hig")

        try {
            println("reals.readUtf8(3)")
            println(reals.readUtf8(3))

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message
        }
        @Assert(exc,"closed")

        // println("peek.readUtf8(1)")
        // println(peek.readUtf8(1))
        @Assert(peek.readUtf8(1),"k")
    }  
}