// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*

main () {
    let source = Buffer()
    let buffer: BufferedSource = Okio.buffer(source)
    buffer.close()
    try {
        buffer.readFully([3,2,1])
        return 1
    }catch (e: Exception) {
        return 0
    }
    return 1
}