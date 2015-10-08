import UVKit

public func createServer(handler: (Request, Responder) -> Void) -> Server {
    return Server(UVLoop.defaultLoop, handler)
}
