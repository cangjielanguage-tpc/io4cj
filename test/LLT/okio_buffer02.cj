// DEPENDENCE: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from okio import nio.ByteBuffer
from std import socket.*

main () {
    var str = Buffer()
    var server = Socket(TCP, "127.0.0.1", 100)
    let str1 = Okio.sink(server)
    let str2 = str.readAll(str1)
    let str3 = str.readUtf8()
    let str4 = str.readString()
    let str5 = str.readUtf8Line()
    var ess: String = ""
    var es: String = ""
    try {
        let str6 = str.readUtf8LineStrict()
    } catch(e: Exception) {
        ess = e.toString()
    }
    try {
        let str7 = str.readUtf8LineStrict(120)
    } catch(e: Exception) {
        println("case pass")
    }

    try {
        let strr7 = str.readUtf8LineStrict(-1)
    } catch(e: Exception) {
        println("case pass")
    }
    try {
        let str8 = str.readUtf8CodePoint()
    } catch(e: Exception) {
        println("case pass")
    }
    let str9 = str.indexOf(1)
    let str10 = str.indexOf(0,1)
    try{
        let strr10 = str.indexOf(0,-1)
    }catch(e: Exception){}

    let str11 = str.indexOf(ByteString(Array<Byte>(5, item: 1)))
    try {
        let str111 = str.indexOf(ByteString(Array<Byte>()))
    } catch(e: Exception) {
        es = e.toString()
    }
    try {
        let str20 = str.isClosed()
    } catch(e: Exception) {
        println("case pass")
    }
    let str12 = str.indexOf(ByteString(Array<Byte>(5, item: 1)),1)
    try{
        let strr12 = str.indexOf(ByteString(Array<Byte>(5, item: 1)),-1)
    }catch(e: Exception){}
    let str13 = str.indexOfElement(ByteString(Array<Byte>(5, item: 1)))
    let str14 = str.indexOfElement(ByteString(Array<Byte>(5, item: 1)),1)
    try{
        let strr14 = str.indexOfElement(ByteString(Array<Byte>(5, item: 1)),-1)
    }catch(e: Exception){}
    let str15 = str.rangeEquals(1,ByteString(Array<Byte>(5, item: 1)))
    let str16 = str.rangeEquals(1,ByteString(Array<Byte>(5, item: 1)),1,1)
    let str17 = str.emitCompleteSegments()
    let str18 = str.peek()
    //let str188 = str.write(Array<Byte>(5, item: 1),1,2)
    let str19 = str.close()
    let str21 = str.hashCode()
    let str22 = str.toString()
    let str23 = str.copyTo(Buffer(),0,0)
    try {
        let str24 = str.skip(5)
    } catch(e: Exception) {
        println("case pass")
    }
    try {
        var str117 = str.readInt64Le()
    } catch(e: Exception) {
        println("case pass")
    }
    let str25 = str.timeout()
    var strrs = Buffer()
    let str28 = strrs.writeInt16(20)
    let str26 = str.write(strrs,1)
    try{
        let strr26 = str.write(str,1)
    }catch(e: Exception){}
    let str27 = str.clear()
    let str29 = strrs.getInt8(0)
    try {
        let str30 = strrs.readDecimalInt64()
    } catch(e: Exception) {
        println("case pass")
    }
    try {
        let str31 = strrs.readHexadecimalUInt64()
    } catch(e: Exception) {
        println("case pass")
    }
    let str32 = strrs.readByteString()
    if(!(str != Buffer())){
        return 1
    }
    if (es != "IllegalArgumentException: bytes is empty") {
        return 2
    }
    if(str == strrs){
        return 3
    }
    strrs.writeUtf8( "" , 0 , 0 )
     try{
    strrs.writeUtf8("" , 2044 , 0)
    }catch(e: Exception){
        println("--------------")
    }
    try{
    strrs.readInt32()
    }catch(e: Exception){
        println("case pass")
    }
    try{
    strrs.readDecimalInt64()
    }catch(e: Exception){
        println("case pass")
    }
    try{
    strrs.readHexadecimalUInt64()
    }catch(e: Exception){
        println("case pass")
    }
    try{
    strrs.readByteString(1)
    }catch(e: Exception){
        println("case pass")
    }
    try{
    strrs.readUtf8CodePoint()
    }catch(e: Exception){
        println("case pass")
    }
    strrs.indexOfElement(ByteString(Array<Byte>(5, item: 1)) , 0)
    let str51 = str.rangeEquals(1,ByteString(Array<Byte>(5, item: 1)),1,0)
    return 0
}
