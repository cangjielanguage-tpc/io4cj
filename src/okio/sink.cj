/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the Sink interface.
 */

package okio
from std import io.*
from std import time.*

/**
 * The interface is Sink inherited from Resource
 * @author liyanqing14
 * @since 0.32.5
 */
public interface Sink <: Resource & ToString {
    /*
     * The Function is close
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    func close(): Unit
    /*
     * The Function is flush
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    func flush(): Unit
    /*
     * The Function is timeout
     *
     * @return Type of Timeout
     * @since 0.32.5
     */
    func timeout(): Timeout
    /*
     * The Function is write
     *
     * @param source of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    func write(source: Buffer, byteCount: Int64): Unit
}

