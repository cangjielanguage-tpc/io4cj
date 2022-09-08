
package okio
from std import io.*
from std import time.*

public interface Sink <: Resource {
    func close(): Unit
    func flush(): Unit
    func timeout(): Duration
    func write(source: Buffer, byteCount: Int64): Unit
}

