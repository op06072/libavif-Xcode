// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "libavif",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "libavif",
            targets: ["libavif"]
        ),
        .library(name: "complianceWarden", targets: ["complianceWarden"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/op06072/libaom-Xcode.git", branch: "aomV3"),
        .package(url: "https://github.com/awxkee/libyuv.swift.git", "1.1.0"..<"1.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "complianceWarden",
            path: "ComplianceWarden",
            exclude: ["src/app/cw.cpp"],
            sources: ["src"],
            publicHeadersPath: "src",
            cSettings: [
                .headerSearchPath("src/utils"),
                .headerSearchPath("src/core"),
            ]
        ),
        .target(
            name: "libavif",
            dependencies: [
                .product(name: "libaom", package: "libaom-Xcode"),
                .product(name: "libyuv", package: "libyuv.swift"),
                "complianceWarden",
            ],
            path: "avif",
            exclude: ["src/codec_dav1d.c", "src/codec_rav1e.c", "src/codec_libgav1.c", "src/codec_svt.c"],
            sources: ["src"],
            publicHeadersPath: "include",
            cSettings: [
                .define("AVIF_CODEC_AOM", to: "1"),
                .define("AVIF_CODEC_AOM_DECODE", to: "1"),
                .define("AVIF_CODEC_AOM_ENCODE", to: "1"),
                .define("AVIF_LIBYUV_ENABLED", to: "1"),
                .define("AVIF_ENABLE_COMPLIANCE_WARDEN", to: "1"),
                .define("AVIF_ENABLE_EXPERIMENTAL_SAMPLE_TRANSFORM", to: "1"),
            ]
        ),
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)
