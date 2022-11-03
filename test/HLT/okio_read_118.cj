// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_118{

    @TestCase
    func okio_read_118(): Unit {
        var exc = ""
        try {
            let bs = ByteString.read("/home/xuman/cangjie/okio/test/HLT/aaa/testData3.txt")
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[size=0]")

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(exc.contains("The file does not exist!"),true)
    }   
}