import XCTest
import RxSwift
@testable import VespaGAS

class GasCalculatorViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()

    //MARK: oilMixObservable
    func testViewModelHasOilValueObservable() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilPercentageObservable: Observable.empty()
        )

        XCTAssertNotNil(viewModel.oilMixObservable)
    }

    func testOilValueObservableIsInitialisedWith0() {
        let expectation = self.expectationWithDescription("Oil Observable should start with 0ml")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilPercentageObservable: Observable.empty()
        )

        _ = viewModel.oilMixObservable.subscribeNext { (oilML) in
            XCTAssertEqual("0ml", oilML)
            expectation.fulfill()
        }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    func testOilValueObservableIsCorrectWhen1LiterAnd1OilPercentage() {
        let expectation = self.expectationWithDescription("Oil Observable should be 10")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.just(1),
            oilPercentageObservable: Observable.just(1)
        )

        var isFirstEvent = true
        _ = viewModel.oilMixObservable.subscribeNext { (oilML) in
                if isFirstEvent {
                    isFirstEvent = false
                } else {
                    XCTAssertEqual("10ml", oilML)
                    expectation.fulfill()
                }
            }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.5, handler: nil)
    }

    func testOilValueObservableRoundResult() {
        let expectation = self.expectationWithDescription("Oil Observable should be 13")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.just(1.23),
            oilPercentageObservable: Observable.just(1.5)
        )

        var isFirstEvent = true
        _ = viewModel.oilMixObservable.subscribeNext { (oilML) in
            if isFirstEvent {
                isFirstEvent = false
            } else {
                XCTAssertEqual("18ml", oilML)
                expectation.fulfill()
            }
            }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.5, handler: nil)
    }

}
