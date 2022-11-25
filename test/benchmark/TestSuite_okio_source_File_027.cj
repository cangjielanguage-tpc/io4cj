// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_Source_File_027{

    var file : File = File.create("../testData/okio_Source_File_027.txt")
    public override func beforeAll(): Unit {
        try {
            File.delete("../testData/okio_Source_File_027.txt")
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }
    }
    public override func afterAll(): Unit {
        try {
            File.delete("../testData/okio_Source_File_027.txt")
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }
        // let source: Source = Okio.source(file)
        // println("source is Buffer?: ${source is Buffer}")
        // println("source is Sink?: ${source is Sink}")
        // println("source is Source?: ${source is Source}")
        // println("Okio.source(file) is BufferedSource?: ${Okio.source(file) is BufferedSource}")
        // println("Okio.source(file) is BufferedSource?: ${Okio.source(file) is BufferedSource}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // bsource(file: File): Source 返回写入File的Source。
    @TestCase
    @Bench[1]
    func okio_Source_File_027_1(): Unit {
        Okio.source(file)
    }
    @TestCase
    @Bench[10]
    func okio_Source_File_027_10(): Unit {
        Okio.source(file)
    }
    @TestCase
    @Bench[100]
    func okio_Source_File_027_100(): Unit {
        Okio.source(file)
    }
    @TestCase
    @Bench[1000]
    func okio_Source_File_027_1000(): Unit {
        Okio.source(file)
    }
    @TestCase
    @Bench[10000]
    func okio_Source_File_027_10000(): Unit {
        Okio.source(file)
    }
}