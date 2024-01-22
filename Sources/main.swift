//
//  main.swift
//  Libadwaita
//
//  Created by david-swift on 26.11.23.
//

// swiftlint:disable no_magic_numbers type_body_length missing_docs function_body_length closure_body_length

import Libadwaita
import WebKitGtk
import Gtk

@main
public enum SwiftGui {
  public static func main() {
    let application = MyApplication()
    application.run()
  }
}

public class MyApplication: Libadwaita.Application {

  public init() { super.init(name: "io.github.neutrino2211.crescent_browser") }

  func mainWindow() -> Libadwaita.Window {
    let win = ApplicationWindow(app: self)
    let wk = WebView().loadUri(url: "https://google.com").vexpand(true).hexpand(true)
    let sideBar = SideBar()
    let splitView = OverlaySplitView().content(wk).sidebar(sideBar)

    win.setDefaultSize(width: 1500, height: 800)
    win.setChild(splitView)
    return win
  }

  override public func onActivate() {
    let win = self.mainWindow()
    win.show()
  }
}

// swiftlint:enable no_magic_numbers type_body_length missing_docs function_body_length closure_body_length