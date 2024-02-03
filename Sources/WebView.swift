import WebKitGtk
import Adwaita
import CGtk

struct WebView : Widget {

  static var urlField: String { "url" }

  private var url: String?

  private var canGoForward: Binding<Bool>
  private var canGoBackward: Binding<Bool>

  private let webview = webkit_web_view_new()!
  private let progresBar = gtk_progress_bar_new()!
  private let box = gtk_box_new(GtkOrientation.init(1), 0)!

  public init (url: String, canGoForward: Binding<Bool> = .constant(true), canGoBackward: Binding<Bool> = .constant(true)) {
    self.canGoBackward = canGoBackward
    self.canGoForward = canGoForward
    self.url = url
  }

  public func container(modifiers: [(View) -> View]) -> ViewStorage {
    gtk_box_append(box.cast(), progresBar.cast())
    gtk_box_append(box.cast(), webview.cast())

    gtk_widget_set_visible(progresBar.cast(), 0)

    gtk_widget_set_hexpand(webview.cast(), 1)
    gtk_widget_set_vexpand(webview.cast(), 1)

    let storage = ViewStorage(box.opaque())

    let webviewStorage = ViewStorage(webview.opaque())

    webviewStorage.fields[Self.urlField] = url

    webviewStorage.notify(name: "uri") {
      print("uri update")
      webviewStorage.fields[Self.urlField] = String.init(cString: webkit_web_view_get_uri(webview.cast()))
    }

    webviewStorage.notify(name: "estimated-load-progress") {
      let currentProgress = webkit_web_view_get_estimated_load_progress(webview.cast())

      if currentProgress != 0.0 && currentProgress != 1.0 {
        gtk_widget_set_visible(progresBar.cast(), 1)
        gtk_progress_bar_set_fraction(progresBar.opaque(), currentProgress)
      } else {
        gtk_widget_set_visible(progresBar.cast(), 0)
      }
      print("Progress:", currentProgress)
    }

    print("init:", url, webview.opaque())

    if let url {
      webkit_web_view_load_uri(webview.cast(), url)
    }

    let webviewPtr: UnsafeMutablePointer<WebKitWebView> = webview.cast()

    storage.fields["webview_ptr"] = webviewPtr

    return storage
  }

  public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
    storage.modify { widget in
      print("update:", url)

      if let url {
        let ptr = storage.fields["webview_ptr"] as! UnsafeMutablePointer<WebKitWebView>?
        
        if let ptr {
          webkit_web_view_load_uri(ptr, url)
          print("url:", url, ptr)
        }
      }
    }
  }
}