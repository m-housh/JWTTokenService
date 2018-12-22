//
//  VaporTestCase.swift
//  JWTTokenServiceTests
//
//  Created by Michael Housh on 12/22/18.
//

import Vapor
import XCTest
import VaporTestable
import JWTTokenService


class VaporTestCase: XCTestCase, VaporTestable {
    
    var app: Application!
    var testSecret: String {
        return Environment.get(EnvironmentTokenSecret.envKey)!
    }
    
    override func setUp() {
        perform {
            self.app = try makeApplication()
        }
    }
    
    /// - seealso: *VaporTestable*
    func services() throws -> Services {
        var services = Services.default()
        //services.register(EnvironmentTokenSecret.self)
        //services.register(HS256TokenService.self)
        try services.register(JWTTokenProvider())
        return services
    }
}
