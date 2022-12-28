/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * The file declars the Source interface.
 */
package okio

/**
 * The interface is Source inherited from Resource
 * @author liyanqing14
 * @since 0.32.5
 */
public interface Source <: Resource & ToString {
    /*
     * The Function is close
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    func close(): Unit
    /*
     * The Function is read
     *
     * @param sink of Buffer
     * @param byteCount of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    func read(sink: Buffer, byteCount: Int64): Int64
    /*
     * The Function is timeout
     *
     * @return Type of Timeout
     * @since 0.32.5
     */
    func timeout(): Timeout
}