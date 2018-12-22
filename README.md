# JWTTokenService

[![Build Status](https://travis-ci.org/m-housh/JWTTokenService.svg?branch=master)](https://travis-ci.org/m-housh/JWTTokenService)
[![codecov](https://codecov.io/gh/m-housh/JWTTokenService/branch/master/graph/badge.svg)](https://codecov.io/gh/m-housh/JWTTokenService)


A Vapor provider for JWT token signing and verifying. Uses the Vapor service
mechanism to allow easy signing and verifying tokens throughout the app, and
allows flexibility for implementing different signing strategies for development
vs. production.


## Usage
-----

### Package.swift

``` swift

// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    ...
    dependencies: [
        ...
        .package(url: "https://github.com/m-housh/JWTTokenService.git", from:
        "0.1.1"),
    ],
    targets: [
        ...
    ]
)

```

Register the provider in your vapor configuration.

``` swift

///  This is all that's required if you want to use the `hs256` signing
///  algorithm, and parse the signing secret from the environment
///  at `JWT_TOKEN_SECRET`.
services.register(JWTTokenServiceProvider())

```


By default the signing secret is looked up in the environment, using the value
found in `JWT_TOKEN_SECRET`.  You can register your own secret storage
container, by creating an object that conforms to `TokenSecret`.

``` swift

final class MyJWTSecret: TokenSecret {
    let secret: LosslessDataConvertible = "super-secret"
}

```

Then in your configuration.

``` swift

config.prefer(MyJWTSecret.self, for: TokenSecret.self)

```

### Signing a token.

Create a `JWTPayload`.

``` swift

struct UserJWT: JWTPayload {

    /// The user's email.
    let email: String

    /// - seealso: *JWTPayload*
    func verify(using signer: JWTSigner) throws {
        /// Nothing to verify
    }
}
```

In a route or container sign and return a token string.

``` swift

router.post("login") { req -> String in

    let user = try req.requireAuthenticated(User.self)
    let signer = try req.make(JWTTokenService.self)
    let payload = UserJWT(email: user.email)
    return try signer.sign(payload: payload)
}

```

### Verify a token.

In a route or container.

```
router.get("verifyToken", String.parameter) { req -> HTTPResponseStatus in
    let token = try req.parameters.next(String.self)
    let verifier = try req.make(JWTTokenService.self)
    let jwt: JWT<UserJWT> = try verifier.verify(token: token)
    // do something with the verified token.
    return .ok
}
```
    

