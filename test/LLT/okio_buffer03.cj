// DEPENDENCE: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import std.time.*
import io4cj.*

main () {

    let bufferedSink01 = Buffer()
        bufferedSink01.writeUtf8("")
        
        let buffer01 = Buffer()
        let sink: Sink = buffer01
        let bufferedSink02: BufferedSink = Okio.buffer(sink)
        bufferedSink02.writeUtf8("")
    
        let bufferedSink03 = Buffer()
        bufferedSink03.writeUtf8("hello world",6,11)

        let buffer02 = Buffer()
        let sink01: Sink = buffer02
        let bufferedSink04: BufferedSink = Okio.buffer(sink01)
        bufferedSink04.writeUtf8("hello world",6,11)

        var exc = ""
        let buffer022 = Buffer()
        let sink011: Sink = buffer022
        let bufferedSink05: BufferedSink = Okio.buffer(sink011)
        try{
            bufferedSink05.close()
            bufferedSink05.writeUtf8("hello world",6,11)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }

        let bufferedSink06 = Buffer()
        bufferedSink06.writeUtf8("",0,0)

        let buffer03 = Buffer()
        let sink02: Sink = buffer03
        let bufferedSink07: BufferedSink = Okio.buffer(sink02)
        bufferedSink07.writeUtf8("",0,0)
        try{

        let bufferedSink08 = Buffer()
        bufferedSink08.writeUtf8("hello world",-1,11)
        }catch(e:Exception){
            println(e.toString())
        }

            try{
            let buffer04 = Buffer()
            let sink03: Sink = buffer04
            let bufferedSink09: BufferedSink = Okio.buffer(sink03)
            bufferedSink09.writeUtf8("hello world",-1,11)
            }catch(e:Exception){
                println(e.toString())
            }

            try{
            let bufferedSink10 = Buffer()
            bufferedSink10.writeUtf8("hello world",0,-1)
            }catch(e:Exception){
                println(e.toString())
            }

            try{
            let buffer05 = Buffer()
            let sink04: Sink = buffer05
            let bufferedSink11: BufferedSink = Okio.buffer(sink04)
            bufferedSink11.writeUtf8("hello world",0,-1)
            }catch(e:Exception){
                println(e.toString())
            }

            try{
            let bufferedSink12 = Buffer()
            bufferedSink12.writeUtf8("hello world",5,4)
            }catch(e:Exception){
                println(e.toString())
            }

            try{
            let buffer06 = Buffer()
            let sink05: Sink = buffer06
            let bufferedSink13: BufferedSink = Okio.buffer(sink05)
            bufferedSink13.writeUtf8("hello world",5,4)
            }catch(e:Exception){
                println(e.toString())
            }
            
            return 0

}