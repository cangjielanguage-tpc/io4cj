/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the ForwardingSink abstract class.
 */

package okio

public abstract class ForwardingSink <: Sink {
    
    /**
     * let member delegate type is Sink
     * @since 0.33.3
     */
    private var delegate: Sink
    
   /**
     * The Function is init constructor
     *
     * @param delegate of Sink
     * @since 0.33.3
     */
    public init(delegate: Sink) {
    //if (delegate == null ) throw IllegalArgumentException("delegate == null");
    this.delegate = delegate
    }

    /**
     * The Function is getDelegate
     *
     * @return Type of Sink
     * @since 0.33.3
     */
    public func getDelegate(): Sink{
        return delegate
    }

    /**
     * The Function is write
     *
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public override open func write(source: Buffer,byteCount: Int64): Unit {
        delegate.write(source,byteCount)
    }

    /**
     * The Function is flush
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public override func flush(): Unit {
        delegate.flush()
    }

    /**
     * The Function is timeout
     *
     * @return Type of Timeout
     * @since 0.33.3
     */
    public override func timeout(): Timeout{
        return delegate.timeout()
    }

    /**
     * The Function is close
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public override func close(): Unit {
        delegate.close()
    }

    /**
     * The Function is toString
     *
     * @return Type of String
     * @since 0.33.3
     */
    public override func toString(): String{
        return "Sink" + "(" + delegate.toString() + ")"
  
    }
}