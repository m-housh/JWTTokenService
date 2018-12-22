import XCTest

import JWTTokenServiceTests

var tests = [XCTestCaseEntry]()
tests += JWTTokenServiceTests.allTests()
XCTMain(tests)