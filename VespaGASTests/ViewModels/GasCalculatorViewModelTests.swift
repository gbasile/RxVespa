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
            oilMixObservable: Observable.empty()
        )

        _ = viewModel.oilMixValueObservable.subscribeNext { (oilML) in
            XCTAssertEqual("0ml", oilML)
            expectation.fulfill()
            }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    func testOilMixValueObservableIsCorrectWhen1LiterAnd1OilPercentage() {
        let expectation = self.expectationWithDescription("Oil Observable should be 10")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.just(Gasoline(amount: 1, unit: .Liter)),
            oilMixObservable: Observable.just(OilMix(amount: 1))
        )

        var isFirstEvent = true
        _ = viewModel.oilMixValueObservable.subscribeNext { (oilML) in
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
            gasObservable: Observable.just(Gasoline(amount: 1.23, unit: .Liter)),
            oilMixObservable: Observable.just(OilMix(amount: 1.5))
        )

        var isFirstEvent = true
        _ = viewModel.oilMixValueObservable.subscribeNext { (oilML) in
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
            oilMixObservable: Observable.empty()
        )

        XCTAssertNotNil(viewModel.oilValueObservable)
    }

    func testOilValueObservableIsInitialisedWith0() {
        let expectation = self.expectationWithDescription("Oil Value should start with 0%")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilMixObservable: Observable.empty()
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
            oilMixObservable: Observable.just(OilMix(amount: 2))
        )

        _ = viewModel.oilValueObservable.subscribeNext { oilValue in
                XCTAssertEqual("2%", oilValue)
                expectation.fulfill()
            }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    //MARK: GasValueObservable
    func testViewModelHasGasObservable() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilMixObservable: Observable.empty()
        )

        XCTAssertNotNil(viewModel.gasValueObservable)
    }

    func testGasVaueObservableIsInitalisedWith0() {
        let expectation = self.expectationWithDescription("Gas Value should start with 0L")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilMixObservable: Observable.empty()
        )

        var isFirstEvent = true
        _ = viewModel.gasValueObservable.subscribeNext { (oilValue) in
            if (isFirstEvent) {
                XCTAssertEqual("0L", oilValue)
                expectation.fulfill()
                isFirstEvent = false
            }
            }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    func testGasValueObservableIsCorrectWhen3Liters() {
        let expectation = self.expectationWithDescription("Gas Value should be 3L")

        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.just(Gasoline(amount: 3, unit: .Liter)),
            oilMixObservable: Observable.empty()
        )

        _ = viewModel.gasValueObservable.subscribeNext { oilValue in
            XCTAssertEqual("3L", oilValue)
            expectation.fulfill()
            }.addDisposableTo(disposeBag)

        self.waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
