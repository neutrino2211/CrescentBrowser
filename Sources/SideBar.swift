import Adwaita
import CAdw
import CGtk

struct SideBar : Adwaita.Widget {
  private var box: UnsafeMutablePointer<GtkWidget>
  private var childrenRendered = false

  var widthRequest: Int?
  var marginEnd: Int?
  var visible: Adwaita.Binding<Bool>?

  var child: (() -> Body)?

  public init(@ViewBuilder content: @escaping () -> Body) {
    box = gtk_box_new(GtkOrientation.init(1), 10)!
    self = self.child(content)
  }

  public func container(modifiers: [(View) -> View]) -> ViewStorage {
    
    let storage = ViewStorage(box.toOpaque())
    storage.fields["childrenRendered"] = childrenRendered
    update(storage, modifiers: modifiers)

    storage.notify(name: "visible") {
      print("Sidebar visibility changed:", storage.pointer!)
      visible?.wrappedValue = gtk_widget_get_visible(storage.pointer?.cast()) != 0
    }

    // gtkBox.setProperty(propertyName: "width-request", value: Value(10))
    // gtkBox.setProperty(propertyName: "margin-end", value: Value(1))
    // g_object_set_property(gtkBox.object_ptr, "height-request", Value(10).value_ptr)
    // g_object_set_property(box.cast(), "margin-end", Value(1).mutableDataPointer())
    return storage
  }

  public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
    storage.modify { widget in
      if let widthRequest {
        var widthValue = GValue.init()

        CGtk.g_value_init(&widthValue, 6 << 2)
        CGtk.g_value_set_int(&widthValue, Int32(widthRequest))

        print("width", widthRequest, widget!, widthValue)
        g_object_set_property(widget?.cast(), "width-request", &widthValue)
      }

      if let marginEnd {
        var value = GValue.init()

        CGtk.g_value_set_gtype(&value, 6 << 2)
        CGtk.g_value_set_int(&value, Int32(marginEnd))

        print("margin", marginEnd, widget!, value)
        g_object_set_property(widget?.cast(), "margin-end", &value)
      }

      if let visible {
        print("Modify visible", visible.wrappedValue)
        gtk_widget_set_visible(widget?.cast(), visible.wrappedValue.cBool)
      }

      if let child {
        if storage.fields["childrenRendered"] as! Bool {return}

        let childStorage = child().storage(modifiers: modifiers)
        gtk_box_append(widget?.cast(), childStorage.pointer?.cast())

        storage.fields["childrenRendered"] = true
      }
    }
  }

  public func widthRequest(_ width: Int) -> Self {
    var newSelf = self
    newSelf.widthRequest = width

    return newSelf
  }

  public func marginEnd(_ margin: Int) -> Self {
    var newSelf = self
    newSelf.marginEnd = margin

    return newSelf
  }

  public func visible(_ visible: Adwaita.Binding<Bool>) -> Self {
    var newSelf = self
    newSelf.visible = visible

    return newSelf
  }

  public func child(@ViewBuilder _ body: @escaping () -> Body) -> Self {
    var newSelf = self
    newSelf.child = body

    return newSelf
  }
}
