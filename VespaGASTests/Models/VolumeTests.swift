import XCTest
@testable import VespaGAS

struct MockedVolume: Volume {
    var amount: Float
    var unit: VolumeUnit
}

class VolumeTests: XCTestCase {
    func testItConverts3LitersIn3000Milliliters() {
        let volume = MockedVolume(amount: 3, unit: .Liter)

        XCTAssertEqual(3000, volume.amountInUnit(.Milliliter))
    }

    func testItConverts3000MillilitersIn3Liters() {
        let volume = MockedVolume(amount: 3000, unit: .Milliliter)

        XCTAssertEqual(3, volume.amountInUnit(.Liter))
    }

    func testDescriptionFor4LitersIsCorrect() {
        let volume = MockedVolume(amount: 4, unit: .Liter)

        XCTAssertEqual("4L", volume.description)
    }

    func testDescriptionFor400MillilitersIsCorrect() {
        let volume = MockedVolume(amount: 400, unit: .Milliliter)

        XCTAssertEqual("400ML", volume.description)
    }


    func testItConvert4LitersIntoNewGasolineInMilliliters() {
        let volume = MockedVolume(amount: 4, unit: .Liter)
        let newGasoline = volume.toUnit(.Milliliter)

        let expectedGasoline = MockedVolume(amount: 4000, unit: .Milliliter)

        XCTAssertEqual(expectedGasoline, newGasoline)
    }

    func testItConvert450MilliliterIntoNewGasolineInLiter() {
        let volume = MockedVolume(amount: 450, unit: .Milliliter)
        let newGasoline = volume.toUnit(.Liter)

        let expectedGasoline = MockedVolume(amount: 0.45, unit: .Liter)

        XCTAssertEqual(expectedGasoline, newGasoline)
    }

    func testItRoundTheAmountFor4Point4Liter() {
        let volume = MockedVolume(amount: 4.4, unit: .Liter)
        let expectedGasoline = MockedVolume(amount: 4, unit: .Liter)

        XCTAssertEqual(expectedGasoline, volume.roundAmount())
    }
}
