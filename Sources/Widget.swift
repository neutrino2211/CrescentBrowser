import Libadwaita

class WidgetWrapper : NativeWidgetPeer {
  public init(withPointer: UInt64) {
    super.init()

    self.nativePtr = withPointer
  }
}