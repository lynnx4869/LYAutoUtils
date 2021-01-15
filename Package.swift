// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LYAutoUtils",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "LYAutoUtils",
                 targets: ["LYAutoUtils"])
    ],
    dependencies: [
        .package(url: "https://github.com/marmelroy/Zip.git", from: "2.1.1")
    ],
    targets: [
        .target(name: "LYAutoUtils",
                dependencies: ["Zip"],
                path: "Sources",
                resources: [
                    .process("LYAutoUtils.xcassets")
                ])
    ],
    swiftLanguageVersions: [.v5]
)
