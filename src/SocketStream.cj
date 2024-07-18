/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */

/**
 * @file
 * The file declars the SockClient enum.
 */
package io4cj



enum SockClient {
    | SocketC(TcpSocket)
    | TlsC(TlsSocket)

    /**
     * The Function is read
     *
     * @param buffer of Array<Byte>
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func read(buffer: Array<Byte>): Int64 {
        return match(this) {
            case SocketC(conn) => conn.read(buffer)
            case TlsC(conn) => conn.read(buffer)
        }
    }

    /**
     * The Function is write
     *
     * @param buffer of Array<Byte>
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public func write(buffer: Array<Byte>): Unit {
        return match(this) {
            case SocketC(conn) => conn.write(buffer)
            case TlsC(conn) => conn.write(buffer)
        }
    }

    /**
     * The Function is close
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public func close(): Unit {
        return match(this) {
            case SocketC(conn) => conn.close()
            case TlsC(conn) => conn.close()
        }
    }
}

/**
 * The class is SocketBuffer inherited from InputStream & OutputStream & Resource & ToString
 * @author liyanqing14
 * @since 0.32.5
 */
public open class SocketBuffer <: InputStream & OutputStream & Resource & ToString {

    var sockClient: SockClient 
    let lock = ReentrantMutex()
    var closed: Bool = false

    /**
     * The Function is init constructor
     *
     * @param sockClient of Socket
     * @since 0.32.5
     */
    public init(sockClient: TcpSocket) {
        this.sockClient = SocketC(sockClient)
    }

    /**
     * The Function is init constructor
     *
     * @param sockClient of TlsSocket
     * @since 0.32.5
     */
    public init(sockClient: TlsSocket) {
        this.sockClient = TlsC(sockClient)
    }

    // Disable
    /**
     * let member length type is Int64 {
     * @since 0.32.5
     */
    public open prop length: Int64 {
        get() { -1 }
    }

    /**
     * The Function is write
     *
     * @param buffer of Array<Byte>
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func write(buffer: Array<Byte>): Unit {
        synchronized(lock) {this.sockClient.write(buffer)}
    }
    /**
     * The Function is flush
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func flush(): Unit {
        synchronized(lock) {}
    }

    /**
     * The Function is read
     *
     * @param buffer of Array<Byte>
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public open func read(buffer: Array<Byte>): Int64 {
        synchronized(lock) {this.sockClient.read(buffer)}
    }

    /**
     * The Function is isClosed
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func isClosed(): Bool {
        synchronized(lock) {this.closed}
    }

    /**
     * The Function is close
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func close(): Unit {
        synchronized(lock) {
            this.sockClient.close()
            this.closed = true
        }
        
    }

    /**
     * The Function is toString
     *
     * @return Type of String
     * @since 0.32.5
     */
    public open func toString(): String {
        synchronized(lock) {
            match (this.sockClient) {
                case SocketC(v) => v.toString()
                case TlsC(v) => v.toString()
            }
        }
    }
}
