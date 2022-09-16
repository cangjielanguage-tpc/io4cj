package okio

from std import io.InputStream
from std import io.OutputStream
from std import socket.Socket
from net import tls.TlsSocket

enum SockClient {
    | SocketC(Socket)
    | TlsC(TlsSocket)

    public func read(buffer: Array<Byte>): Int64 {
        return match(this) {
            case SocketC(conn) => conn.read(buffer)
            case TlsC(conn) => conn.read(buffer)
        }
    }

    public func write(buffer: Array<Byte>): Unit {
        return match(this) {
            case SocketC(conn) => conn.write(buffer)
            case TlsC(conn) => conn.write(buffer)
        }
    }

    public func close(): Unit {
        return match(this) {
            case SocketC(conn) => conn.close()
            case TlsC(conn) => conn.close()
        }
    }
}

public open class SocketBuffer <: InputStream & OutputStream & Resource & ToString {

    var sockClient: SockClient 
    let lock = ReentrantMutex()
    var closed: Bool = false

    public init(sockClient: Socket) {
        this.sockClient = SocketC(sockClient)
    }

    public init(sockClient: TlsSocket) {
        this.sockClient = TlsC(sockClient)
    }

    // Disable
    public open prop let length: Int64 {
        get() { -1 }
    }

    public open func write(buffer: Array<Byte>): Unit {
        synchronized(lock) {this.sockClient.write(buffer)}
    }
    public open func flush(): Unit {
        synchronized(lock) {}
    }

    public open func read(buffer: Array<Byte>): Int64 {
        synchronized(lock) {this.sockClient.read(buffer)}
    }

    public open func isClosed(): Bool {
        synchronized(lock) {this.closed}
    }
    
    public open func close(): Unit {
        synchronized(lock) {
            this.sockClient.close()
            this.closed = true
        }
        
    }

    public open func toString(): String {
        synchronized(lock) {
            match (this.sockClient) {
                case SocketC(v) => v.toString()
                case TlsC(v) => v.toString()
            }
        }
    }
}
