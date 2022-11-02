// 3rd_party_lib:okio/build/okio

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
            File.delete("../testData/okio_peek_100.txt")
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }

        let a_buffer = Buffer()
        a_buffer.write("abcdefhigklmn".toUtf8Array())

        var file = File.create("../testData/okio_peek_100.txt")
        let sink: Sink = Okio.sink(file)
        a_buffer.readAll(sink)
        sink.close()

        file = File.openRead("../testData/okio_peek_100.txt")
        var reals = Okio.buffer(Okio.source(file))
        
        // println("reals.readUtf8(3)")
        // println(reals.readUtf8(3).getOrThrow())
        @Assert(reals.readUtf8(3).getOrThrow(),"abc")

        // println("let peek  = reals.peek()")
        let peek  = reals.peek()

        // println("peek.readUtf8(3)")
        // println(peek.readUtf8(3).getOrThrow())
        @Assert(peek.readUtf8(3).getOrThrow(),"def")

        // println("reals.readUtf8(3)")
        // println(reals.readUtf8(3).getOrThrow())
        @Assert(reals.readUtf8(3).getOrThrow(),"def")
        
        // println("reals.close()")
        reals.close()
        
        // println("peek.readUtf8(3)")
        // println(peek.readUtf8(3).getOrThrow())
        @Assert(peek.readUtf8(3).getOrThrow(),"hig")

        try {
            println("reals.readUtf8(3)")
            println(reals.readUtf8(3).getOrThrow())

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message
        }
        @Assert(exc,"closed")

        // println("peek.readUtf8(1)")
        // println(peek.readUtf8(1).getOrThrow())
        @Assert(peek.readUtf8(1).getOrThrow(),"k")
    }   
}