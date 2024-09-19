// DEPENDENCE: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.time.*

main () {
    var str = ByteString(Array<Byte>(5, repeat: 0))
    let str1 = str.rangeEquals(1,ByteString(Array<Byte>()),1,1)
    let str2 = str.rangeEquals(1,ByteString(Array<Byte>()),1,1)
    let str3 = str.startsWith(ByteString(Array<Byte>(5, repeat: 1)))
    let str4 = str.startsWith(Array<Byte>())
    let str5 = str.endsWith(ByteString(Array<Byte>(5, repeat: 1)))
    let str6 = str.endsWith(Array<Byte>())
    let str7 = str.indexOf(ByteString(Array<Byte>(5, repeat: 1)))
    let str8 = str.indexOf(ByteString(Array<Byte>(5, repeat: 1)),1)
    let str9 = str.indexOf(Array<Byte>())
    let str10 = str.indexOf(Array<Byte>(),1)
    let str11 = str.lastIndexOf(ByteString(Array<Byte>(5, repeat: 1)))
    let str12 = str.lastIndexOf(ByteString(Array<Byte>(5, repeat: 1)),1)
    let str13 = str.lastIndexOf(Array<Byte>())
    let str14 = str.lastIndexOf(Array<Byte>(),1)
    let str15 = str.hashCode()
    let str16 = str.toString()
    var strr = ByteString(Array<Byte>())
    let strr1 = strr.toString()
    if (str == ByteString(Array<Byte>())) {
        return 1
    }
    if (str != ByteString(Array<Byte>(5, repeat: 0))) {
        return 2
    }
    if (str.equals(ByteString(Array<Byte>()))) {
        return 3
    }
    return 0
}
