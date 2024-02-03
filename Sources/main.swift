import Adwaita
import CGtk

@main
struct CrescentBrowser: App {

  let id = "io.github.neutrino2211.CrescentBrowser"
  var app: GTUIApp!

  @State private var count = 0

  var scene: Scene {
    Window(id: "main") { win in
      BrowserView(window: win, app: app)
    }
    .defaultSize(width: 1600, height: 900)
    // Add the shortcut "Ctrl + Alt + Q" for terminating the app
    .appKeyboardShortcut("q".ctrl().alt()) { app in
      print("Quit")
      app.quit()
    }.overlay {
      AboutWindow(id: "about", appName: "Crescent Browser", developer: "neutrino2211", version: "0.0.0")
        .icon(.default(icon: .webBrowser))
        .website(.init(string: "https://github.com/neutrino2211/crescent-browser"))
    }
  }

  struct BrowserView : View {
    @State private var url = "https://google.com"
    @State private var webviewProgress = 0.0
    @State("miniSidebar") private var miniSidebar = true
    @State("mainSidebar") private var mainSidebar = true
    @State("maximised") private var windowMaximised = false

    var window: GTUIApplicationWindow
    var app: GTUIApp!

    var view: Body {
      Box {
        HStack {
          SideBar() {
            menu
          }
            .widthRequest(50)
            .visible($miniSidebar)

          OverlaySplitView(visible: $mainSidebar) {
            SideBar() {
              Text(.init(format: "%f", $webviewProgress.wrappedValue))
            }
            .topToolbar {
              HeaderBar.end {
                menu
              }.titleWidget {
                URLEntry(placeholder: "URL")
                  .url(url: $url)
                  .hexpand(true)
              }.start {
                Button(icon: .default(icon: .goPrevious)) {}
                  .onClick {
                    $url.wrappedValue = "https://startpage.com"
                  }
                
                Button(icon: .default(icon: .goNext)) {}
                  .onClick {
                    $url.wrappedValue = "https://google.com"
                  }
              }
            }
          } content: {
            WebView(url: url)
              .hexpand(true)
              .vexpand(true)
          }
        }
      }.onAppear {
        if windowMaximised {
          CGtk.gtk_window_maximize(window.pointer?.cast())
        } else {
          CGtk.gtk_window_unmaximize(window.pointer?.cast())
        }
      }
    }

    var menu: View {
        Menu(icon: .default(icon: .openMenu), app: app, window: window) {
            MenuButton("New Window", window: false) {
                app.addWindow("main")
            }
            .keyboardShortcut("n".ctrl())
            MenuButton("Close Window") {
                window.close()
            }
            .keyboardShortcut("w".ctrl())
            MenuButton("Toggle Sidebar") {
              miniSidebar.toggle()
              mainSidebar.toggle()
            }.keyboardShortcut("s".ctrl())
            MenuSection {
                MenuButton("About") { app.addWindow("about", parent: window) }
                MenuButton("Quit", window: false) { window.close() }
                    .keyboardShortcut("q".ctrl())
            }
        }
        .primary()
    }
  }
  
}
