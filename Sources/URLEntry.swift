import Adwaita
import CGtk
import CAdw
import Foundation

struct URLEntry : Widget {
  private var input: UnsafeMutablePointer<GtkWidget>

  var url: Binding<String>?
  var placeholder: String

  public init(placeholder: String) {
    input = gtk_entry_new()!
    self.placeholder = placeholder

    gtk_entry_set_placeholder_text(input.cast(), placeholder)
  }

  func container(modifiers: [(View) -> View]) -> ViewStorage {
    let storage = ViewStorage(input.toOpaque())
    update(storage, modifiers: modifiers)

    return storage
  }

  func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
  
  }

  public func url(url: Binding<String>) -> Self {
    var newSelf = self
    newSelf.url = url

    return newSelf
  }
}