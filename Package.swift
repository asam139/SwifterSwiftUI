// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SwifterSwiftUI",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6),
    ],
    products: [
        .library(
            name: "SwifterSwiftUI",
            targets: ["SwifterSwiftUI"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwifterSwiftUI",
            dependencies: []
        ),
        .testTarget(
            name: "SwifterSwiftUITests",
            dependencies: ["SwifterSwiftUI"]
        )
    ]
)
