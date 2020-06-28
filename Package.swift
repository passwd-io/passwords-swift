// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "passwords-swift",
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
