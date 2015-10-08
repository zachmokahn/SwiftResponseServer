import libUV
import Darwin

public typealias Stream = UV<uv_stream_t>
public typealias Writer = UV<uv_write_t>
public typealias HandlePointer = UnsafeMutablePointer<uv_handle_t>

public struct IO {
    public static func write(writer: Writer, _ client: Stream, _ buffer: Buffer) {
        uv_write(writer.pointer, client.pointer, buffer.pointer, 1) { request, _ in free(request) }
    }

    public static func close(handle: HandlePointer) {
        uv_close(handle) { handle in free(handle) }
    }
}

