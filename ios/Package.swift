// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "face_anti_spoofing_detector",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "face-anti-spoofing-detector", targets: ["face_anti_spoofing_detector"])
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "ncnn",
            path: "ncnn.xcframework"
        ),
        .binaryTarget(
            name: "openmp",
            path: "openmp.xcframework"
        ),
        .target(
            name: "face_anti_spoofing_detector",
            dependencies: ["ncnn", "openmp"],
            path: "Classes",
            resources: [
                .process("../Assets")
            ],
            cxxSettings: [
                // HAS_NCNN is now handled in LivenessDetector.mm via __has_include
            ]
        )
    ]
)
