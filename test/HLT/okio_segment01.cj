// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj


from okio import okio.*
from std import unittest.*

@Test
public class OkioTest {

    @TestCase
    func testBuffer(): Unit {
        let str = Segment(Array<UInt8>(8192, item: 0), 0, 8888, false, false)
        let str1 = Segment()
        let strr = Segment(Array<UInt8>(8192, item: 0), 0, 8888, false, false)
        let strr1 = Segment(Array<UInt8>(8192, item: 0), 0, 8888, true, true)
        let strr2 = Segment(Array<UInt8>(8192, item: 0), 0, 8888, false, true)
        let strr3 = Segment(Array<UInt8>(8192, item: 0), 1000, 8192, false, true)
        let str4 = str.writeTo(strr3,1)
        let str5 = str.push(strr)
        let str6 = str.pop()
        let str7 = str.push(str)
        let str8 = str.pop()
        let str9 = str.split(1)
        let str10 = str.compact()
        let sc = Utf8.size("asd")

        @Assert(sc , 3)
        @Assert((str == str1),false)
        @Assert((str9 != str1),true)
    }

}
