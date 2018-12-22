//
//  JWTTokenProvider.swift
//  JWTTokenService
//
//  Created by Michael Housh on 12/22/18.
//

import Vapor


public final class JWTTokenProvider: Provider {
    
    public init() { }
    
    public func register(_ services: inout Services) throws {
        services.register(EnvironmentTokenSecret.self)
        services.register(HS256TokenService.self)
    }
    
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        /// Nothing to do here.
        return .done(on: container)
    }
    
    
}
