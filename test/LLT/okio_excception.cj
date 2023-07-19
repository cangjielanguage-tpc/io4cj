// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*

main () {


    try{
    throw AssertionException()
    }catch(es: AssertionException){
    }

    try{
    throw ArrayIndexOutOfBoundsException()
    }catch(es: ArrayIndexOutOfBoundsException){
    }

    try{
    throw InterruptedException ()
    }catch(es: InterruptedException ){
    }

    try{
    throw IllegalStateException ()
    }catch(es: IllegalStateException ){
    }

    try{
    throw NumberFormatException  ()
    }catch(es: NumberFormatException  ){
    }

    var see: String = ""
    try{
    throw AssertionException("I am an Exception!")
    }catch(es: AssertionException){
        see = es.toString()
    }
    if(see.size != 50){
        return 1
    }

    var see1: String = ""
    try{
    throw ArrayIndexOutOfBoundsException ("I am an Exception!")
    }catch(es1: ArrayIndexOutOfBoundsException){
        see1 = es1.toString()
    }

    println(see1.size)
    if(see1.size != 62){
        return 1
    }
  return 0   
}