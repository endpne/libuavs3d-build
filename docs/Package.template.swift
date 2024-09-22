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
        //AUTO_GENERATE_TARGETS_END//
    ]
)