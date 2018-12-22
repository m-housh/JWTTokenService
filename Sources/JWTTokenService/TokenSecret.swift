//
//  TokenSecret.swift
//  JWTTokenService
//
//  Created by Michael Housh on 12/22/18.
//

import Vapor


public protocol TokenSecret: ServiceType {
    var secret: LosslessDataConvertible { get }
}

extension TokenSecret {
    
    public static var serviceSupports: [Any.Type] {
        return [TokenSecret.self]
    }
}


public final class EnvironmentTokenSecret {
    
    public let secret: LosslessDataConvertible
    public static let envKey = "JWT_TOKEN_SECRET"
    
    public init(secret: LosslessDataConvertible) {
        self.secret = secret
    }
}

extension EnvironmentTokenSecret: ServiceType {
    
    /// - seealso: *ServiceType*
    public static func makeService(for worker: Container) throws -> EnvironmentTokenSecret {
        guard let secret = Environment.get(EnvironmentTokenSecret.envKey) else {
            let reason = "Did not find \(envKey) in the environment."
            throw Abort(.internalServerError, reason: reason)
        }
        
        return EnvironmentTokenSecret(secret: secret)
    }
}

extension EnvironmentTokenSecret: TokenSecret { }
