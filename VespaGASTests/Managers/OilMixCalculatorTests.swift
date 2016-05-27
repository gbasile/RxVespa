import XCTest
@testable import VespaGAS

class OilMixCalculatorTests: XCTestCase {
    func testItReturnsNoOilWhenNoGasoline() {
        let gasoline = Gasoline(amount: 0, unit: .Liter)
        let expectedOil = Oil(amount: 0, unit: .Liter)

        XCTAssertEqual(expectedOil, OilMixCalculator.oilFor(gasoline, oilMix: OilMix(amount: 2)))
    }

    func testItReturnsNoOilWhenOilMixIsZero() {
        let gasoline = Gasoline(amount: 3, unit: .Liter)
        let expectedOil = Oil(amount: 0, unit: .Liter)

        XCTAssertEqual(expectedOil, OilMixCalculator.oilFor(gasoline, oilMix: OilMix(amount: 0)))
    }

    func testItReturnsCorrectOilFor4LiterOfGasolineAnd2PercentageMix() {
        let gasoline = Gasoline(amount: 4, unit: .Liter)
        let expectedOil = Oil(amount: 0.08, unit: .Liter)

        XCTAssertEqual(expectedOil, OilMixCalculator.oilFor(gasoline, oilMix: OilMix(amount: 2)))

    }

    func testItReturnsCorrectOilFor4LiterOfGasolineAnd1PercentageMix() {
        let gasoline = Gasoline(amount: 4, unit: .Liter)
        let expectedOil = Oil(amount: 0.04, unit: .Liter)

        XCTAssertEqual(expectedOil, OilMixCalculator.oilFor(gasoline, oilMix: OilMix(amount: 1)))

    }

    func testItReturnsCorrectOilFor4LiterOfGasolineAnd1Point5PercentageMix() {
        let gasoline = Gasoline(amount: 4, unit: .Liter)
        let expectedOil = Oil(amount: 0.06, unit: .Liter)

        XCTAssertEqual(expectedOil, OilMixCalculator.oilFor(gasoline, oilMix: OilMix(amount: 1.5)))

    }
}
