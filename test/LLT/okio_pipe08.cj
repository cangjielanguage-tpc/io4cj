// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import fs.*

main () {

    try{
      let pi5: Pipe = Pipe(-1)
    }catch(e: Exception) {
      println(e.toString()) 
    }
    return 0
}