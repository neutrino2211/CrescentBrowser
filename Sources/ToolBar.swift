import Libadwaita
import Gtk
import GLibObject
import CGtk



class ToolBar : Libadwaita.NativeWidgetPeer {
  private let tabs: [Tab] = []
  private var closeWindowHandler: (() -> Void)? = nil
  private var toggleSideBarHandler: (() -> Void)? = nil

  private let box = Gtk.Box(orientation: .vertical, spacing: 10)

  override init() {
    super.init()

    box.setPropertyValues([
      "width-request": Value(30),
      "margin-top": Value(5),
      "margin-bottom": Value(5),
      "margin-start": Value(5),
      "margin-end": Value(5),
    ])

    box.setHexpand(expand: false)

    let closeButton = CrescentButton(icon: .custom(name: "window-close-symbolic")) { (btn) -> Void in
      print("Close")

      if (self.closeWindowHandler != nil) {
        self.closeWindowHandler!()
      }
    }

    let sideBarToggle = CrescentButton(icon: .custom(name: "sidebar-show-symbolic")) { (btn) -> Void in
      print("SideBar")

      if (self.toggleSideBarHandler != nil) {
        self.toggleSideBarHandler!()
      }
    }

    CGtk.gtk_box_append(box.toPointer() as UnsafeMutablePointer<GtkBox>, closeButton.toPointer())
    CGtk.gtk_box_append(box.toPointer() as UnsafeMutablePointer<GtkBox>, sideBarToggle.toPointer())

    self.nativePtr = box.widget_ptr.toUInt64()
  }

  public func closeWindowClick(handler: @escaping () -> Void) {
    self.closeWindowHandler = handler
  }

  public func toggleSideBarClick(handler: @escaping () -> Void) {
    self.toggleSideBarHandler = handler
  }
}