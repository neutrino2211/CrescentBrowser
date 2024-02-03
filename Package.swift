// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "crescent-swift",
    dependencies: [
        .package(url: "https://github.com/AparokshaUI/Adwaita", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .systemLibrary(name: "WebKitGtk", path: "Sources/WebKitGtk", pkgConfig: "webkitgtk-6.0"),
        .systemLibrary(name: "CAdwaita", path: "Sources/CAdwaita", pkgConfig: "libadwaita-1"),
        .systemLibrary(name: "CGtk", path: "Sources/CGtk", pkgConfig: "gtk-4.0"),
        .executableTarget(
            name: "crescent-swift",
            dependencies: [
                "Adwaita",
                "WebKitGtk",
                "CGtk",
                .product(name: "CAdw", package: "Adwaita")
            ],
            path: "Sources",
            swiftSettings: [
                .unsafeFlags(["-parse-as-library"])
            ]
        ),   
    ]
)
