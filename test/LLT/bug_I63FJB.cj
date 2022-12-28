// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from okio import nio.*

main () {
    try {
        ByteBuffer.wrap([1,2,3,4,5], 5,5)
        return 1
    }catch (e: IndexOutOfBoundsException) {
        return 0
    }
    return 1
}