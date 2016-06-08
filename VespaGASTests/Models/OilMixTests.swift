import XCTest
@testable import VespaGAS

class OilMixTests: XCTestCase {
    func testItReturnsNoOilWhenNoGasoline() {
        let gasoline = Gasoline(amount: 0, unit: .Liter)
        let oilMix = OilMix(amount: 2)
        let expectedOil = Oil(amount: 0, unit: .Liter)

        XCTAssertEqual(expectedOil, oilMix.oilForGasoline(gasoline))
    }

    func testItReturnsNoOilWhenOilMixIsZero() {
        let gasoline = Gasoline(amount: 3, unit: .Liter)
        let oilMix = OilMix(amount: 0)
        let expectedOil = Oil(amount: 0, unit: .Liter)

        XCTAssertEqual(expectedOil, oilMix.oilForGasoline(gasoline))
    }

    func testItReturnsCorrectOilFor4LiterOfGasolineAnd2PercentageMix() {
        let gasoline = Gasoline(amount: 4, unit: .Liter)
        let oilMix = OilMix(amount: 2)
        let expectedOil = Oil(amount: 0.08, unit: .Liter)

        XCTAssertEqual(expectedOil, oilMix.oilForGasoline(gasoline))

    }

    func testItReturnsCorrectOilFor4LiterOfGasolineAnd1PercentageMix() {
        let gasoline = Gasoline(amount: 4, unit: .Liter)
        let oilMix = OilMix(amount: 1)
        let expectedOil = Oil(amount: 0.04, unit: .Liter)

        XCTAssertEqual(expectedOil, oilMix.oilForGasoline(gasoline))

    }

    func testItReturnsCorrectOilFor4LiterOfGasolineAnd1Point5PercentageMix() {
        let gasoline = Gasoline(amount: 4, unit: .Liter)
        let oilMix = OilMix(amount: 1.5)
        let expectedOil = Oil(amount: 0.06, unit: .Liter)

        XCTAssertEqual(expectedOil, oilMix.oilForGasoline(gasoline))

    }
}
