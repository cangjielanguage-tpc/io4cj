// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from compress import zlib.*
from std import fs.*

main () {
    let data: Buffer = Buffer()
    let testString: String = "Test whether gzipsink can be compressed"
    data.writeUtf8(testString)

    let inflater: Inflater = Inflater()
    inflater.end()
    let inflaterSource: InflaterSource = InflaterSource(data,inflater)
    inflaterSource.toString()
    inflaterSource.timeout()
    return 0
}