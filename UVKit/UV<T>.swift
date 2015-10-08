import libUV

public class UV<CType> {
    public typealias Pointer = UnsafeMutablePointer<CType>
    public let pointer: Pointer

    public init() {
        pointer = Pointer.alloc(sizeof(CType))
    }

    public init(_ ref: Pointer) {
        pointer = ref
    }

    func errorBlock(block: () -> Int32) {
        let result = block()
        if (result < 0) {
            let message = String.fromCString(uv_strerror(result))
            print(message ?? "unknown error")
        }
    }

    func errorBlock(handler: String? -> Void, execution: () -> Int32 ) {
        let result = execution()
        if (result < 0) {
            handler(String.fromCString(uv_strerror(result)))
        }
    }
}
