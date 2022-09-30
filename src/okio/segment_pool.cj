/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the SegmentPool class.
 */
package okio

from std import sync.*

/**
 * The class is SegmentPool
 * @author liyanqing14
 * @since 0.32.5
 */
public class SegmentPool {

    static let MAX_SIZE = 64 * 1024

    static let mutex = ReentrantMutex()

    static var next: ?Segment = None 

    static var byteCount = 0

    static func take(): Segment {
        synchronized (mutex) {
            match(next) {
                case None => ()
                case Some(result) => 
                    next = result.next
                    result.next = None
                    byteCount -= Segment.SIZE
                    return result
            }
        }
        return Segment()
    }

    static func recycle(segment: Segment) {
        match((segment.next, segment.prev)) {
            case (None, None) => ()
            case _ => throw IllegalArgumentException()
        }
        synchronized (mutex) {
            if (segment.shared || byteCount + Segment.SIZE > MAX_SIZE) {
                return
            }
            byteCount += Segment.SIZE
            segment.next = next
            segment.pos = 0
            segment.limit = 0
            next = Some(segment)
        }
    }
    
}