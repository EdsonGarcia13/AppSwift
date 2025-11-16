// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AppSwift",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .iOSApplication(
            name: "AppSwift",
            targets: ["App"],
            bundleIdentifier: "com.example.AppSwift",
            teamIdentifier: "TEAMID",
            displayVersion: "1.0",
            bundleVersion: "1",
            iconAssetName: "AppIcon",
            accentColorAssetName: "AccentColor",
            supportedDeviceFamilies: [
                .phone,
                .pad
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeLeft,
                .landscapeRight
            ],
            infoPlist: .file("Sources/App/Info.plist")
        )
    ],
    targets: [
        .executableTarget(
            name: "App",
            path: "Sources/App",
            resources: [
                .process("Resources"),
                .process("Preview Content")
            ]
        )
    ]
)
