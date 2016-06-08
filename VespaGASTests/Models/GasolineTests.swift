import XCTest
@testable import VespaGAS

class GasolineTests: XCTestCase {
    func testDescriptionFor3Point5LiterIsCorrect() {
        let gasoline = Gasoline(amount: 3.5, unit: .Liter)

        XCTAssertEqual("3.5L", gasoline.description)
    }
}
