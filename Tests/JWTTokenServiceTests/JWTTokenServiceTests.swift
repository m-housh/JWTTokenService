import XCTest
import JWT

@testable import JWTTokenService


struct TestPayload: JWTPayload {
    
    let string: String

    /// - seealso: *JWTPayload*
    func verify(using signer: JWTSigner) throws {
        /// Nothing to verify
    }
    
}

final class JWTTokenServiceTests: VaporTestCase {
    
    func jwtTokenService() throws -> JWTTokenService {
        return try app.make(JWTTokenService.self)
    }
    
   
    static var allTests = [
        ("testExample", testExample),
        ("testSigningToken", testSigningToken),
        ("testVerifingToken", testVerifingToken),
        ("testVerifingTokenFails", testVerifingTokenFails),
    ]
}

/// MARK: Tests.
extension JWTTokenServiceTests {
    
    func testExample() {
        XCTAssert(true)
    }
    
    func testSigningToken() {
        perform {
            let signer = try jwtTokenService()
            let payload = TestPayload(string: "foo")
            let token = try signer.sign(payload: payload)
            let compare = String(data: try JWT(payload: payload).sign(using: .hs256(key: testSecret)), encoding: .utf8) ?? ""
            
            XCTAssertEqual(token, compare)
        }
    }
    
    func testVerifingToken() {
        perform {
            let signer = try jwtTokenService()
            let payload = TestPayload(string: "foo")
            let token = try signer.sign(payload: payload)
            let verified: JWT<TestPayload> = try signer.verify(token: token)
            XCTAssertEqual(verified.payload.string, "foo")
        }
    }
    
    func testVerifingTokenFails() {
        perform {
            let signer = try jwtTokenService()
            let payload = TestPayload(string: "foo")
            let token = String(data: try JWT(payload: payload).sign(using: .hs256(key: "bar")), encoding: .utf8) ?? ""
            do {
                let _ : JWT<TestPayload> = try signer.verify(token: token)
                XCTAssert(false)
            } catch {
                XCTAssertNotNil(error)
            }
        }
    }
}
