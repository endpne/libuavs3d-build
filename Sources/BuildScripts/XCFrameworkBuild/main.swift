import Foundation

do {
    let options = try ArgumentOptions.parse(CommandLine.arguments)
    try Build.performCommand(options)

    try BuildUavs3d().buildALL()
} catch {
    print("ERROR: \(error.localizedDescription)")
    exit(1)
}


enum Library: String, CaseIterable {
    case libuavs3d
    var version: String {
        switch self {
        case .libuavs3d:
            return "1.0"
        }
    }

    var url: String {
        switch self {
        case .libuavs3d:
            return "https://github.com/uavs3/uavs3d"
        }
    }

    // for generate Package.swift
    var targets : [PackageTarget] {
        switch self {
        case .libuavs3d:
            return  [
                .target(
                    name: "Libuavs3d",
                    url: "https://github.com/mpvkit/libuavs3d-build/releases/download/\(BaseBuild.options.releaseVersion)/Libuavs3d.xcframework.zip",
                    checksum: "https://github.com/mpvkit/libuavs3d-build/releases/download/\(BaseBuild.options.releaseVersion)/Libuavs3d.xcframework.checksum.txt"
                ),
            ]
        }
    }
}


private class BuildUavs3d: BaseBuild {
    init() {
        super.init(library: .libuavs3d)

        // force pull latest version from master/main branch
        self.pullLatestVersion = true
    }

    override func beforeBuild() throws {
        try super.beforeBuild()

        // generate version
        try Utility.launch(path: (directoryURL + "version.sh").path, arguments: [], currentDirectoryURL: directoryURL)
    }

    override func build(platform: PlatformType, arch: ArchType) throws {
        // maccatalyst暂时不支持
        if platform == .maccatalyst {
            return
        }

        try super.build(platform: platform, arch: arch)
    }

    override func arguments(platform : PlatformType, arch : ArchType) -> [String] {
        [
            "-DCOMPILE_10BIT=1",
        ]
    }
}

