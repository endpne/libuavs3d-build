// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "libuavs3d",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13)],
    products: [
        .library(name: "Libuavs3d", targets: ["_Libuavs3d"]),
    ],
    targets: [
        // Need a dummy target to embedded correctly.
        // https://github.com/apple/swift-package-manager/issues/6069
        .target(
            name: "_Libuavs3d",
            dependencies: ["Libuavs3d"],
            path: "Sources/_Dummy"
        ),
        //AUTO_GENERATE_TARGETS_BEGIN//

        .binaryTarget(
            name: "Libuavs3d",
            url: "https://github.com/mpvkit/libuavs3d-build/releases/download/1.2.1/Libuavs3d.xcframework.zip",
            checksum: "5b5ed6c222cf781b86c62a60f6ea3f5ba041ea286f7aca06d389098f037b820f"
        ),
        //AUTO_GENERATE_TARGETS_END//
    ]
)