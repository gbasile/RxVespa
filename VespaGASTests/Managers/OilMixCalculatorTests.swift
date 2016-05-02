import XCTest
@testable import VespaGAS

class OilMixCalculatorTests: XCTestCase {
    func testItReturnsNilWhenOilPercentageIsZero() {
        XCTAssertNil(OilMixCalculator.oilMLForGasoline(0, oilPercentage: 0))
    }

    func testItReturns0When0LitersOfGasoline() {
        XCTAssertEqual(0, OilMixCalculator.oilMLForGasoline(0, oilPercentage: 2))
    }

    func testItReturns80MLWhenLitersAre4AndOilPercentageIs2() {
        XCTAssertEqual(80, OilMixCalculator.oilMLForGasoline(4, oilPercentage: 2))
    }

    func testItReturns40MLWhenLitersAre4AndOilPercentageIs1() {
        XCTAssertEqual(40, OilMixCalculator.oilMLForGasoline(4, oilPercentage: 1))
    }

    func testItReturns60MLWhenLitersAre4AndOilPercentageIs15() {
        XCTAssertEqual(60, OilMixCalculator.oilMLForGasoline(4, oilPercentage: 1.5))
    }
}
