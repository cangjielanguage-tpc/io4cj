// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import fs.*

main () {

    try{
      let pi: Pipe = Pipe(-1)
    }catch(e: Exception) {
      println(e.toString()) 
    }
    
    let pi5: Pipe = Pipe(100)
    let sour = pi5.source()
    let s1 = sour.timeout()
    let s2 = sour.isClosed()
    try{
    let s3 = sour.toString()
    }catch(e: Exception){}
    let sink = pi5.sink()
    let si1 = sink.timeout()
    var string1 = ""
    try{
    let si3 = sink.toString()
    }catch(e: Exception){
      string1 = e.toString()
      println(string1)
    }
    let si2 = sink.isClosed()
    
    return 0
}