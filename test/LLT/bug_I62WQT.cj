// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*

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