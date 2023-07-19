// DEPENDENCE: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from io4cj import nio.*
from std import os.posix.*
from std import io.*

func Assert(a: ToString, b: ToString): Unit {
    if ( a.toString() != b.toString()) {
        throw Exception()
    }
}

main () {
    if (nio_allocate_300() !=0) {
        return 1
    }
    if (nio_allocate_300_2() !=0) {
        return 2
    }
    if (nio_allocate_300_3() !=0) {
        return 3
    }
    if (nio_allocate_300_4() !=0) {
        return 4
    }
    if (nio_array_328() !=0) {
        return 5
    }
    nio_clear_333()
    nio_compact_336()
    nio_compact_336_2()
    nio_compact_336_3()
    nio_duplicate_305()
    nio_duplicate_305_2()
    nio_duplicate_305_3()
    nio_duplicate_305_4()
    nio_equals_338()
    nio_equals_338_2()
    nio_equals_338_3()
    nio_flip_334()
    nio_flip_334_2()
    nio_flip_334_3()
    nio_get_Array_322()
    nio_get_Array_322_2()
    nio_get_Array_322_3()
    nio_get_Array_322_4()
    nio_get_Array_322_5()
    nio_get_Array_322_6()
    nio_get_Array_322_7()
    nio_get_Array_322_8()
    nio_get_Array_322_9()
    nio_get_Array_322_10()
    nio_get_Array_322_11()
    nio_get_Array_323()
    nio_get_Array_323_2()
    nio_get_Array_323_4()
    nio_get_Array_323_5()
    nio_get_index_308()
    nio_get_index_308_2()
    nio_get_index_308_3()
    nio_get_put_307()
    nio_get_put_307_2()
    nio_get_put_307_3()
    nio_getInt_317()
    nio_getInt_317_2()
    nio_getInt_317_3()
    nio_getLong_316()
    nio_getLong_316_2()
    nio_getLong_316_3()
    nio_getShort_318()
    nio_getShort_318_2()
    nio_getShort_318_3()
    nio_getUInt16_321_3()
    nio_getUInt16_321_2()
    nio_getUInt16_321()
    nio_getUInt32_320_3()
    nio_getUInt32_320_2()
    nio_getUInt32_320()
    nio_getUInt64_319_3()
    nio_getUInt64_319_2()
    nio_getUInt64_319()
    nio_hasArray_327()
    nio_hashCode_337()
    nio_hasRemaining_303_3()
    nio_hasRemaining_303_2()
    nio_hasRemaining_303()
    nio_limit_331()
    nio_noequals_339_3()
    nio_noequals_339_2()
    nio_noequals_339()
    nio_position_330()
    nio_put_Array_325_11()
    nio_put_Array_325_10()
    nio_put_Array_325_9()
    nio_put_Array_325_8()
    nio_put_Array_325_7()
    nio_put_Array_325_6()
    nio_put_Array_325_5()
    nio_put_Array_325_4()
    nio_put_Array_325_2()
    nio_put_Array_325_3()
    nio_put_Array_325()
    nio_put_Array_326_5()
    nio_put_Array_326_4()
    nio_put_Array_326_2()
    nio_put_Array_326()
    nio_put_ByteBuffer_324_4()
    nio_put_ByteBuffer_324_3()
    nio_put_ByteBuffer_324_2()
    nio_put_ByteBuffer_324()
    nio_put_index_309_3()
    nio_put_index_309_2()
    nio_put_index_309()
    nio_putInt_311_3()
    nio_putInt_311_2()
    nio_putInt_311()
    nio_putLong_310_3()
    nio_putLong_310_2()
    nio_putLong_310()
    nio_putShort_312_3()
    nio_putShort_312_2()
    nio_putShort_312()
    nio_putUInt16_315_3()
    nio_putUInt16_315_2()
    nio_putUInt16_315()
    nio_putUInt32_314_3()
    nio_putUInt32_314_2()
    nio_putUInt32_314()
    nio_putUInt64_313_3()
    nio_putUInt64_313_2()
    nio_putUInt64_313()
    nio_remaining_340_3()
    nio_remaining_340_2()
    nio_remaining_340()
    nio_reset_332()
    nio_rewind_335_3()
    nio_rewind_335_2()
    nio_rewind_335()
    nio_slice_304_4()
    nio_slice_304_3()
    nio_slice_304_2()
    nio_slice_304()
    nio_slice_341_9()
    nio_slice_341_8()
    nio_slice_341_7()
    nio_slice_341_6()
    nio_slice_341_5()
    nio_slice_341_4()
    nio_slice_341_3()
    nio_slice_341_2()
    nio_slice_341()
    nio_wrap_301_6()
    nio_wrap_301_5()
    nio_wrap_301_4()
    nio_wrap_301_3()
    nio_wrap_301_2()
    nio_wrap_301()
    nio_wrap_302_13()
    nio_wrap_302_12()
    nio_wrap_302_11()
    nio_wrap_302_10()
    nio_wrap_302_9()
    nio_wrap_302_8()
    nio_wrap_302_7()
    nio_wrap_302_6()
    nio_wrap_302_5()
    nio_wrap_302_4()
    nio_wrap_302_3()
    nio_wrap_302_2()
    nio_wrap_302()
    arrayOffset_test()
    byteBuffer_put_test()
    nio_asReadOnlyBuffer_306_4()
    nio_asReadOnlyBuffer_306_3()
    nio_asReadOnlyBuffer_306_2()
    nio_asReadOnlyBuffer_306()
    return 0
}

func nio_asReadOnlyBuffer_306(): Unit {
        
    println("---------------------------nio_asReadOnlyBuffer_306-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),"[]")

    println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer.asReadOnlyBuffer()}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer.asReadOnlyBuffer()}","${byteBuffer}")
    // Assert(byteBuffer.asReadOnlyBuffer(),byteBuffer)
}

func nio_asReadOnlyBuffer_306_2(): Unit {
    
    println("---------------------------nio_asReadOnlyBuffer_306_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer.asReadOnlyBuffer()}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer.asReadOnlyBuffer()}","${byteBuffer}")
    // Assert(byteBuffer.asReadOnlyBuffer(),byteBuffer)

    // println("byteBuffer isReadOnly? : ${byteBuffer.isReadOnly()}")
    // println("byteBuffer.asReadOnlyBuffer() isReadOnly? : ${byteBuffer.asReadOnlyBuffer().isReadOnly()}")
    // Assert(byteBuffer.isReadOnly(),byteBuffer.asReadOnlyBuffer().isReadOnly())
}

func nio_asReadOnlyBuffer_306_3(): Unit {
    
    println("---------------------------nio_asReadOnlyBuffer_306_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    var byteBuffer1 = byteBuffer.asReadOnlyBuffer()

    println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer1}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")

    byteBuffer.put(123)

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer.asReadOnlyBuffer().array() : ${byteBuffer1.array()}")
    Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer}","ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=5]")
    
    println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer1}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")

} 

func nio_asReadOnlyBuffer_306_4(): Unit {
    
    println("---------------------------nio_asReadOnlyBuffer_306_4-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
    println("array() : ${byteBuffer.array()}")
    // Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    var byteBuffer1 = byteBuffer.asReadOnlyBuffer()

    // println("byteBuffer.isDirect() : ${byteBuffer.isDirect()}")
    // println("byteBuffer1.isDirect() : ${byteBuffer1.isDirect()}")
    // Assert(byteBuffer.isDirect(),byteBuffer1.isDirect())

    // println("byteBuffer.isReadOnly() : ${byteBuffer.isReadOnly()}")
    // println("byteBuffer1.isReadOnly() : ${byteBuffer1.isReadOnly()}")   
    // Assert(byteBuffer.isReadOnly(),byteBuffer1.isReadOnly())

    println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer1}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")

    byteBuffer1.put(123)

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer.asReadOnlyBuffer().array() : ${byteBuffer1.array()}")
    Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")
    
    println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer1}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=5]")

}

