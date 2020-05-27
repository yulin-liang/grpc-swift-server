// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "grpc-swift-server",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.0.0-alpha.10"),
        // Official SwiftProtobuf library, for [de]serializing data to send on the wire.
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        // Model for the HelloWorld example
//        .target(
//          name: "HelloWorldModel",
//          dependencies: [
//              "SwiftProtobuf",
//              .product(name: "GRPC", package: "grpc-swift")
//          ],
//          path: "Sources/HelloWorldModel"
//        ),
        .target(
            name: "grpc-swift-server",
            dependencies: [
                "SwiftProtobuf",
                "HelloWorldModel",
                .product(name: "GRPC", package: "grpc-swift"),
            ]
        ),
        .testTarget(
            name: "grpc-swift-serverTests",
            dependencies: ["grpc-swift-server"]),
    ]
)
