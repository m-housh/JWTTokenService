// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JWTTokenService",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "JWTTokenService",
            targets: ["JWTTokenService"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        
        // 🔏 JSON Web Token signing and verification (HMAC, RSA).
        .package(url: "https://github.com/vapor/jwt.git", from: "3.0.0"),
        
        // VaporTestable
        .package(url: "https://github.com/m-housh/vapor-testable.git", from:
            "0.1.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "JWTTokenService",
            dependencies: ["Vapor", "JWT"]),
        .testTarget(
            name: "JWTTokenServiceTests",
            dependencies: ["JWTTokenService", "VaporTestable"]),
    ]
)
