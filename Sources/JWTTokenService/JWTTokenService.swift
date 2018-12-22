import Vapor
import JWT


public protocol JWTTokenService: ServiceType {
    
    /// Used to sign and verify tokens.
    var secret: LosslessDataConvertible { get }
    
    /// Sign a *JWTPayload*.
    /// - parameter payload: The *JWTPayload* to sign.
    func sign<Payload>(payload: Payload) throws -> String where Payload: JWTPayload
    
    /// Sign a *JWTPayload*.
    /// - parameter payload: The *JWTPayload* to sign.
    func verify<Payload>(token: String) throws -> JWT<Payload> where Payload: JWTPayload
}


extension JWTTokenService {
    
    /// Sign a *JWTPayload*.
    /// - parameter payload: The *JWTPayload* to sign.
    public func sign<Payload>(payload: Payload) throws -> String where Payload: JWTPayload {
        let data = try JWT(payload: payload)
            .sign(using: .hs256(key: secret))
        
        guard let token = String(data: data, encoding: .utf8) else {
            throw Abort(.internalServerError, reason: "Failed to encode JWTPayload")
        }
        return token
    }
    
    /// Verify a *JWTPayload*.
    /// - parameter token: The token strinng to verify.
    public func verify<Payload>(token: String) throws -> JWT<Payload> where Payload: JWTPayload {
        return try JWT<Payload>(from: token, verifiedUsing: .hs256(key: secret))
    }
}

extension JWTTokenService {
    
    /// - seealso: *ServiceType*
    public static var serviceSupports: [Any.Type] {
        return [JWTTokenService.self]
    }
}
