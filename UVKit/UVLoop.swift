import libUV

public class UVLoop : UV<uv_loop_t> {
    public static let defaultLoop: UVLoop = UVLoop(uv_default_loop())

    override init(_ ref: Pointer) {
        super.init(ref)
    }
}
