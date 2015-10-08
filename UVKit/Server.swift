import libUV
import Darwin

final class Box<A> {
    let unbox: A
    init(_ value: A) { unbox = value }
}

func unsafeFromVoidPointer<A>(x: UnsafeMutablePointer<Void>) -> A? {
    guard x != nil else { return nil  }
    return Unmanaged<Box<A>>.fromOpaque(COpaquePointer(x)).takeUnretainedValue().unbox
}

func retainedVoidPointer<A>(x: A?) -> UnsafeMutablePointer<Void> {
    guard let value = x else { return UnsafeMutablePointer() }
    let unmanaged = Unmanaged.passRetained(Box(value))
    return UnsafeMutablePointer(unmanaged.toOpaque())
}

public class Server: UV<uv_tcp_t> {
    let loop: UVLoop

        public init(_ loop: UVLoop, _ handler: (Request, Responder) -> Void) {
            self.loop = loop
            super.init()

            uv_tcp_init(self.loop.pointer, self.pointer)
            self.pointer.memory.data = retainedVoidPointer(handler)
        }

    public func listen(port: Int) {
        Address.IP4(port, self.pointer).listen { request, status in
            Client(request).read { client, bytesRead, buffer in
                let handler: (Request, Responder) -> Void = unsafeFromVoidPointer(client.memory.data)!
                handler(Request(client), Responder(client))
            }
        }

        uv_run(self.loop.pointer, UV_RUN_DEFAULT)
    }
}
