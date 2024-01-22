// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "crescent-swift",
    dependencies: [
        .package(url: "https://github.com/david-swift/Libadwaita", from: "0.1.0"),
        .package(url: "https://github.com/rhx/gir2swift.git", branch: "main"),
        .package(url: "https://github.com/rhx/SwiftGtk.git",  branch: "gtk4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .systemLibrary(name: "WebKitGtk", path: "Sources/WebKitGtk", pkgConfig: "webkitgtk-6.0"),
        .systemLibrary(name: "CAdwaita", path: "Sources/CAdwaita", pkgConfig: "libadwaita-1"),
        .executableTarget(
            name: "crescent-swift",
            dependencies: [
                "Libadwaita",
                "WebKitGtk",
                "CAdwaita",
                .product(name: "Gtk", package: "SwiftGtk"),
            ],
            path: "Sources",
            swiftSettings: [
                .unsafeFlags(["-parse-as-library"])
            ]
        ),   
    ]
)
