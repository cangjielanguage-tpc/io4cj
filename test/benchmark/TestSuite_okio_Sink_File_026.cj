// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_Sink_File_026{

    var file : File = File.create("../testData/okio_Sink_File_026.txt")
    
    public override func beforeAll(): Unit {
        try {
            File.delete("../testData/okio_Sink_File_026.txt")
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }
    }
    public override func afterAll(): Unit {
        try {
            File.delete("../testData/okio_Sink_File_026.txt")
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }
        // let sink: Sink = Okio.sink(file)
        // println("sink is Buffer?: ${sink is Buffer}")
        // println("sink is Sink?: ${sink is Sink}")
        // println("sink is Source?: ${sink is Source}")
        // println("Okio.sink(file) is BufferedSink?: ${Okio.sink(file) is BufferedSink}")
        // println("Okio.sink(file) is BufferedSource?: ${Okio.sink(file) is BufferedSource}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // sink(file: File): Sink 返回写入File的Sink。
    @TestCase
    @Bench[1]
    func okio_Sink_File_026_1(): Unit {
        Okio.sink(file)
    }
    @TestCase
    @Bench[10]
    func okio_Sink_File_026_10(): Unit {
        Okio.sink(file)
    }
    @TestCase
    @Bench[100]
    func okio_Sink_File_026_100(): Unit {
        Okio.sink(file)
    }
    @TestCase
    @Bench[1000]
    func okio_Sink_File_026_1000(): Unit {
        Okio.sink(file)
    }
    @TestCase
    @Bench[10000]
    func okio_Sink_File_026_10000(): Unit {
        Okio.sink(file)
    }
}