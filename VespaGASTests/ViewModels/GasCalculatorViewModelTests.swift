import XCTest
import RxSwift
@testable import VespaGAS

class GasCalculatorViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()

    func testViewModelIsNotNil() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilPercentageObservable: Observable.empty()
        )

        XCTAssertNotNil(viewModel)
    }

    func testViewModelHasOilObservable() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilPercentageObservable: Observable.empty()
        )

        XCTAssertNotNil(viewModel.oilObservable)
    }

    func testOilObservableIsInitialisedWith0() {
        let expectation = self.expectationWithDescription("Oil Observable should start with 0")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilPercentageObservable: Observable.empty()
        )

        _ = viewModel.oilObservable.subscribeNext { (oilML) in
            XCTAssertEqual(0, oilML)
            expectation.fulfill()
        }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    func testOilObservableIsCorrectWhen1LiterAnd1OilPercentage() {
        let expectation = self.expectationWithDescription("Oil Observable should be 10")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.just(1),
            oilPercentageObservable: Observable.just(1)
        )

        var isFirstEvent = true
        _ = viewModel.oilObservable.subscribeNext { (oilML) in
                if isFirstEvent {
                    isFirstEvent = false
                } else {
                    XCTAssertEqual(10, oilML)
                    expectation.fulfill()
                }
            }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.5, handler: nil)
    }
}
