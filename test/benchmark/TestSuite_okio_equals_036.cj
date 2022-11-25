// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_equals_036{

    let bs = ByteString("hello world".toUtf8Array())
    let bs2 = ByteString("hello world".toUtf8Array())
    let bs3 = bs2
    let bs6 = ByteString("213".toUtf8Array())
    let bs7 = ByteString("456".toUtf8Array())
    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // println("bs.equals(bs2) : ${bs.equals(bs2)}")
        // println("bs3.equals(bs2) : ${bs3.equals(bs2)}")
        // println("bs6.equals(bs7) : ${bs6.equals(bs7)}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // 判断自身的内部数组与 o 的内部数组进行比较, 如果都相同则返回true, 否则返回false.
    // public func equals (o: ByteString): Bool
    @TestCase
    @Bench[1]
    func okio_equals_036_1(): Unit {
        bs.equals(bs2)
        bs3.equals(bs2)
        bs6.equals(bs7)
    }
    @TestCase
    @Bench[10]
    func okio_equals_036_10(): Unit {
        bs.equals(bs2)
        bs3.equals(bs2)
        bs6.equals(bs7)
    }
    @TestCase
    @Bench[100]
    func okio_equals_036_100(): Unit {
        bs.equals(bs2)
        bs3.equals(bs2)
        bs6.equals(bs7)
    }
    @TestCase
    @Bench[1000]
    func okio_equals_036_1000(): Unit {
        bs.equals(bs2)
        bs3.equals(bs2)
        bs6.equals(bs7)
    }
    @TestCase
    @Bench[10000]
    func okio_equals_036_10000(): Unit {
        bs.equals(bs2)
        bs3.equals(bs2)
        bs6.equals(bs7)
    }
}