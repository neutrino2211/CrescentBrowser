import Libadwaita
import GLibObject
import Gtk


// Convert pointer to uint64
public extension UnsafeMutablePointer {
  func toUInt64() -> UInt64 {
    return UInt64(bitPattern:Int64(Int(bitPattern: self)))
  }
}

// Convert pointer to NativeWidgetPeer
public extension UnsafeMutableRawPointer {
  func toUInt64() -> UInt64 {
    return UInt64(bitPattern:Int64(Int(bitPattern: self)))
  }
}

public extension GLibObject.Object {
  func toNativeWidgetPeer() -> NativeWidgetPeer {
    return WidgetWrapper(withPointer: self.ptr!.toUInt64())
  }

  func toPointer<T>() -> UnsafeMutablePointer<T> {
    return UnsafeMutablePointer(bitPattern: UInt(self.ptr.toUInt64()))!
  }
}

// Convert uint64 to pointers
public extension UInt64 {
  func toPointer<T>() -> UnsafeMutablePointer<T> {
    return UnsafeMutablePointer(bitPattern: UInt(self))!
  }

  func toOpaque() -> OpaquePointer? {
    return OpaquePointer(bitPattern: UInt(self))
  }
}

public extension Libadwaita.NativePeer {
  func toUnsafeMutablePointer<T>() -> UnsafeMutablePointer<T> {
    return self.nativePtr.toPointer()
  }

  func toOpaquePointer() -> OpaquePointer? {
    return self.nativePtr.toOpaque()
  }
}
