import XCTest
import RxSwift
@testable import VespaGAS

class GasCalculatorViewModelTests: XCTestCase {
    func testViewModelIsNotNil() {
        let viewModel = GasCalculatorViewModel()
        XCTAssertNotNil(viewModel)
    }

    func testViewModelHasOilObservable() {
        let viewModel = GasCalculatorViewModel()
        XCTAssertNotNil(viewModel.oilObservable)
    }
}
