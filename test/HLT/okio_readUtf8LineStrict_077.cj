// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readUtf8LineStrict_077{

    @TestCase
    func okio_readUtf8LineStrict_077(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            a_buffer.writeUtf8("华为\n中国")
            println(a_buffer)
            println(a_buffer.readUtf8LineStrict(0))
            println(a_buffer)
        } catch (e:Exception) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("EOFException:"),true)
        @Assert(exc.contains("not found:"),true)
    }
}