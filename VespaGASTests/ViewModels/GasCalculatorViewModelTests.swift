import XCTest
@testable import VespaGAS

class GasCalculatorViewModelTests: XCTestCase {
    func testViewModelIsNotNil() {
        let viewModel = GasCalculatorViewModel()
        XCTAssertNotNil(viewModel)
    }
}