func byteBuffer_put_test() : Unit {
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,2)
    let arr: Array<Byte> = [1,2,3]
    byteBuffer.put(arr,1,1)
}

func arrayOffset_test(): Unit {
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,2)
    Assert(byteBuffer.arrayOffset(), 0)
}



func nio_wrap_302(): Unit {
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
    println("---------------------------nio_wrap_302-----------------------------")
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),"[]")

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),0)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),0)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=0 cap=0]")

    // println("--------------------------------------------------------")
}

func nio_wrap_302_2(): Unit {
    println("---------------------------nio_wrap_302_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,2)
    var arry = Array<UInt8>(5,item:0)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),5)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),2)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=2 cap=5]")

    // println("--------------------------------------------------------")
}

func nio_wrap_302_3(): Unit {
    println("---------------------------nio_wrap_302_3-----------------------------")
    var arry = Array<UInt8>(5,item:0)
    var byteBuffer = ByteBuffer.wrap(arry,1,2)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),5)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),1)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),3)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=1 pos=1 lim=3 cap=5]")

    // println("--------------------------------------------------------")
}

func nio_wrap_302_4(): Unit {
    println("---------------------------nio_wrap_302_4-----------------------------")
    var arry : Array<UInt8> = [1,2,3,4,5,6,7,8,9,0]
    var byteBuffer = ByteBuffer.wrap(arry,0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),5)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=10]")

    // println("--------------------------------------------------------")
}

func nio_wrap_302_5(): Unit {
    println("---------------------------nio_wrap_302_5-----------------------------")
    var arry : Array<UInt8> = Array<UInt8>(10,item:0)
    var byteBuffer = ByteBuffer.wrap(arry,5,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),5)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),10)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=5 pos=5 lim=10 cap=10]")

    byteBuffer.put(255)

    var arry2 : Array<UInt8> = [0, 0, 0, 0, 0, 255, 0, 0, 0, 0]

    println("arry : ${arry}")
    Assert(arry,arry2)

    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry2)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),6)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),10)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=6 pos=6 lim=10 cap=10]")
    // println("--------------------------------------------------------")
}

func nio_wrap_302_6(): Unit {
    println("---------------------------nio_wrap_302_6-----------------------------")
    var arry : Array<UInt8> = Array<UInt8>(10,item:0)
    var byteBuffer = ByteBuffer.wrap(arry,0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),5)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=10]")

    arry.set(0,127)

    var arry2 : Array<UInt8> = [127, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    println("arry : ${arry}")
    Assert(arry,arry2)

    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry2)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),5)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=10]")
    // println("--------------------------------------------------------")
}

func nio_wrap_302_7(): Unit {
    println("---------------------------nio_wrap_302_7-----------------------------")
    var arry = Array<UInt8>(5,item:0)
    var byteBuffer = ByteBuffer.wrap(arry,0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),5)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),5)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=5]")

    // println("--------------------------------------------------------")
}

func nio_wrap_302_8(): Unit {
    println("---------------------------nio_wrap_302_8-----------------------------")
    var exc = ""
    try{
        var arry = Array<UInt8>(5,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,5,5)
        println("array() : ${byteBuffer.array()}")
        Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 pos=0 lim=5 cap=5]")
    } catch (e:Exception) {
        // println(e.printStackTrace())
        println("e.message : ${e.message}")
        
    }
}

func nio_wrap_302_9(): Unit {
    println("---------------------------nio_wrap_302_9-----------------------------")
    var exc = ""
    try{
        var arry = Array<UInt8>(5,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,6,6)
        println("array() : ${byteBuffer.array()}")
        Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=5]")
    } catch (e:Exception) {
        // println(e.printStackTrace())
        println("e.message : ${e.message}")
        
    }
}

func nio_wrap_302_10(): Unit {
    println("---------------------------nio_wrap_302_10-----------------------------")
    var exc = ""
    try{
        var arry = Array<UInt8>(5,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,-1,5)
        println("array() : ${byteBuffer.array()}")
        Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0  mark=0 pos=0 lim=5 cap=5]")
    } catch (e:Exception) {
        // println(e.printStackTrace())
        println("e.message : ${e.message}")
        
    }
}

func nio_wrap_302_11(): Unit {
    println("---------------------------nio_wrap_302_11-----------------------------")
    var exc = ""
    try{
        var arry = Array<UInt8>(5,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,0,-1)
        println("array() : ${byteBuffer.array()}")
        Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=5]")
    } catch (e:Exception) {
        // println(e.printStackTrace())
        println("e.message : ${e.message}")
        
    }
}

func nio_wrap_302_12(): Unit {
    println("---------------------------nio_wrap_302_12-----------------------------")
    var exc = ""
    try{
        var arry = Array<UInt8>(5,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,2,3)
        println("array() : ${byteBuffer.array()}")
        // Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        // Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        // Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        // Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        // Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 pos=0 lim=5 cap=5]")
    } catch (e:Exception) {
        // println(e.printStackTrace())
        println("e.message : ${e.message}")
        
    }
}
    
func nio_wrap_302_13(): Unit {
    println("---------------------------nio_wrap_302_13-----------------------------")
    var exc = ""
    try{
        var arry = Array<UInt8>(5,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,2,4)
        println("array() : ${byteBuffer.array()}")
        // Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        // Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        // Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        // Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        // Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 pos=0 lim=5 cap=5]")
    } catch (e:Exception) {
        // println(e.printStackTrace())
        println("e.message : ${e.message}")
        
    }
}

func nio_wrap_301(): Unit {
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0))
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),"[]")

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),0)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),0)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=0 cap=0]")

    println("--------------------------------------------------------")
}

func nio_wrap_301_2(): Unit {
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0))
    var arry = Array<UInt8>(5,item:0)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),5)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),5)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=5]")

    println("--------------------------------------------------------")
}

func nio_wrap_301_3(): Unit {
    var arry = Array<UInt8>(5,item:0)
    var byteBuffer = ByteBuffer.wrap(arry)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),5)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),5)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=5]")

    println("--------------------------------------------------------")
}

func nio_wrap_301_4(): Unit {
    var arry : Array<UInt8> = [1,2,3,4,5,6,7,8,9,0]
    var byteBuffer = ByteBuffer.wrap(arry)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),10)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=10 cap=10]")

    println("--------------------------------------------------------")
}

func nio_wrap_301_5(): Unit {
    var arry : Array<UInt8> = Array<UInt8>(10,item:0)
    var byteBuffer = ByteBuffer.wrap(arry)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),10)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=10 cap=10]")

    byteBuffer.put(255)

    var arry2 : Array<UInt8> = [255, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    println("arry : ${arry}")
    Assert(arry,arry2)

    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry2)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),1)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),10)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=1 pos=1 lim=10 cap=10]")
    println("--------------------------------------------------------")
}

