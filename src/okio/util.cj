
package okio

class Util {
    private init(){}
    
    public static func checkOffsetAndCount (size: Int64, offset: Int64, byteCount: Int64) {
        if ((offset | byteCount) < 0 || offset > size || size - offset < byteCount ) {
            throw ArrayIndexOutOfBoundsException()
        }
    }

    @overflowWrapping
    public static func reverseBytesInt16(s: Int16): Int16 {
        let i: UInt16 = UInt16(s) & 0xffff
        return Int16((i & 0xff00) >> 8 | (i & 0x00ff) << 8)
    }

    @overflowWrapping
    public static func reverseBytesInt32(s: Int32): Int32 {
        let i: UInt32 = UInt32(s) & 0xffffffff
        return Int32((i & 0xff000000) >> 24
                | (i & 0x00ff0000) >> 8
                | (i & 0x0000ff00) << 8
                | (i & 0x000000ff) << 24)
    }

    @overflowWrapping
    public static func reverseBytesInt64(s: Int64): Int64 {
        let i: UInt64 = UInt64(s) & 0xffffffffffffffff
        return Int64((i & 0xff00000000000000) >> 56
                | (i & 0x00ff000000000000) >> 40
                | (i & 0x0000ff0000000000) >> 24
                | (i & 0x000000ff00000000) >> 8
                | (i & 0x00000000ff000000) << 8
                | (i & 0x0000000000ff0000) << 24
                | (i & 0x000000000000ff00) << 40
                | (i & 0x00000000000000ff) << 56)
    }
}