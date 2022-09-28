// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*

main () {
    var data:String = ""
    var sourceIns:Sink = Buffer()
    var bufferIns = Okio.buffer(sourceIns) // > BufferedSink
    if(!(bufferIns is BufferedSink)){
        return  -1
    }
    let vv: Source =  Buffer()
    data = bufferIns.write(vv,0).toString() //缓冲区为空

    let cv: Buffer =  Buffer()
    var realData = cv.writeUtf8("jkjkj").toString() 
    try{
        let cvv: Source = cv
        data = bufferIns.write(cvv, 2).toString() // byteCount < 0
        if (data.toString() != "RealBufferedSink: [size=2] [106, 107]") {
            return 1
        }
    }catch(e1:Exception){
            e1.printStackTrace()
    }
    return 0
}