import XCTest
@testable import VespaGAS

class VolumeTests: XCTestCase {
    func testItConverts3LitersIn3000Milliliters() {
        let volume = Volume(amount: 3, unit: .Liter)

        XCTAssertEqual(3000, volume.amountInUnit(.Milliliter))
    }

    func testItConverts3000MillilitersIn3Liters() {
        let volume = Volume(amount: 3000, unit: .Milliliter)

        XCTAssertEqual(3, volume.amountInUnit(.Liter))
    }

    func testDescriptionFor4LitersIsCorrect() {
        let volume = Volume(amount: 4, unit: .Liter)

        XCTAssertEqual("4L", volume.description)
    }

    func testDescriptionFor400MillilitersIsCorrect() {
        let volume = Volume(amount: 400, unit: .Milliliter)

        XCTAssertEqual("400ML", volume.description)
    }

    func testDescriptionFor3Point5LiterIsCorrect() {
        let volume = Volume(amount: 3.5, unit: .Liter)

        XCTAssertEqual("3.5L", volume.description)
    }

    func testItConvert4LitersIntoNewVolumeInMilliliters() {
        let volume = Volume(amount: 4, unit: .Liter)
        let newVolume = volume.toUnit(.Milliliter)

        let expectedVolume = Volume(amount: 4000, unit: .Milliliter)

        XCTAssertEqual(expectedVolume, newVolume)
    }

    func testItConvert450MilliliterIntoNewVolumeInLiter() {
        let volume = Volume(amount: 450, unit: .Milliliter)
        let newVolume = volume.toUnit(.Liter)

        let expectedVolume = Volume(amount: 0.45, unit: .Liter)

        XCTAssertEqual(expectedVolume, newVolume)
    }

    func testItRoundTheAmountFor4Point4Liter() {
        let volume = Volume(amount: 4.4, unit: .Liter)
        let expectedVolume = Volume(amount: 4, unit: .Liter)

        XCTAssertEqual(expectedVolume, volume.roundAmount())
    }
}
