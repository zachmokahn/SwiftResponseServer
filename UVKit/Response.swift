public class Response {
    var _body: String!
    public let httpVersion = "HTTP/1.1"
    public var status = "200 OK"
    public var headers: [String:String] = [
        "Content-Type":"text/plain",
        "Content-Length":"0"
    ]


    public var body: String {
        get { return self._body }
        set(value) {
            headers["Content-Length"] = "\(value.endIndex)"
            _body = value
        }
    }


    public func addHeader(header: String, _ value: String) {
        headers[header] = value
    }

    public func toString() -> String {
        var message = "\(httpVersion) \(status)\r\n"
        for (header, value) in headers {
            message += "\(header): \(value)\r\n"
        }
        message += "\r\n\(body)"
        return message
    }
}

