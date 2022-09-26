// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomNavigationBar",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "CustomNavigationBar",
            targets: ["CustomNavigationBar"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CustomNavigationBar",
            dependencies: []
        ),
        .testTarget(
            name: "CustomNavigationBarTests",
            dependencies: ["CustomNavigationBar"]
        ),
    ]
)
