import libUV

public class Request {
    public typealias Stream = UnsafeMutablePointer<uv_stream_t>

    public init(_ stream: Stream) {
    }
}
