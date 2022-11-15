/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the ForwardingSink abstract class.
 */

package okio

from std import time.*

/**
 * The interface is ForwardingTimeout inherited from Timeout
 * @author liyanqing14
 * @since 0.33.3
 */
 public class ForwardingTimeout <: Timeout {
    
    /**
     * let member delegate type is Timeout
     * @since 0.33.3
     */
    private var delegate: Timeout = Timeout()

     /**
     * The Function is ForwardingTimeout
     *
     * @param delegate of Timeout
     *
     * @since 0.33.3
     */
    public init(delegate: Timeout){
        if (delegate.timeoutNanos() == 0) {
            throw IllegalArgumentException("delegate == null");
            }
        this.delegate = delegate
    }

     /**
     * The Function is getDelegate
     *
     * @return Type of Timeout
     * @since 0.33.3
     */
    public func getDelegate():Timeout{
        return delegate
    }

    /**
     * The Function is setDelegate
     *
     * @param delegate of Timeout
     *
     * @return Type of ForwardingTimeout
     * @since 0.33.3
     */
    public func  setDelegate(delegate: Timeout):ForwardingTimeout{
        if (delegate.timeoutNanos() == 0) {
            throw IllegalArgumentException("delegate == none")
            }
        this.delegate = delegate
    return this    
    }

    /**
     * The Function is timeout
     *
     * @param timeout of Int64
     *
     * @return Type of Timeout
     * @since 0.33.3
     */
    public override func timeout(timeout: Int64):Timeout { //unit: TimeUnit 
        let thi =  delegate.timeout(timeout)
        return thi
    }

    /**
     * The Function is timeoutNanos
     *
     * @return Type of Int64
     * @since 0.33.3
     */
    public override func timeoutNanos(): Int64{
        return delegate.timeoutNanos()
    }

    /**
     * The Function is hasDeadline
     *
     * @return Type of Bool
     * @since 0.33.3
     */
    public override func hasDeadline():Bool{
        return delegate.hasDeadline()
    }

    /**
     * The Function is deadlineNanoTime
     *
     * @return Type of Int64
     * @since 0.33.3
     */
    public override func deadlineNanoTime():Int64 {
    return delegate.deadlineNanoTime();
    }

    /**
     * The Function is deadlineNanoTime
     *
     * @param deadlineNanoTime of Int64
     *
     * @return Type of Timeout
     * @since 0.33.3
     */
    public override func deadlineNanoTime(deadlineNanoTime: Int64):Timeout {
    return delegate.deadlineNanoTime(deadlineNanoTime);
    }

    /**
     * The Function is clearTimeout
     *
     * @return Type of Timeout
     * @since 0.33.3
     */
    public override func clearTimeout(): Timeout {
    return delegate.clearTimeout();
    }

    /**
     * The Function is clearDeadline
     *
     * @return Type of Timeout
     * @since 0.33.3
     */
    public override func clearDeadline(): Timeout {
    return delegate.clearDeadline();
    }

    /**
     * The Function is throwIfReached
     *
     * @since 0.33.3
     */
    public override func throwIfReached(){
    delegate.throwIfReached();
    }
 }