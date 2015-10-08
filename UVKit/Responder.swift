import libUV
import Darwin

public class Responder {
    public typealias StreamPointer = UnsafeMutablePointer<uv_stream_t>

    let writer: Writer = Writer()
    let buffer: Buffer = Buffer()
    let response: Response = Response()

    let client: Stream

    public init(_ client: StreamPointer) {
        self.client = Stream(client)
    }

    public func addHeader(header: String, _ value: String) {
        response.addHeader(header, value)
    }

    public func end(body: String) {
        response.body = body
        self.buffer.write(response)

        IO.write(self.writer, self.client, self.buffer)
        IO.close(HandlePointer(self.client.pointer))
    }

    deinit {
        free(self.buffer.pointer)
    }
}
