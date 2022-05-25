// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "BazelXCBBuildService",
    platforms: [.macOS(.v11)],
    products: [
        .executable(name: "BazelXCBBuildService", targets: ["BazelXCBBuildService"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.17.0"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.9.0"),
        // XCBBuildServiceProxyKit lives up two levels from here
        .package(path: "../../"),
    ],
    targets: [
        .target(
            name: "BazelXCBBuildService",
            dependencies: [
                "BazelXCBBuildService_BEP_build_event_stream_proto",
                .product(name: "Logging", package: "swift-log"),
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "XCBBuildServiceProxyKit", package: "XCBBuildServiceProxyKit"),
                .product(name: "XCBProtocol", package: "XCBBuildServiceProxyKit"),
                .product(name: "XCBProtocol_12_0", package: "XCBBuildServiceProxyKit"),
            ],
            path: "Sources"
        ),
        .target(
            name: "BazelXCBBuildService_BEP_build_event_stream_proto",
            dependencies: [
                "src_main_protobuf_command_line_proto",
                "src_main_protobuf_failure_details_proto",
                "src_main_protobuf_invocation_policy_proto",
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            path: "BEP/src/main/java/com/google/devtools/build/lib/buildeventstream/proto",
            sources: ["build_event_stream.pb.swift"]
        ),
        .target(
            name: "src_main_protobuf_command_line_proto",
            dependencies: [
                "src_main_protobuf_option_filters_proto",
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            path: "BEP/src/main/protobuf",
            exclude: [
                "option_filters.pb.swift",
                "failure_details.pb.swift",
                "invocation_policy.pb.swift",
            ],
            sources: ["command_line.pb.swift"]
        ),
        .target(
            name: "src_main_protobuf_option_filters_proto",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            path: "BEP/src/main/protobuf",
            exclude: [
                "command_line.pb.swift",
                "failure_details.pb.swift",
                "invocation_policy.pb.swift",
            ],
            sources: ["option_filters.pb.swift"]
        ),
        .target(
            name: "src_main_protobuf_failure_details_proto",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            path: "BEP/src/main/protobuf",
            exclude: [
                "command_line.pb.swift",
                "option_filters.pb.swift",
                "invocation_policy.pb.swift",
            ],
            sources: ["failure_details.pb.swift"]
        ),
        .target(
            name: "src_main_protobuf_invocation_policy_proto",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            path: "BEP/src/main/protobuf",
            exclude: [
                "command_line.pb.swift",
                "option_filters.pb.swift",
                "failure_details.pb.swift",
            ],
            sources: ["invocation_policy.pb.swift"]
        ),
    ]
)