func nio_wrap_301_6(): Unit {
    var arry : Array<UInt8> = Array<UInt8>(10,item:0)
    var byteBuffer = ByteBuffer.wrap(arry)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),10)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=10 cap=10]")

    arry.set(0,127)

    var arry2 : Array<UInt8> = [127, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    println("arry : ${arry}")
    Assert(arry,arry2)

    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arry2)

    println("capacity() : ${byteBuffer.capacity()}")
    Assert(byteBuffer.capacity(),10)
    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
    println("limit() : ${byteBuffer.limit()}")
    Assert(byteBuffer.limit(),10)
    println("mark() : ${byteBuffer.mark()}")
    Assert(byteBuffer.mark().toString(), "ByteBuffer: [offset=0 mark=0 pos=0 lim=10 cap=10]")
    println("--------------------------------------------------------")
}

func nio_slice_341(): Unit {
        
    println("---------------------------nio_slice_341-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer.slice() : ${byteBuffer.slice(0,0)}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer.slice(0,0)}","${byteBuffer}")
    // Assert(byteBuffer.slice(),byteBuffer)
}

func nio_slice_341_2(): Unit {
    
    println("---------------------------nio_slice_341_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    println("byteBuffer.slice() : ${byteBuffer.slice(0,5)}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer.slice(0,5)}","${byteBuffer}")
    // Assert(byteBuffer.slice(),byteBuffer)

}

