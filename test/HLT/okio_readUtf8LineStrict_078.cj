// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readUtf8LineStrict_078{

    @TestCase
    func okio_readUtf8LineStrict_078(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            a_buffer.writeUtf8("华为\n中国")
            println(a_buffer)
            println(a_buffer.readUtf8LineStrict(1))
            println(a_buffer)
        } catch (e:Exception) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("EOFException:"),true)
        @Assert(exc.contains("not found:"),true)
    }
    @TestCase
    func okio_readUtf8LineStrict_078_2(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            a_buffer.writeUtf8("华为\n中国")
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource)
            println(bufferedSource.readUtf8LineStrict(1))
        } catch (e:Exception) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("EOFException:"),true)
        @Assert(exc.contains("not found:"),true)
    }
}