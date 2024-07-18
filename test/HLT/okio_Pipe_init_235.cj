// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import std.math.*
import io4cj.*

@Test
public class okio_Pipe_init_235{

    @TestCase 
    // 构造一个Pipe
    func okio_Pipe_init_235(): Unit {

        println("---------------------------okio_Pipe_init_235-----------------------------")
        var exc = ""
        try{
            let pi: Pipe = Pipe(-1)
        } catch (e : IllegalArgumentException){
            exc = e.message
        }
        println("exc : ${exc}")
        @Assert(exc,"maxBufferSize < 1: -1")
    }
    @TestCase 
    func okio_Pipe_init_235_2(): Unit {

        println("---------------------------okio_Pipe_init_235_2-----------------------------")
        var exc = ""
        try{
            let pi: Pipe = Pipe(0)
        } catch (e : IllegalArgumentException){
            exc = e.message
        }
        println("exc : ${exc}")
        @Assert(exc,"maxBufferSize < 1: 0")
    }
    @TestCase 
    func okio_Pipe_init_235_3(): Unit {

        println("---------------------------okio_Pipe_init_235_3-----------------------------")
        var exc = ""
        try{
            let pi: Pipe = Pipe(Int64.Max)
        } catch (e : IllegalArgumentException){
            exc = e.message
        }
        println("exc : ${exc}")
        // println("maxBufferSize : ${maxBufferSize}")
        @Assert(exc,"")
    }
}