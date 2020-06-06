// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "password-swift",
    products: [
        .library(
            name: "PasswordRules",
            targets: ["PasswordRules"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PasswordRules",
            dependencies: []),
        .testTarget(
            name: "PasswordRulesTests",
            dependencies: ["PasswordRules"]),
    ]
)
