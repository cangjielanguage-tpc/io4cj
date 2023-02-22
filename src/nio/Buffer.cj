/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the Buffer class.
 */
package nio

/**
 * The class is Buffer inherited from Object & ToString
 * @author liyanqing14
 * @since 0.32.5
 */
public abstract class Buffer <: Object & ToString {
    // Invariants: mar <= pos <= lim <= capa
    // Read / write mark
    var mar: Int64 = -1
    // Read / write position
    var pos: Int64 = 0
    // Read / write limit
    var lim: Int64
    // Read / write capacity
    var capa: Int64

    
    Buffer (marks: Int64, position: Int64, limits: Int64, capacity: Int64) {
        if (capacity < 0) {
            throw IllegalArgumentException()
        }
        this.capa = capacity
        if (limits > this.capa || limits < 0 ) {
            throw IllegalArgumentException()
        }
        this.lim = limits
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
        if (marks >= 0) {
            if (marks > position) {
                throw IllegalArgumentException()
            }
            this.mar = marks
        }
    }

    /**
     * The Function is capacity
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func capacity(): Int64 {
        return capa
    }


    /**
     * The Function is position
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func position(): Int64 {
        return pos
    }

    /**
     * The Function is position
     *
     * @param newPosition of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func position(newPosit: Int64): Buffer {
        if (newPosit > lim || newPosit < 0) {
            throw IllegalArgumentException("newPosition")
        }
        if (mar > pos) {
            mar = -1
        }
        pos = newPosit
        return this
    }


    /**
     * The Function is limit
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func limit(): Int64 {
        return lim
    }


    /**
     * The Function is limit
     *
     * @param newLimit of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func limit(newLimits: Int64): Buffer {
        if (newLimits > capa || newLimits < 0) {
            throw IllegalArgumentException("newLimit")
        }
        lim = newLimits
        if (pos > lim) {pos = lim}
        if (mar > lim) {mar = -1}
        return this
    }


    /**
     * The Function is mark
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func mark(): Buffer {
        mar = pos
        return this
    }

    /**
     * The Function is reset
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func reset(): Buffer  {
        var ma = mar
        if (ma < 0){
            throw Exception()
        }
        pos = ma
        return this
    }


    /**
     * The Function is clear
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func clear(): Buffer  {
        pos = 0
        lim = capa
        mar = -1
        return this
    }


    /**
     * The Function is flip
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func flip(): Buffer  {
        lim = pos
        pos = 0
        mar = -1
        return this
    }


    /**
     * The Function is rewind
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func rewind(): Buffer  {
        pos = 0
        mar = -1
        return this
    }


    /**
     * The Function is remaining
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func remaining(): Int64 {
        let rems = lim - pos
        return if (rems > 0) {
            rems
        } else {
            0
        }
    }


    /**
     * The Function is hasRemaining
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public func hasRemaining(): Bool {
        return pos < lim
    }

    /**
     * The Function is arrayOffset
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func arrayOffset(): Int64

    /**
     * The Function is slice
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func slice(): Buffer 

    /**
     * The Function is duplicate
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func duplicate(): Buffer 

    /**
     * The Function is array
     *
     * @return Type of Array<UInt8>
     * @since 0.32.5
     */
    public func array(): Array<UInt8>

    /**
     * The Function is nextGetIndex
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    func nextGetIndex(): Int64 {
        if (pos >= lim){
            throw Exception()
        }
        let temps = pos
        pos++
        return temps
    }

    /**
     * The Function is checkIndex
     *
     * @param i of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    func checkIndex(t: Int64): Int64 {        
        if ((t < 0) || (t >= lim)){
            throw IndexOutOfBoundsException()
        }
        return t
    }

    /**
     * The Function is markValue
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    func markValue(): Int64 {   
        return mar
    }

    /**
     * The Function is discardMark
     *
     * @since 0.32.5
     */
    func discardMark() {
        mar = -1
    }

    /**
     * The Function is checkBounds
     *
     * @param off of Int64
     * @param len of Int64
     * @param size of Int64
     *
     * @since 0.32.5
     */
    func checkBounds(off: Int64, len: Int64, size: Int64) {
        if ((off | len | (off + len) | (size - (off + len))) < 0){
            throw IndexOutOfBoundsException()
        }
    }
}

