import XCTest
import RxSwift
@testable import VespaGAS

class GasCalculatorViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()

    //MARK: oilMixObservable
    func testOilMixValueObservableIsInitialisedWith0() {
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

    func testOilMixValueObservableIsCorrectWhen1LiterAnd1OilPercentage() {
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

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    func testOilMixValueObservableRoundResult() {
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

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    //MARK: OilValueObservable
    func testViewModelHasOilValueObservable() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilPercentageObservable: Observable.empty()
        )

        XCTAssertNotNil(viewModel.oilValueObservable)
    }

    func testOilValueObservableIsInitialisedWith0() {
        let expectation = self.expectationWithDescription("Oil Value should start with 0%")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilPercentageObservable: Observable.empty()
        )

        var isFirstEvent = true
        _ = viewModel.oilValueObservable.subscribeNext { (oilValue) in
            if (isFirstEvent) {
                XCTAssertEqual("0%", oilValue)
                expectation.fulfill()
                isFirstEvent = false
            }
            }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    func testOilValueObservableIsCorrectWhen2Percentage() {
        let expectation = self.expectationWithDescription("Oil Value should be 2%")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilPercentageObservable: Observable.just(2)
        )

        _ = viewModel.oilValueObservable.subscribeNext { oilValue in
                XCTAssertEqual("2%", oilValue)
                expectation.fulfill()
            }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
