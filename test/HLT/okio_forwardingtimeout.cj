// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_ForwardingTimeout {
    @TestCase
    func okio_Forwardingtimeout01(): Unit {
        let str = Timeout()
        let str1 = str.timeout(1)
        let str2 = str.deadlineNanoTime(1)
        let ft: ForwardingTimeout = ForwardingTimeout(str)
        let ft1 = ft.delegate()
        println(ft1.timeoutNanos())
        println(ft1.hasDeadline())
        println(ft1.deadlineNanoTime())
        @Assert(ft1.timeoutNanos().toString(),"1")
        @Assert(ft1.hasDeadline().toString(),"true")
        @Assert(ft1.deadlineNanoTime().toString(),"1")
    }

    @TestCase
    func okio_Forwardingtimeout02(): Unit {
        var timeout = Timeout()
        var timeout1 = timeout.timeout(1) //int64
        var timeout2 = timeout.deadlineNanoTime(2147483648)
        var ft: ForwardingTimeout = ForwardingTimeout(timeout)
        var ft1 = ft.delegate()
        println(ft1.timeoutNanos())
        println(ft1.hasDeadline())
        println(ft1.deadlineNanoTime())
        @Assert(ft1.timeoutNanos().toString(),"1")
        @Assert(ft1.hasDeadline().toString(),"true")
        @Assert(ft1.deadlineNanoTime().toString(),"2147483648")
    }

    @TestCase
    func okio_Forwardingtimeout03(): Unit {
        var timeout = Timeout()
        var timeout1 = timeout.timeout(1) //int64
        var timeout2 = timeout.deadlineNanoTime(-2147483648)
        var ft: ForwardingTimeout = ForwardingTimeout(timeout)
        var ft1 = ft.delegate()
        println(ft1.timeoutNanos())
        println(ft1.hasDeadline())
        println(ft1.deadlineNanoTime())
        @Assert(ft1.timeoutNanos().toString(),"1")
        @Assert(ft1.hasDeadline().toString(),"true")
        @Assert(ft1.deadlineNanoTime().toString(),"-2147483648")
    }

    @TestCase
    func okio_Forwardingtimeout04(): Unit {
        var timeout = Timeout()
        var timeout1 = timeout.timeout(1) //int64
        var timeout2 = timeout.deadlineNanoTime(0)
        var ft: ForwardingTimeout = ForwardingTimeout(timeout)
        var ft1 = ft.delegate()
        println(ft1.timeoutNanos())
        println(ft1.hasDeadline())
        println(ft1.deadlineNanoTime())
        @Assert(ft1.timeoutNanos().toString(),"1")
        @Assert(ft1.hasDeadline().toString(),"true")
        @Assert(ft1.deadlineNanoTime().toString(),"0")
    }

    @TestCase
    func okio_Forwardingtimeout05(): Unit {
        try {
            var timeout = Timeout()
            var timeout1 = timeout.timeout(1) //int64
            var timeout2 = timeout.deadlineNanoTime()
            var ft: ForwardingTimeout = ForwardingTimeout(timeout)
            var ft1 = ft.delegate()
            println(ft1.timeoutNanos())
            println(ft1.hasDeadline())
            println(ft1.deadlineNanoTime())
            @Assert(ft1.timeoutNanos().toString(),"1")
            @Assert(ft1.hasDeadline().toString(),"true")
            @Assert(ft1.deadlineNanoTime().toString(),"0")
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: No deadline")
        }
    }

    @TestCase
    func okio_Forwardingtimeout06(): Unit {
        let str = Timeout()
        let str1 = str.timeout(2)
        let str2 = str.deadlineNanoTime(2)

        //let str3= Timeout()
        //let str4 = str3.timeout(3)           
        //let str5 = str3.deadlineNanoTime(3)
        let ft: ForwardingTimeout = ForwardingTimeout(str)
        let ft2 = ft.setDelegate(str)
        println(ft2.timeoutNanos())
        println(ft2.hasDeadline())
        println(ft2.deadlineNanoTime())
        println(ft.timeoutNanos())
        println(ft.hasDeadline())
        println(ft.deadlineNanoTime())
        @Assert(ft2.timeoutNanos().toString(),"2")
        @Assert(ft2.hasDeadline().toString(),"true")
        @Assert(ft2.deadlineNanoTime().toString(),"2")
    }

    @TestCase
    func okio_Forwardingtimeout07(): Unit {
        let str = Timeout()
        let str1 = str.timeout(1) //int64
        let str2 = str.deadlineNanoTime(1)
        let ft: ForwardingTimeout = ForwardingTimeout(str)
        let ft1 = ft.clearTimeout()
        let ft2 = ft.clearDeadline()
        var exc = ""
        try{
        let ft3 = ft.throwIfReached()
        }catch(e: Exception){
            exc = e.message
        }
        @Assert(exc , "")
        println(ft2.timeoutNanos())
        println(ft2.hasDeadline())
        @Assert(ft2.timeoutNanos().toString(),"0")
        @Assert(ft2.hasDeadline().toString(),"false")
    }
}
