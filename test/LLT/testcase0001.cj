// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import nio.*

main () {
    let bytes = Array<Byte>(32, item: 0);
    var buffer = ByteBuffer.wrap(bytes);
    buffer.clear();
    buffer.position(5);
    buffer.mark();
    buffer.position(10);
    if (buffer.position() != 10 && buffer.limit() != 32 && buffer.capacity() != 32) {
        return 1
    }
    buffer.reset();
    if (buffer.position() != 5 && buffer.limit() != 32 && buffer.capacity() != 32) {
        return 1
    }
    buffer.clear();
    buffer.position(10);
    buffer.limit(15);
    if (buffer.position() != 10 && buffer.limit() != 15 && buffer.capacity() != 32) {
        return 1
    }
    buffer.rewind();
    if (buffer.position() != 0 && buffer.limit() != 15 && buffer.capacity() != 32) {
        return 1
    }
    return 0
}