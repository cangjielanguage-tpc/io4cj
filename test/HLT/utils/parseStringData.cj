
public class ParseDataStr {

    public func parseData_utf8_1(baseStr:String,baseIndex:Int64,length!:Int64 = 3):(Int64,String) {
        var tuple_1:(Int64,String)
        var dataSize:Int64 = 0
        var subData:String = ""
        dataSize = baseStr.size
        subData = baseStr[dataSize -baseIndex..dataSize -baseIndex +length]
                  .trimAsciiLeft()
                  .trimAsciiRight()
        tuple_1 = (dataSize,subData)

        return tuple_1
    }


     public func assertNa(expr1:String):Bool {
        var returnFlag:Bool = false
        if(expr1.contains("size=0")){
            returnFlag = true
        }
        return returnFlag
     }


     public func assertException(e1:Exception,str:String):Bool {
        var returnFlag:Bool = false
        if(e1.toString().contains(str)){
            returnFlag = true
        }
        return returnFlag
     }

     public func parseArrFromString(baseStr:String,baseTag:String):(Array<String>,Int64) {
        var arr:Array<String> = Array<String>()
        var baseIndex:Int64 = baseStr.lastIndexOf(baseTag) ?? 0
        var str = baseStr[baseIndex..]
        var subStr = str[1..str.size -2+1]
        arr = subStr.split(",")
        var str2 = ""
        for(i in 0..arr.size){
            str2 = arr[i]
            arr[i] = str2.trimAsciiLeft()
                    .trimAsciiRight()
        }

        return (arr,arr.size)
    }



}
