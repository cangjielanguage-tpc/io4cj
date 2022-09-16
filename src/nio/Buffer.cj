package nio




public abstract class Buffer <: Object {
    // Invariants: mar <= pos <= lim <= capa
    // Read / write mark
    var mar: Int64 = -1
    // Read / write position
    var pos: Int64 = 0
    // Read / write limit
    var lim: Int64
    // Read / write capacity
    var capa: Int64

    
    Buffer (mark: Int64, position: Int64, limit: Int64, capacity: Int64) {
        if (capacity < 0) {
            throw IllegalArgumentException()
        }
        this.capa = capacity
        if (limit > this.capa || limit < 0 ) {
            throw IllegalArgumentException()
        }
        this.lim = limit
        if (this.pos > this.lim) {
            this.pos = this.lim
        }
        if (this.mar > this.lim) {
            this.mar = -1
        }
        if (position > this.lim || position < 0) {
            throw IllegalArgumentException()
        }
        this.pos = position
        if (mar > pos) {
            this.mar = -1
        }
        if (mark >= 0) {
            if (mark > position) {
                throw IllegalArgumentException()
            }
            this.mar = mark
        }
    }

    public func capacity(): Int64 {
        return capa
    }

    
    public func position(): Int64 {
        return pos
    }

    
    public open func position(newPosition: Int64): Buffer {
        if (newPosition > lim || newPosition < 0) {
            throw IllegalArgumentException("newPosition")
        }
        pos = newPosition
        if (mar > pos) {
            mar = -1
        }
        return this
    }

    
    public func limit(): Int64 {
        return lim
    }

    
    public open func limit(newLimit: Int64): Buffer {
        if (newLimit > capa || newLimit < 0) {
            throw IllegalArgumentException("newLimit")
        }
        lim = newLimit
        if (pos > lim) {pos = lim}
        if (mar > lim) {mar = -1}
        return this
    }

    
    public func mark(): Buffer {
        mar = pos
        return this
    }

    public open func reset(): Buffer  {
        var m = mar
        if (m < 0){
            throw Exception()
        }
        pos = m
        return this
    }

    
    public open func clear(): Buffer  {
        pos = 0
        lim = capa
        mar = -1
        return this
    }

    
    public open func flip(): Buffer  {
        lim = pos
        pos = 0
        mar = -1
        return this
    }

    
    public open func rewind(): Buffer  {
        pos = 0
        mar = -1
        return this
    }

    
    public func remaining(): Int64 {
        return lim - pos
    }

    
    public func hasRemaining(): Bool {
        return pos < lim
    }

    
    public func isReadOnly(): Bool

    
    // public func hasArray(): Bool

    
    // public func array():  // object

    
    public func arrayOffset(): Int64

    
    public func isDirect(): Bool

    
    public func slice(): Buffer 

    
    public func duplicate(): Buffer 


    public func base(): Array<UInt8>

    
    func nextGetIndex(): Int64 {
        if (pos >= lim){
            throw Exception()
        }
        let temp = pos
        pos++
        return temp
    }

    func nextGetIndex(nb: Int64): Int64 {     
        if (lim - pos < nb){
            throw Exception()
        }
        var p = pos
        pos += nb
        return p
    }

    
    func nextPutIndex(): Int64 {
        if (pos >= lim){
            throw Exception()
        }
        pos++
        return pos
    }

    func nextPutIndex(nb: Int64): Int64 {     
        if (lim - pos < nb){
            throw Exception()
        }
        var p = pos
        pos += nb
        return p
    }

    
    func checkIndex(i: Int64): Int64 {        
        if ((i < 0) || (i >= lim)){
            throw IndexOutOfBoundsException()
        }
        return i
    }

    func checkIndex(i: Int64, nb: Int64): Int64 {
        if ((i < 0) || (nb > lim - i)){
            throw IndexOutOfBoundsException()
        }
        return i
    }

    func markValue(): Int64 {   
        return mar
    }

    func truncate() {   
        mar = -1
        pos = 0
        lim = 0
        capa = 0
    }

    func discardMark() {
        mar = -1
    }

    func checkBounds(off: Int64, len: Int64, size: Int64) {
        if ((off | len | (off + len) | (size - (off + len))) < 0){
            throw IndexOutOfBoundsException()
        }
    }
}

