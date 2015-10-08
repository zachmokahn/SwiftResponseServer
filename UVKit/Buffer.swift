import libUV
import Darwin

public class Buffer: UV<uv_buf_t> {
    public override init() {
        super.init()
    }

    public func write(data: String) {
        self.pointer.memory.base = strdup(data)
        self.pointer.memory.len = Int("\(data.endIndex)")!
    }

    public func write(response: Response) {
        self.write(response.toString())
    }
}