func nio_slice_341_3(): Unit {
    
    println("---------------------------nio_slice_341_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    var byteBuffer1 = byteBuffer.slice(0,3)

    println("byteBuffer.slice() : ${byteBuffer1}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=3]")

    byteBuffer.put(123)

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer.slice().array() : ${byteBuffer1.array()}")
    Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

    println("byteBuffer : ${byteBuffer}")
    // Assert("${byteBuffer}","ByteBuffer: [offset=0 pos=1 lim=3 cap=5]")
    
    println("byteBuffer.slice() : ${byteBuffer1}")
    // Assert("${byteBuffer1}","ByteBuffer: [offset=0 pos=0 lim=3 cap=5]")

}

func nio_slice_341_4(): Unit {
    
    println("---------------------------nio_slice_341_4-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    var byteBuffer1 = byteBuffer.slice()

    println("byteBuffer.slice() : ${byteBuffer1}")
    println("byteBuffer : ${byteBuffer}")

    byteBuffer1.put(123)

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer.slice().array() : ${byteBuffer1.array()}")
    Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

    println("byteBuffer : ${byteBuffer}")
    
    println("byteBuffer.slice() : ${byteBuffer1}")
}

func nio_slice_341_5(): Unit {
    
    println("---------------------------nio_slice_341_5-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    println("byteBuffer.slice() : ${byteBuffer.slice(5,5)}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 mark=-1 pos=0 lim=0 cap=0]")

}

func nio_slice_341_6(): Unit {
    var exc = ""
    println("---------------------------nio_slice_341_6-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    try{
        println("byteBuffer.slice() : ${byteBuffer.slice(6,0)}")
    } catch (e:Exception){
        exc = e.message
        // e.printStackTrace()
    }
    
    println("exc : ${exc}")
    // Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 pos=0 lim=0 cap=0]")

}

func nio_slice_341_7(): Unit {
    var exc = ""
    println("---------------------------nio_slice_341_7-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    try{
        println("byteBuffer.slice() : ${byteBuffer.slice(0,6)}")
    } catch (e:Exception){
        exc = e.message
        // e.printStackTrace()
    }
    
    println("exc : ${exc}")
    // Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 pos=0 lim=0 cap=0]")

}

func nio_slice_341_8(): Unit {
    var exc = ""
    println("---------------------------nio_slice_341_8-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    try{
        println("byteBuffer.slice() : ${byteBuffer.slice(-1,5)}")
    } catch (e:Exception){
        exc = e.message
        // e.printStackTrace()
    }
    
    println("exc : ${exc}")
    // Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 pos=0 lim=0 cap=0]")

}

func nio_slice_341_9(): Unit {
    var exc = ""
    println("---------------------------nio_slice_341_9-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    try{
        println("byteBuffer.slice() : ${byteBuffer.slice(0,-1)}")
    } catch (e:Exception){
        exc = e.message
        // e.printStackTrace()
    }
    
    println("exc : ${exc}")
    // Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 pos=0 lim=0 cap=0]")

}

func nio_slice_304(): Unit {
        
    println("---------------------------nio_slice_304-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),"[]")

    println("byteBuffer.slice() : ${byteBuffer.slice()}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer.slice()}","${byteBuffer}")
    // Assert(byteBuffer.slice(),byteBuffer)
}

func nio_slice_304_2(): Unit {
    
    println("---------------------------nio_slice_304_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    println("byteBuffer.slice() : ${byteBuffer.slice()}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer.slice()}","${byteBuffer}")
    // Assert(byteBuffer.slice(),byteBuffer)

}

func nio_slice_304_3(): Unit {
    
    println("---------------------------nio_slice_304_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    var byteBuffer1 = byteBuffer.slice()

    println("byteBuffer.slice() : ${byteBuffer1}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=3]")

    byteBuffer.put(123)

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer.slice().array() : ${byteBuffer1.array()}")
    Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer}","ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=5]")
    
    println("byteBuffer.slice() : ${byteBuffer1}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=3]")

}

func nio_slice_304_4(): Unit {
    
    println("---------------------------nio_slice_304_4-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    var byteBuffer1 = byteBuffer.slice()

    println("byteBuffer.slice() : ${byteBuffer1}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=3]")

    byteBuffer1.put(123)

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer.slice().array() : ${byteBuffer1.array()}")
    Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")
    
    println("byteBuffer.slice() : ${byteBuffer1}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=3]")

}
func nio_rewind_335(): Unit {
        
    println("---------------------------nio_rewind_335-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,1,8)

    byteBuffer.mark()
    byteBuffer.get()
    byteBuffer.get()
    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.rewind()
    println("byteBuffer() : ${byteBuffer.toString()}")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=9 cap=10]")
}

func nio_rewind_335_2(): Unit {
    
    println("---------------------------nio_rewind_335_2-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,0,8)

    byteBuffer.mark()
    // byteBuffer.get()
    // byteBuffer.get()
    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.rewind()
    println("byteBuffer() : ${byteBuffer.toString()}")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=8 cap=10]")
}

func nio_rewind_335_3(): Unit {
    
    println("---------------------------nio_rewind_335_3-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,0,10)

    byteBuffer.mark()
    byteBuffer.position(10)
    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.rewind()
    println("byteBuffer() : ${byteBuffer.toString()}")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=10 cap=10]")
}
func nio_reset_332(): Unit {
        
        println("---------------------------nio_reset_332-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)

    byteBuffer.mark()
    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.get()
    byteBuffer.get()
    println("position() : ${byteBuffer.position()}")
    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.position(),2)
    byteBuffer.reset()
    println("byteBuffer() : ${byteBuffer.toString()}")

    println("position() : ${byteBuffer.position()}")
    Assert(byteBuffer.position(),0)
}
func nio_remaining_340(): Unit {
        
    println("---------------------------nio_remaining_340-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)
    byteBuffer.position(5)

    println("byteBuffer() : ${byteBuffer.toString()}")
    println("byteBuffer.remaining() : ${byteBuffer.remaining()}")
    
}

func nio_remaining_340_2(): Unit {
    
    println("---------------------------nio_remaining_340_2-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)

    println("byteBuffer() : ${byteBuffer.toString()}")
    println("byteBuffer.remaining() : ${byteBuffer.remaining()}")
    
}

func nio_remaining_340_3(): Unit {
    
    println("---------------------------nio_remaining_340_3-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)
    byteBuffer.get()
    println("byteBuffer() : ${byteBuffer.toString()}")
    println("byteBuffer.remaining() : ${byteBuffer.remaining()}")
}
func nio_putUInt64_313(): Unit {
        
    println("---------------------------nio_putUInt64_313-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
    println("array() : ${byteBuffer.array()}")

    var putUInt64return = byteBuffer.putUInt64(1229782938247303441)
    var arr :Array<UInt8> = [17, 17, 17, 17, 17, 17, 17, 17, 1, 1]
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arr)

    println("putUInt64return : ${putUInt64return}")
    Assert(putUInt64return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=8 lim=9 cap=10]")
}

func nio_putUInt64_313_2(): Unit {
    
    println("---------------------------nio_putUInt64_313_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var putUInt64return = byteBuffer.putUInt64(1229782938247303441)
    println("array() : ${byteBuffer.array()}")
    var arr :Array<UInt8> = [1, 17, 17, 17, 17, 17, 17, 17, 17, 1]
    Assert(byteBuffer.array(),arr)

    println("putUInt64return : ${putUInt64return}")
    Assert(putUInt64return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=9 lim=9 cap=10]")
}


func nio_putUInt64_313_3(): Unit {
    var exc = ""
    println("---------------------------nio_putUInt64_313_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var putUInt64return = byteBuffer.putUInt64(1229782938247303441)
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_putUInt32_314(): Unit {
        
    println("---------------------------nio_putUInt32_314-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
    println("array() : ${byteBuffer.array()}")

    var putUInt32return = byteBuffer.putUInt32(286331153)
    var arr :Array<UInt8> = [17, 17, 17, 17, 1, 1, 1, 1, 1, 1]
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arr)

    println("putUInt32return : ${putUInt32return}")
    Assert(putUInt32return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=4 lim=5 cap=10]")
}

func nio_putUInt32_314_2(): Unit {
    
    println("---------------------------nio_putUInt32_314_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var putUInt32return = byteBuffer.putUInt32(286331153)
    println("array() : ${byteBuffer.array()}")
    var arr :Array<UInt8> = [1, 17, 17, 17, 17, 1, 1, 1, 1, 1]
    Assert(byteBuffer.array(),arr)

    println("putUInt32return : ${putUInt32return}")
    Assert(putUInt32return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=5 lim=5 cap=10]")
}


func nio_putUInt32_314_3(): Unit {
    var exc = ""
    println("---------------------------nio_putUInt32_314_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var putUInt32return = byteBuffer.putUInt32(286331153)
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_putUInt16_315(): Unit {
        
    println("---------------------------nio_putUInt16_315-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
    println("array() : ${byteBuffer.array()}")

    var putUInt16return = byteBuffer.putUInt16(4369)
    var arr :Array<UInt8> = [17, 17, 1, 1, 1, 1, 1, 1, 1, 1]
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arr)

    println("putUInt16return : ${putUInt16return}")
    Assert(putUInt16return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=3 cap=10]")
}

func nio_putUInt16_315_2(): Unit {
    
    println("---------------------------nio_putUInt16_315_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var putUInt16return = byteBuffer.putUInt16(4369)
    println("array() : ${byteBuffer.array()}")
    var arr :Array<UInt8> = [1, 17, 17, 1, 1, 1, 1, 1, 1, 1]
    Assert(byteBuffer.array(),arr)

    println("putUInt16return : ${putUInt16return}")
    Assert(putUInt16return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=10]")
}


func nio_putUInt16_315_3(): Unit {
    var exc = ""
    println("---------------------------nio_putUInt16_315_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var putUInt16return = byteBuffer.putUInt16(4369)
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_putShort_312(): Unit {
        
    println("---------------------------nio_putShort_312-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
    println("array() : ${byteBuffer.array()}")

    var putShortreturn = byteBuffer.putShort(-4369)
    var arr :Array<UInt8> = [238, 239, 1, 1, 1, 1, 1, 1, 1, 1]
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arr)

    println("putShortreturn : ${putShortreturn}")
    Assert(putShortreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=3 cap=10]")
}

func nio_putShort_312_2(): Unit {
    
    println("---------------------------nio_putShort_312_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var putShortreturn = byteBuffer.putShort(-4369)
    println("array() : ${byteBuffer.array()}")
    var arr :Array<UInt8> = [1, 238, 239, 1, 1, 1, 1, 1, 1, 1]
    Assert(byteBuffer.array(),arr)

    println("putShortreturn : ${putShortreturn}")
    Assert(putShortreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=10]")
}


func nio_putShort_312_3(): Unit {
    var exc = ""
    println("---------------------------nio_putShort_312_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var putShortreturn = byteBuffer.putShort(-4369)
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_putLong_310(): Unit {
        
    println("---------------------------nio_putLong_310-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
    println("array() : ${byteBuffer.array()}")

    var putLongreturn = byteBuffer.putLong(-1229782938247303441)
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arr)

    println("putLongreturn : ${putLongreturn}")
    Assert(putLongreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=8 lim=9 cap=10]")
}

// 存储一个 Int64（八个字节），只支持 Big-Endian（大端）写入操作
func nio_putLong_310_2(): Unit {
    
    println("---------------------------nio_putLong_310_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var putLongreturn = byteBuffer.putLong(-1229782938247303441)
    println("array() : ${byteBuffer.array()}")
    var arr :Array<UInt8> = [1, 238, 238, 238, 238, 238, 238, 238, 239, 1]
    Assert(byteBuffer.array(),arr)

    println("putLongreturn : ${putLongreturn}")
    Assert(putLongreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=9 lim=9 cap=10]")
}


// 存储一个 Int64（八个字节），只支持 Big-Endian（大端）写入操作
func nio_putLong_310_3(): Unit {
    var exc = ""
    println("---------------------------nio_putLong_310_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var putLongreturn = byteBuffer.putLong(-1229782938247303441)
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_putInt_311(): Unit {
        
    println("---------------------------nio_putInt_311-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
    println("array() : ${byteBuffer.array()}")

    var putIntreturn = byteBuffer.putInt(-286331153)
    var arr :Array<UInt8> = [238, 238, 238, 239, 1, 1, 1, 1, 1, 1]
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arr)

    println("putIntreturn : ${putIntreturn}")
    Assert(putIntreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=4 lim=5 cap=10]")
}

func nio_putInt_311_2(): Unit {
    
    println("---------------------------nio_putInt_311_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var putIntreturn = byteBuffer.putInt(-286331153)
    println("array() : ${byteBuffer.array()}")
    var arr :Array<UInt8> = [1, 238, 238, 238, 239, 1, 1, 1, 1, 1]
    Assert(byteBuffer.array(),arr)

    println("putIntreturn : ${putIntreturn}")
    Assert(putIntreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=5 lim=5 cap=10]")
}


func nio_putInt_311_3(): Unit {
    var exc = ""
    println("---------------------------nio_putInt_311_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var putIntreturn = byteBuffer.putInt(-286331153)
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_put_index_309(): Unit {
        
    println("---------------------------nio_put_index_309-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:1))

    var num = byteBuffer.put(0,128)
    println("byteBuffer.put(0,128) : ${byteBuffer.array()}")

    num = byteBuffer.put(4,0)
    println("byteBuffer.put(4,0) : ${byteBuffer.array()}")

    println("byteBuffer.put(4,0) : ${byteBuffer.put(4,0)}")

    var arr :Array<UInt8> = [128, 1, 1, 1, 0]
    Assert(byteBuffer.array(),arr)


}

func nio_put_index_309_2(): Unit {
    
    var exc = ""
    println("---------------------------nio_put_index_309_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:1))
    
    try{
        byteBuffer.put(5,255)
    } catch (e:IndexOutOfBoundsException){
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}

func nio_put_index_309_3(): Unit {
    
    var exc = ""
    println("---------------------------nio_put_index_309_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:1))
    
    try{
        byteBuffer.put(-1,255)
    } catch (e:IndexOutOfBoundsException){
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_put_ByteBuffer_324(): Unit {
        
    println("---------------------------nio_put_ByteBuffer_324-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.put(byteBuffer)}")
    } catch (e:IllegalArgumentException){
        // e.printStackTrace()
        exc = "IllegalArgumentException"
    }
    Assert(exc,"IllegalArgumentException")
}

func nio_put_ByteBuffer_324_2(): Unit {
    
    println("---------------------------nio_put_ByteBuffer_324_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,3)
    var byteBuffer_new = ByteBuffer.wrap(Array<UInt8>(3,item:0),0,3)
    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

    println("byteBuffer_new.put(byteBuffer) : ${byteBuffer_new.put(byteBuffer)}")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

    println("byteBuffer.toString() : ${byteBuffer.toString()}")
    println("byteBuffer_new.toString() : ${byteBuffer_new.toString()}")

    Assert(byteBuffer.array(),byteBuffer_new.array())

}

func nio_put_ByteBuffer_324_3(): Unit {
    
    println("---------------------------nio_put_ByteBuffer_324_3-----------------------------")

    var arr :Array<UInt8> = [238, 238, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    var byteBuffer_new = ByteBuffer.wrap(Array<UInt8>(3,item:0),0,3)
    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

    println("byteBuffer_new.put(byteBuffer) : ${byteBuffer_new.put(byteBuffer)}")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

    println("byteBuffer.toString() : ${byteBuffer.toString()}")
    println("byteBuffer_new.toString() : ${byteBuffer_new.toString()}")

    var arrR :Array<UInt8> = [238, 238, 0]
    Assert(arrR,byteBuffer_new.array())
}

func nio_put_ByteBuffer_324_4(): Unit {
    
    println("---------------------------nio_put_ByteBuffer_324_4-----------------------------")

    var arr :Array<UInt8> = [238, 238, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,3)
    var byteBuffer_new = ByteBuffer.wrap(Array<UInt8>(3,item:0),0,3)
    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

    byteBuffer_new.get()
    var exc = ""
    try{
        println("byteBuffer_new.put(byteBuffer) : ${byteBuffer_new.put(byteBuffer)}")
    } catch (e:Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}
func nio_put_Array_326(): Unit {
    
    println("---------------------------nio_put_Array_326-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.put(src)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    var arrR :Array<UInt8> = [0, 0, 0, 238, 238, 238, 238, 239, 1, 1]
    Assert(byteBuffer.array(),arrR)
}

func nio_put_Array_326_2(): Unit {
    
    println("---------------------------nio_put_Array_326_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 1]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,3)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.put(src)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=3]")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    var arrR :Array<UInt8> = [0, 0, 0]
    Assert(byteBuffer.array(),arrR)
}

func nio_put_Array_326_4(): Unit {
    
    println("---------------------------nio_put_Array_326_4-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.put(src)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}

func nio_put_Array_326_5(): Unit {
    
    println("---------------------------nio_put_Array_326_5-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var src :Array<UInt8> = []
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.put(src)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=2 cap=2]")

    println("src : ${src}")
    var arrR :Array<UInt8> = []
    Assert(src,arrR)
}
func nio_put_Array_325(): Unit {
        
    println("---------------------------nio_put_Array_325-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.put(src,0,3)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    var arrR :Array<UInt8> = [0, 0, 0, 238, 238, 238, 238, 239, 1, 1]
    Assert(byteBuffer.array(),arrR)
}

func nio_put_Array_325_2(): Unit {
    
    println("---------------------------nio_put_Array_325_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 1]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,3)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.put(src,0,3)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=3]")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(3,item:0))
}

func nio_put_Array_325_3(): Unit {
    
    println("---------------------------nio_put_Array_325_3-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.put(src,0,2)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=2 cap=2]")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    var arrR :Array<UInt8> = [0, 0]
    Assert(byteBuffer.array(),arrR)
}

func nio_put_Array_325_4(): Unit {
    
    println("---------------------------nio_put_Array_325_4-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.put(src,0,3)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}

func nio_put_Array_325_5(): Unit {
    
    println("---------------------------nio_put_Array_325_5-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var src :Array<UInt8> = []
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.put(src,0,0)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=2 cap=2]")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),arr)
}

func nio_put_Array_325_6(): Unit {
    
    println("---------------------------nio_put_Array_325_6-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.put(src,0,4)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}

func nio_put_Array_325_7(): Unit {
    
    println("---------------------------nio_put_Array_325_7-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.put(src,2,1)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=1 lim=4 cap=4]")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    var arrR :Array<UInt8> = [0, 1, 238, 0]
    Assert(byteBuffer.array(),arrR)

}

func nio_put_Array_325_8(): Unit {
    
    println("---------------------------nio_put_Array_325_8-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.put(src,2,0)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=4 cap=4]")

    println("byteBuffer.array() : ${byteBuffer.array()}")
    var arrR :Array<UInt8> = [238, 1, 238, 0]
    Assert(byteBuffer.array(),arrR)
}

func nio_put_Array_325_9(): Unit {
    
    println("---------------------------nio_put_Array_325_9-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.put(src,-1,4)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}

func nio_put_Array_325_10(): Unit {
    
    println("---------------------------nio_put_Array_325_10-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.put(src,1,-1)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}

func nio_put_Array_325_11(): Unit {
    
    println("---------------------------nio_put_Array_325_11-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.put(src,1,4)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}
func nio_position_330(): Unit {
        
    println("---------------------------nio_position_330-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,1,9)

    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.position(3)
    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=10 cap=10]")

    byteBuffer.position(0)
    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=10 cap=10]")
}
func nio_noequals_339(): Unit {
        
    println("---------------------------nio_noequals_339-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)

    var byteBuffer2 = byteBuffer
    println("byteBuffer2 != byteBuffer : ${byteBuffer2 != byteBuffer}")
    Assert(byteBuffer2 != byteBuffer,false)
    
}

func nio_noequals_339_2(): Unit {
    
    println("---------------------------nio_noequals_339_2-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)

    var byteBuffer2 = ByteBuffer.wrap(arr,0,5)
    println("byteBuffer2 != byteBuffer : ${byteBuffer2 != byteBuffer}")
    Assert(byteBuffer2 != byteBuffer,true)
    
}

func nio_noequals_339_3(): Unit {
    
    println("---------------------------nio_noequals_339_3-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var arr2 :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)

    var byteBuffer2 = ByteBuffer.wrap(arr2,0,5)
    println("byteBuffer2 != byteBuffer : ${byteBuffer2 != byteBuffer}")
    Assert(byteBuffer2 != byteBuffer,true)
}
func nio_limit_331(): Unit {
    println("---------------------------nio_limit_331-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,1,9)
    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.limit(3)
    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=10]")
    byteBuffer.limit(0)
    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=0 cap=10]")
}
func nio_hasRemaining_303(): Unit {
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
    println("---------------------------nio_hasRemaining_303-----------------------------")
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),"[]")

    println("capacity() : ${byteBuffer.hasRemaining()}")
    Assert(byteBuffer.hasRemaining(),false)

}

// 返回此缓冲区的容量。
func nio_hasRemaining_303_2(): Unit {
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),2,0)
    println("---------------------------nio_hasRemaining_303_2-----------------------------")
    println("array() : ${byteBuffer.array()}")

    println("capacity() : ${byteBuffer.hasRemaining()}")
    Assert(byteBuffer.hasRemaining(),false)

}

// 返回此缓冲区的容量。
func nio_hasRemaining_303_3(): Unit {
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),2,1)
    println("---------------------------nio_hasRemaining_303_3-----------------------------")
    println("array() : ${byteBuffer.array()}")

    println("capacity() : ${byteBuffer.hasRemaining()}")
    Assert(byteBuffer.hasRemaining(),true)

}
func nio_hashCode_337(): Unit {
        
    println("---------------------------nio_hashCode_337-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)

    println("byteBuffer() : ${byteBuffer.toString()}")
    println("array() : ${byteBuffer.array()}")
    println("hashCode : ${byteBuffer.hashCode()}")
    // Assert(byteBuffer.hashCode(),1088)
    
}
func nio_hasArray_327(): Unit {
        
    println("---------------------------nio_hasArray_327-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var src :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.hasArray()}")
}
func nio_getUInt64_319(): Unit {
        
    println("---------------------------nio_getUInt64_319-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    var getUInt64return = byteBuffer.getUInt64()
    
    println("array() : ${byteBuffer.array()}")

    println("getUInt64return : ${getUInt64return}")

    let a:UInt64 = 0xEEEEEEEEEEEEEEEF
    println("0xEEEEEEEEEEEEEEEF : ${a}")
    Assert(getUInt64return,a)

    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=8 lim=9 cap=10]")
}

func nio_getUInt64_319_2(): Unit {
    
    println("---------------------------nio_getUInt64_319_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var getUInt64return = byteBuffer.getUInt64()

    println("getUInt64return : ${(getUInt64return)}")
    let a:UInt64 = 0xEEEEEEEEEEEEEF01
    println("0xEEEEEEEEEEEEEEEF : ${a}")
    Assert(getUInt64return,a)

    println("byteBuffer : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=9 lim=9 cap=10]")
}


func nio_getUInt64_319_3(): Unit {
    var exc = ""
    println("---------------------------nio_getUInt64_319_3-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var getUInt64return = byteBuffer.getUInt64()
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_getUInt32_320(): Unit {
        
    println("---------------------------nio_getUInt32_320-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    var getUInt32return = byteBuffer.getUInt32()

    println("getUInt32return : ${getUInt32return}")
    Assert(getUInt32return,UInt32(4008636142))

    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=4 lim=9 cap=10]")
}

func nio_getUInt32_320_2(): Unit {
    
    println("---------------------------nio_getUInt32_320_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var getUInt32return = byteBuffer.getUInt32()

    println("getUInt32return : ${getUInt32return}")
    Assert(getUInt32return,UInt32(4008636142))

    println("byteBuffer : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=5 lim=9 cap=10]")
}


func nio_getUInt32_320_3(): Unit {
    var exc = ""
    println("---------------------------nio_getUInt32_320_3-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var getUInt32return = byteBuffer.getUInt32()
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_getUInt16_321(): Unit {
        
    println("---------------------------nio_getUInt16_321-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    var getUInt16return = byteBuffer.getUInt16()
    
    println("array() : ${byteBuffer.array()}")

    println("getUInt16return : ${getUInt16return}")
    Assert(getUInt16return,UInt16(61166))

    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=9 cap=10]")
}

func nio_getUInt16_321_2(): Unit {
    
    println("---------------------------nio_getUInt16_321_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var getUInt16return = byteBuffer.getUInt16()

    println("getUInt16return : ${getUInt16return}")
    Assert(getUInt16return,UInt16(61166))

    println("byteBuffer : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")
}


func nio_getUInt16_321_3(): Unit {
    var exc = ""
    println("---------------------------nio_getUInt16_321_3-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,3)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var getUInt16return = byteBuffer.getUInt16()
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}

func nio_getShort_318(): Unit {
        
    println("---------------------------nio_getShort_318-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    var getShortreturn = byteBuffer.getShort()
    
    println("array() : ${byteBuffer.array()}")

    println("getShortreturn : ${getShortreturn}")
    Assert(getShortreturn,Int16(-4370))

    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=9 cap=10]")
}
func nio_getShort_318_2(): Unit {
    
    println("---------------------------nio_getShort_318_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var getShortreturn = byteBuffer.getShort()

    println("getShortreturn : ${getShortreturn}")
    Assert(getShortreturn,Int16(-4370))

    println("byteBuffer : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")
}

func nio_getShort_318_3(): Unit {
    var exc = ""
    println("---------------------------nio_getShort_318_3-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,3)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var getShortreturn = byteBuffer.getShort()
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}

func nio_getLong_316(): Unit {
        
    println("---------------------------nio_getLong_316-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    var getLongreturn = byteBuffer.getLong()
    
    println("array() : ${byteBuffer.array()}")

    println("getLongreturn : ${getLongreturn}")
    Assert(getLongreturn,Int64(-1229782938247303441))

    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=8 lim=9 cap=10]")
}
func nio_getLong_316_2(): Unit {
    
    println("---------------------------nio_getLong_316_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var getLongreturn = byteBuffer.getLong()

    println("getLongreturn : ${getLongreturn}")
    Assert(getLongreturn,Int64(-1229782938247303423))

    println("byteBuffer : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=9 lim=9 cap=10]")
}

func nio_getLong_316_3(): Unit {
    var exc = ""
    println("---------------------------nio_getLong_316_3-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var getLongreturn = byteBuffer.getLong()
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}

func nio_getInt_317(): Unit {
    println("---------------------------nio_getInt_317-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")
    var getIntreturn = byteBuffer.getInt()
    println("getIntreturn : ${getIntreturn}")
    Assert(getIntreturn,Int32(-286331154))
    println("byteBuffer() : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=4 lim=9 cap=10]")
}
func nio_getInt_317_2(): Unit {
    println("---------------------------nio_getInt_317_2-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    var getIntreturn = byteBuffer.getInt()

    println("getIntreturn : ${getIntreturn}")
    Assert(getIntreturn,Int32(-286331154))

    println("byteBuffer : ${byteBuffer.toString()}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=5 lim=9 cap=10]")
}

func nio_getInt_317_3(): Unit {
    var exc = ""
    println("---------------------------nio_getInt_317_3-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)
    println("array() : ${byteBuffer.array()}")

    byteBuffer.get()
    byteBuffer.get()
    try {
        var getIntreturn = byteBuffer.getInt()
    } catch (e:Exception) {
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}

func nio_get_put_307(): Unit {
        
    println("---------------------------nio_get_put_307-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    byteBuffer.put(123)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer.get() : ${byteBuffer.get()}")

    byteBuffer.put(0)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer.get() : ${byteBuffer.get()}")

    byteBuffer.put(255)
    println("array() : ${byteBuffer.array()}")
    var arr :Array<UInt8> = [123, 0, 0, 0, 255]
    Assert(byteBuffer.array(),arr)

}
func nio_get_put_307_2(): Unit {
    
    println("---------------------------nio_get_put_307_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    byteBuffer.put(123)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer.get() : ${byteBuffer.get()}")

    byteBuffer.put(0)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer.get() : ${byteBuffer.get()}")

    byteBuffer.put(255)
    println("array() : ${byteBuffer.array()}")

    
    try{
        byteBuffer.put(255)
    } catch (e:Exception){
        // e.printStackTrace()
        println(e.message)
    }
    println("array() : ${byteBuffer.array()}")
}
func nio_get_put_307_3(): Unit {
    
    println("---------------------------nio_get_put_307_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    byteBuffer.put(123)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer.get() : ${byteBuffer.get()}")

    byteBuffer.put(0)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer.get() : ${byteBuffer.get()}")

    byteBuffer.put(255)
    println("array() : ${byteBuffer.array()}")

    try{
        byteBuffer.get()
    } catch (e:Exception){
        // e.printStackTrace()
        println(e.message)
    }
    println("array() : ${byteBuffer.array()}")
}

func nio_get_index_308(): Unit {
        
    println("---------------------------nio_get_index_308-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:1))

    var num = byteBuffer.get(0)
    println("byteBuffer.get(0) : ${num}")

    num = byteBuffer.get(4)
    println("byteBuffer.get(4) : ${num}")

}
func nio_get_index_308_2(): Unit {
    
    var exc = ""
    println("---------------------------nio_get_index_308_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:1))
    
    try{
        byteBuffer.get(5)
    } catch (e:IndexOutOfBoundsException){
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}
func nio_get_index_308_3(): Unit {
    
    var exc = ""
    println("---------------------------nio_get_index_308_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:1))
    
    try{
        byteBuffer.get(-1)
    } catch (e:IndexOutOfBoundsException){
        // e.printStackTrace()
        exc = "IndexOutOfBoundsException"
    }
    Assert(exc,"IndexOutOfBoundsException")
}

func nio_get_Array_323(): Unit {
        
    println("---------------------------nio_get_Array_323-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.get(dst)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")

    println("dst : ${dst}")
    Assert(dst,Array<UInt8>(3,item:238))
}
func nio_get_Array_323_2(): Unit {
    
    println("---------------------------nio_get_Array_323_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 1]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,3)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.get(dst)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=3]")

    println("dst : ${dst}")
    Assert(dst,arr)
}
func nio_get_Array_323_4(): Unit {
    
    println("---------------------------nio_get_Array_323_4-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.get(dst)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}
func nio_get_Array_323_5(): Unit {
    
    println("---------------------------nio_get_Array_323_5-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var dst :Array<UInt8> = []
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.get(dst)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=2 cap=2]")

    println("dst : ${dst}")
    var arrR :Array<UInt8> = []
    Assert(dst,arrR)
}

func nio_get_Array_322(): Unit {
        
    println("---------------------------nio_get_Array_322-----------------------------")

    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.get(dst,0,3)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")

    println("dst : ${dst}")
    Assert(dst,Array<UInt8>(3,item:238))
}
func nio_get_Array_322_2(): Unit {
    
    println("---------------------------nio_get_Array_322_2-----------------------------")

    var arr :Array<UInt8> = [238, 238, 1]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,3)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.get(dst,0,3)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=3]")

    println("dst : ${dst}")
    Assert(dst,arr)
}
func nio_get_Array_322_3(): Unit {
    
    println("---------------------------nio_get_Array_322_3-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.get(dst,0,2)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=2 cap=2]")

    println("dst : ${dst}")
    var arrR :Array<UInt8> = [238, 1, 0]
    Assert(dst,arrR)
}
func nio_get_Array_322_4(): Unit {
    
    println("---------------------------nio_get_Array_322_4-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.get(dst,0,3)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}
func nio_get_Array_322_5(): Unit {
    
    println("---------------------------nio_get_Array_322_5-----------------------------")

    var arr :Array<UInt8> = [238, 1]
    var dst :Array<UInt8> = []
    var byteBuffer = ByteBuffer.wrap(arr,0,2)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.get(dst,0,0)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=2 cap=2]")

    println("dst : ${dst}")
    var arrR :Array<UInt8> = []
    Assert(dst,arrR)
}
func nio_get_Array_322_6(): Unit {
    
    println("---------------------------nio_get_Array_322_6-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.get(dst,0,4)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}
func nio_get_Array_322_7(): Unit {
    
    println("---------------------------nio_get_Array_322_7-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.get(dst,2,1)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=1 lim=4 cap=4]")

    println("dst : ${dst}")
    var arrR :Array<UInt8> = [0, 0, 238]
    Assert(dst,arrR)
}
func nio_get_Array_322_8(): Unit {
    
    println("---------------------------nio_get_Array_322_8-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")

    println("byteBuffer() : ${byteBuffer.get(dst,2,0)}")
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=4 cap=4]")

    println("dst : ${dst}")
    var arrR :Array<UInt8> = [0, 0, 0]
    Assert(dst,arrR)
}
func nio_get_Array_322_9(): Unit {
    
    println("---------------------------nio_get_Array_322_9-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.get(dst,-1,4)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}
func nio_get_Array_322_10(): Unit {
    
    println("---------------------------nio_get_Array_322_10-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.get(dst,1,-1)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}
func nio_get_Array_322_11(): Unit {
    
    println("---------------------------nio_get_Array_322_11-----------------------------")

    var arr :Array<UInt8> = [238, 1, 238, 0]
    var dst :Array<UInt8> = [0, 0, 0]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)
    println("array() : ${byteBuffer.array()}")
    var exc = ""
    try{
        println("byteBuffer() : ${byteBuffer.get(dst,1,4)}")
    } catch (e: Exception){
        // e.printStackTrace()
        exc = "Exception"
    }
    Assert(exc,"Exception")
}

func nio_flip_334(): Unit {
        
    println("---------------------------nio_flip_334-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,1,8)

    byteBuffer.mark()
    byteBuffer.get()
    byteBuffer.get()
    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.flip()
    println("byteBuffer() : ${byteBuffer.toString()}")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=10]")
}
func nio_flip_334_2(): Unit {
    
    println("---------------------------nio_flip_334_2-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,0,8)

    byteBuffer.mark()
    // byteBuffer.get()
    // byteBuffer.get()
    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.flip()
    println("byteBuffer() : ${byteBuffer.toString()}")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=0 cap=10]")
}
func nio_flip_334_3(): Unit {
    
    println("---------------------------nio_flip_334_3-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,0,10)

    byteBuffer.mark()
    byteBuffer.position(10)
    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.flip()
    println("byteBuffer() : ${byteBuffer.toString()}")

    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=10 cap=10]")
}
func nio_allocate_300(): Int64 {
    var byteBuffer = ByteBuffer.allocate(0)
    println("array() : ${byteBuffer.array()}")
    if (byteBuffer.array().toString() != "[]") {
        return 1
    }

    println("capacity() : ${byteBuffer.capacity()}")
    if (byteBuffer.capacity() != 0) {
        return 2
    }
    println("position() : ${byteBuffer.position()}")
    if(byteBuffer.position()!=0){
        return 2
    }
    println("limit() : ${byteBuffer.limit()}")
    if(byteBuffer.limit()!=0){
        return 2
    }
    println("mark() : ${byteBuffer.mark()}")
    if(byteBuffer.mark().toString() != "ByteBuffer: [offset=0 mark=0 pos=0 lim=0 cap=0]"){
        return 2
    }

    println("--------------------------------------------------------")
    return 0
}
func nio_allocate_300_2(): Int64 {
    var byteBuffer = ByteBuffer.allocate(1)
    var arry = Array<UInt8>(1,item:0)
    println("array() : ${byteBuffer.array()}")
    if(byteBuffer.array().toString() != arry.toString()){
        return 2
    }

    println("capacity() : ${byteBuffer.capacity()}")
    if(byteBuffer.capacity() != 1){
        return 2
    }
    println("position() : ${byteBuffer.position()}")
    if(byteBuffer.position() != 0){
        return 2
    }
    println("limit() : ${byteBuffer.limit()}")
    if(byteBuffer.limit()!=1){
        return 2
    }
    println("mark() : ${byteBuffer.mark()}")
    if(byteBuffer.mark().toString()!="ByteBuffer: [offset=0 mark=0 pos=0 lim=1 cap=1]"){
        return 2
    }

    println("--------------------------------------------------------")
    return 0
}
func nio_allocate_300_3(): Int64 {
    try{
        var byteBuffer = ByteBuffer.allocate(-1)
        println("array() : ${byteBuffer.array()}")

        println("capacity() : ${byteBuffer.capacity()}")
        println("position() : ${byteBuffer.position()}")
        println("limit() : ${byteBuffer.limit()}")
        println("mark() : ${byteBuffer.mark()}")
    } catch (e : IllegalArgumentException){
        // println(e.printStackTrace())  
        println("e.message : ${e.message}")//提单
        return 0
    }
    println("--------------------------------------------------------")
    return 1
}
func nio_allocate_300_4(): Int64 {
    var byteBuffer = ByteBuffer.allocate(10)
    var arry = Array<UInt8>(10,item:0)
    println("array() : ${byteBuffer.array()}")
    if(byteBuffer.array().toString()!=arry.toString()){
        return 2
    }

    println("capacity() : ${byteBuffer.capacity()}")
    if(byteBuffer.capacity()!=10){
        return 2
    }
    println("position() : ${byteBuffer.position()}")
    if(byteBuffer.position()!=0){
        return 2
    }
    println("limit() : ${byteBuffer.limit()}")
    if(byteBuffer.limit()!=10){
        return 2
    }
    println("mark() : ${byteBuffer.mark()}")
    if(byteBuffer.mark().toString()!="ByteBuffer: [offset=0 mark=0 pos=0 lim=10 cap=10]"){
        return 2
    }
    return 0
}
func nio_array_328(): Int64 {
        
    println("---------------------------nio_array_328-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,0,9)
    println("array() : ${byteBuffer.array()}")

    var arr2 = byteBuffer.array()
    arr2[0] = 1
    println("array() : ${byteBuffer.array()}")

    if(arr.toString() != arr2.toString()){
        return 4
    }
    arr[1] = 2
    println("arr2 : ${arr2}")
    if(arr.toString() !=arr2.toString()){
        return 4
    }
    return 0
}
func nio_clear_333(): Int64 {
        
    println("---------------------------nio_clear_333-----------------------------")
    var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
    var byteBuffer = ByteBuffer.wrap(arr,1,8)
    byteBuffer.mark()
    byteBuffer.get()
    byteBuffer.get()
    println("byteBuffer() : ${byteBuffer.toString()}")
    byteBuffer.clear()
    println("byteBuffer() : ${byteBuffer.toString()}")

    if(byteBuffer.toString() != "ByteBuffer: [offset=0 mark=-1 pos=0 lim=10 cap=10]") {
        return 1
    }
    return 0
}
func nio_compact_336(): Unit {
    
    println("---------------------------nio_compact_336-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)

    byteBuffer.position(2)
    println("byteBuffer() : ${byteBuffer.toString()}")
    println("array() : ${byteBuffer.array()}")
    byteBuffer.compact()
    println("byteBuffer() : ${byteBuffer.toString()}")
    println("array() : ${byteBuffer.array()}")

    var arrR :Array<UInt8> =  [3, 4, 5, 4, 5]
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=5 cap=5]")
    Assert(byteBuffer.array(),arrR)
}
func nio_compact_336_2(): Unit {
    
    println("---------------------------nio_compact_336_2-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,4)

    byteBuffer.position(2)
    println("byteBuffer() : ${byteBuffer.toString()}")
    println("array() : ${byteBuffer.array()}")
    byteBuffer.compact()
    println("byteBuffer() : ${byteBuffer.toString()}")
    println("array() : ${byteBuffer.array()}")

    var arrR :Array<UInt8> =  [3, 4, 3, 4, 5]
    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=5 cap=5]")
    Assert(byteBuffer.array(),arrR)
}
func nio_compact_336_3(): Unit {
    
    println("---------------------------nio_compact_336_3-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,0)

    byteBuffer.position(0)
    println("byteBuffer() : ${byteBuffer.toString()}")
    println("array() : ${byteBuffer.array()}")
    byteBuffer.compact()
    println("byteBuffer() : ${byteBuffer.toString()}")
    println("array() : ${byteBuffer.array()}")


    Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=5 cap=5]")
    Assert(byteBuffer.array(),arr)
}

func nio_duplicate_305(): Unit {
        
    println("---------------------------nio_duplicate_305-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),"[]")

    println("byteBuffer.duplicate() : ${byteBuffer.duplicate()}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer.duplicate()}","${byteBuffer}")
    // Assert(byteBuffer.duplicate(),byteBuffer)
}
func nio_duplicate_305_2(): Unit {
    
    println("---------------------------nio_duplicate_305_2-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    println("byteBuffer.duplicate() : ${byteBuffer.duplicate()}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer.duplicate()}","${byteBuffer}")
    // Assert(byteBuffer.duplicate(),byteBuffer)

}
func nio_duplicate_305_3(): Unit {
    
    println("---------------------------nio_duplicate_305_3-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    var byteBuffer1 = byteBuffer.duplicate()

    println("byteBuffer.duplicate() : ${byteBuffer1}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")

    byteBuffer.put(123)

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer.duplicate().array() : ${byteBuffer1.array()}")
    Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer}","ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=5]")
    
    println("byteBuffer.duplicate() : ${byteBuffer1}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")

}
func nio_duplicate_305_4(): Unit {
    
    println("---------------------------nio_duplicate_305_4-----------------------------")
    var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
    println("array() : ${byteBuffer.array()}")
    Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

    var byteBuffer1 = byteBuffer.duplicate()
    println("byteBuffer.duplicate() : ${byteBuffer1}")
    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")

    byteBuffer1.put(123)

    println("byteBuffer.array() : ${byteBuffer.array()}")
    println("byteBuffer.duplicate().array() : ${byteBuffer1.array()}")
    Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

    println("byteBuffer : ${byteBuffer}")
    Assert("${byteBuffer}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")
    
    println("byteBuffer.duplicate() : ${byteBuffer1}")
    Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=5]")

}

func nio_equals_338(): Unit {
        
    println("---------------------------nio_equals_338-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)

    var byteBuffer2 = byteBuffer
    println("byteBuffer2 == byteBuffer : ${byteBuffer2 == byteBuffer}")
    Assert(byteBuffer2 == byteBuffer,true)
    
}
func nio_equals_338_2(): Unit {
    
    println("---------------------------nio_equals_338_2-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)

    var byteBuffer2 = ByteBuffer.wrap(arr,0,5)
    println("byteBuffer2 == byteBuffer : ${byteBuffer2 == byteBuffer}")
    Assert(byteBuffer2 == byteBuffer,false)
    
}
func nio_equals_338_3(): Unit {
    
    println("---------------------------nio_equals_338_3-----------------------------")
    var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    var arr2 :Array<UInt8> = [1, 2, 3, 4, 5]
    var byteBuffer = ByteBuffer.wrap(arr,0,5)

    var byteBuffer2 = ByteBuffer.wrap(arr2,0,5)
    println("byteBuffer2 == byteBuffer : ${byteBuffer2 == byteBuffer}")
    Assert(byteBuffer2 == byteBuffer,false)
}