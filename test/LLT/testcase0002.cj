// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*

main () {
    let buffer = Buffer()
    buffer.writeInt32(998);
    buffer.writeInt8(1);
    buffer.writeInt16(2);
    buffer.writeInt64(3);
    if (buffer.readInt32() != Int32(998)) {
        return 1
    }
    if (buffer.readInt8() != Int8(1)) {
        return 1
    }
    if (buffer.readInt16() != Int16(2)) {
        return 1
    }
    if (buffer.readInt64() != Int64(3)) {
        return 1 
    }
    return 0
}