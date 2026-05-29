// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SwiftTabPager",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "SwiftTabPager",
            targets: ["SwiftTabPager"]
        )
    ],
    targets: [
        .target(
            name: "SwiftTabPager",
            path: "Source",
            exclude: ["Info.plist"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
