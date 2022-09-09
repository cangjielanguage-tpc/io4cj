package okio
from std import io.*
from std import time.*

public interface Source <: Resource {
    func close(): Unit
    func read(sink: Buffer, byteCount: Int64): Int64
    func timeout(): Timeout
}