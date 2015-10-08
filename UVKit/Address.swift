import libUV
import Darwin

class Address {
    typealias TCP = UnsafeMutablePointer<uv_tcp_t>
    typealias SockAddr = UnsafePointer<sockaddr>
    typealias Stream = UnsafeMutablePointer<uv_stream_t>

    class IP4: UV<sockaddr_in> {
        let tcp: TCP

        init(_ port: Int, _ tcp: TCP) {
            self.tcp = tcp
            super.init()

            uv_ip4_addr("0.0.0.0", Int32(port), self.pointer)
            uv_tcp_bind(self.tcp, SockAddr(self.pointer), UInt32(AF_INET))
        }

        func listen(handle: uv_connection_cb!) {
            uv_listen(Stream(self.tcp), SOMAXCONN, handle)
        }
    }
}
