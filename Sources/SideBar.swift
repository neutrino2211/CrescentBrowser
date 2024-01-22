// swiftlint:disable no_magic_numbers type_body_length missing_docs function_body_length closure_body_length

import Libadwaita
import Gtk
import CGtk
import GLibObject
import CAdwaita

// func SideBar() -> Gtk.Widget {
//   let container = Gtk.Box.new(type: CGtk.gtk_box_get_type())
//   let sideBar = Gtk.Box.new(type: CGtk.gtk_box_get_type())
//   let gtkContainer = Gtk.Box(gpointer: container)!
//   let sideBarContainer = Gtk.Box(gpointer: sideBar)!

//   sideBarContainer.set(orientation: .vertical)
//   sideBarContainer.set(spacing: 5)

//   gtkContainer.setProperty(propertyName: "height-request", value: Value(10))
//   gtkContainer.setProperty(propertyName: "margin-end", value: Value(1))

//   let _headerBar = Gtk.HeaderBar.new(type: CGtk.gtk_header_bar_get_type())
//   let headerBar = Gtk.HeaderBar(gpointer: _headerBar)!


//   gtkContainer.append(child: headerBar)
//   sideBarContainer.append(child: gtkContainer)
//   return sideBarContainer
// }

class SideBar : Libadwaita.NativeWidgetPeer {
  private let container = Gtk.Box(orientation: .vertical, spacing: 0)
  private let headerBar = Libadwaita.HeaderBar().valign(.center).hexpand(true)
  private let urlBar = Gtk.Entry()

  private let backBtn = CrescentButton(icon: .custom(name: "go-previous-symbolic")) { (btn: Gtk.ButtonRef) -> Void in
    print("Back")
  }

  private let forwardBtn = CrescentButton(icon: .custom(name: "go-next-symbolic")) { (btn: Gtk.ButtonRef) -> Void in
    print("Forward")
  }

  override init() {
    super.init()
    let root = CGtk.gtk_box_new(CGtk.GTK_ORIENTATION_VERTICAL, 0)!

    container.setProperty(propertyName: "height-request", value: GLibObject.Value(10))
    container.setProperty(propertyName: "margin-end", value: GLibObject.Value(1))

    urlBar.setPlaceholder(text: "Enter url")
    urlBar.setHexpand(expand: true)

    CAdwaita.adw_header_bar_set_show_title(headerBar.nativePtr.toOpaque(), 0)
    CAdwaita.adw_header_bar_pack_start(headerBar.nativePtr.toOpaque(), urlBar.ptr.toUInt64().toPointer())
    CAdwaita.adw_header_bar_pack_start(headerBar.nativePtr.toOpaque(), backBtn.ptr.toUInt64().toPointer())
    CAdwaita.adw_header_bar_pack_start(headerBar.nativePtr.toOpaque(), forwardBtn.ptr.toUInt64().toPointer())

    self.nativePtr = root.toUInt64()

    CGtk.gtk_box_append(self.nativePtr.toPointer() as UnsafeMutablePointer<CGtk.GtkBox>, container.ptr!.toUInt64().toPointer())
    CGtk.gtk_box_append(container.ptr!.toUInt64().toPointer() as UnsafeMutablePointer<GtkBox>, headerBar.nativePtr.toPointer())
  }
}
