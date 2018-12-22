//
//  HS256TokenService.swift
//  JWTTokenService
//
//  Created by Michael Housh on 12/22/18.
//

import Vapor



public final class HS256TokenService {
    
    /// - seealso: *JWTTokenService*
    public let secret: LosslessDataConvertible
    
    public init(secret: LosslessDataConvertible) {
        self.secret = secret
    }
}

extension HS256TokenService: ServiceType {
    
    /// - seealso: *ServiceType*
    public static func makeService(for worker: Container) throws -> HS256TokenService {
        let appKey = try worker.make(TokenSecret.self)
        return HS256TokenService(secret: appKey.secret)
    }
}

extension HS256TokenService: JWTTokenService { }

