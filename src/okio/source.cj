package okio
from std import io.*
from std import time.*

public interface Source <: ReadStream{
    func close(): Unit
    func read(sink: Array<Byte>, byteCount: Int64): Int64
    func timeout(): Duration
}