// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ApolloPublishers",
    platforms: [ .iOS(SupportedPlatform.IOSVersion.v13), .macOS(.v10_14) ],
    products: [
        .library(
            name: "ApolloPublishers",
            targets: ["ApolloPublishers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios.git", from: Version("0.49.0"))
    ],
    targets: [
        .target(
            name: "ApolloPublishers",
            dependencies: [ "Apollo" ]),
    ]
)
