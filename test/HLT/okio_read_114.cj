// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_114{

    @TestCase
    func okio_read_114(): Unit {
        var exc = ""
        try {
            var arr : Array<Byte> = "hello world".toUtf8Array()
            var bas = ByteArrayStream()
            bas.write(arr)

            let bs = ByteString.read(bas)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello world]")

            var arr2 : Array<Byte> = "".toUtf8Array()
            var bas2 = ByteArrayStream()
            bas2.write(arr2)

            let bs2 = ByteString.read(bas2)
            println("bs = ${bs2.toString()}")
            @Assert(bs2.toString(),"[size=0]")

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}