import Libadwaita
import Gtk
import CGtk

func CrescentButton(icon: Libadwaita.Icon, onClicked: @escaping (Gtk.ButtonRef)->Void) -> Gtk.Button {
  let btn = Gtk.Button()
  let image = Gtk.Image()

  btn.setHexpand(expand: true)
  image.set(iconSize: .normal)
  
  CGtk.gtk_image_set_from_icon_name(image.ptr.toUInt64().toPointer(), icon.string)
  CGtk.gtk_button_set_child(btn.ptr.toUInt64().toPointer(), image.ptr.toUInt64().toPointer())

  btn.onClicked(handler: onClicked)

  return btn
}