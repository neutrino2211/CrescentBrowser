/// GTK4 WebView

import Libadwaita
import WebKitGtk

public class WebView : NativeWidgetPeer {

  override init() {
    super.init()

    let pointer =  webkit_web_view_new()!

    super.nativePtr = pointer.toUInt64()
  }

  public func loadUri(url: String) -> WebView {
    webkit_web_view_load_uri(self.nativePtr.toPointer() as UnsafeMutablePointer<WebKitGtk._WebKitWebView>, url)

    return self
  }
}