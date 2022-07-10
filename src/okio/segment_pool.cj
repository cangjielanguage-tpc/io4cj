package okio

from std import sync.*

class SegmentPool {

    static let MAX_SIZE = 64 * 1024

    static let mutex = ReentrantMutex()

    static var next: ?Segment = None 

    static var byteCount = 0

    static func take(): Segment {
        return match(next) {
            case Some(segment) => doTake(segment);
            case None => Segment()
        }
    }

    private static func doTake(lastNext: Segment) {
            next = lastNext.next
            lastNext.next = None
            byteCount -= Segment.SIZE
            return lastNext
    }

    static func recycle(segment: Segment) {
        match((segment.next, segment.prev)) {
            case (_, None) | (None, _) => throw IllegalArgumentException()
            case (_, _) => 1
        }
        if (segment.shared || byteCount + Segment.SIZE > MAX_SIZE) {
            return
        }
        mutex.lock()
        byteCount += Segment.SIZE
        segment.next = next
        segment.pos = 0
        segment.limit = 0
        next = Some(segment)
        mutex.unlock()
    }
    
}