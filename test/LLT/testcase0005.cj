// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import nio.*


main () {
    let buf = ByteBuffer.allocate(32)
    try{
    buf.put(buf)
    }catch(e: Exception) {  
        println(e.toString())
    }
    buf.put(12)
    buf.put(12)
    buf.put(12)
    buf.put(12)
    buf.put(12)
    buf.put(12)
    buf.put(12)
    buf.put(12)
    buf.put(12)
    buf.put(12)
    buf.put(12)
    try{
    }catch(e: Exception) {  
        println(e.toString())
    }
    println(buf.hashCode())
    buf.put(12)
    println(buf.hashCode())
    buf.put(3, 24)
    buf.put(3, 24)
    buf.put(3, 24)
    let arr: Array<Byte> = Array<Byte>(10, {i => 0})
    buf.get(arr)
    buf.get(arr, 2, 8)
    println(arr)
    buf.put(12)
    buf.flip()
    println(buf.get())
    println(buf.get(2))
    println(buf.toString())

    let bytes: Array<Byte> = [1,2,3,4,5,6,7,8,9]
    var buffer = ByteBuffer.wrap(bytes);
    buf.put(buffer)
    buf.put(bytes, 0, 1)
    buf.compact()
    println(buf.toString())
    println(buf.slice().toString())
    println(buf.asReadOnlyBuffer().toString())
    println(buf.slice(2,9).toString())
    println(buf.duplicate().toString())
    let buf2 = buf
    if (buf != buf) {
        return 1
    }
    if (!(buf == buf2)) {
        return 2
    }
    return 0
}