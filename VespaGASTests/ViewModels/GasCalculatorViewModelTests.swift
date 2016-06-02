import XCTest
import RxSwift
import RxTests

@testable import VespaGAS

class GasCalculatorViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()

    var scheduler: TestScheduler!
    var testableObserver: TestableObserver<String>!

    override func setUp() {
        super.setUp()

        scheduler = TestScheduler(initialClock: 0)
        testableObserver = scheduler.createObserver(String)
    }

    //MARK: oilMixObservable
    func testOilMixValueObservableIsInitialisedWith0() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilMixObservable: Observable.empty()
        )

        viewModel.oilMixValueObservable.subscribe(testableObserver)
        scheduler.start()

        let expectedEvents = [
            next(0, "0ml"),
            completed(0)
        ]

        XCTAssertEqual(expectedEvents, testableObserver.events)
    }

    func testOilMixValueObservableIsCorrectWhen1LiterAnd1OilPercentage() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.just(Gasoline(amount: 1, unit: .Liter)),
            oilMixObservable: Observable.just(OilMix(amount: 1))
        )

        viewModel.oilMixValueObservable.subscribe(testableObserver)
        scheduler.start()

        let expectedEvents = [
            next(0, "0ml"),
            next(0, "10ml"),
            completed(0)
        ]

        XCTAssertEqual(expectedEvents, testableObserver.events)
    }

    func testOilMixValueObservableRoundResult() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.just(Gasoline(amount: 1.23, unit: .Liter)),
            oilMixObservable: Observable.just(OilMix(amount: 1.5))
        )

        viewModel.oilMixValueObservable.subscribe(testableObserver)
        scheduler.start()

        let expectedEvents = [
            next(0, "0ml"),
            next(0, "18ml"),
            completed(0)
        ]

        XCTAssertEqual(expectedEvents, testableObserver.events)
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
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilMixObservable: Observable.empty()
        )

        viewModel.oilValueObservable.subscribe(testableObserver)
        scheduler.start()

        let expectedEvents = [
            next(0, "0%"),
            completed(0)
        ]

        XCTAssertEqual(expectedEvents, testableObserver.events)
    }

    func testOilValueObservableIsCorrectWhen2Percentage() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilMixObservable: Observable.just(OilMix(amount: 2))
        )

        viewModel.oilValueObservable.subscribe(testableObserver)
        scheduler.start()

        let expectedEvents = [
            next(0, "0%"),
            next(0, "2%"),
            completed(0)
        ]

        XCTAssertEqual(expectedEvents, testableObserver.events)
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
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.empty(),
            oilMixObservable: Observable.empty()
        )

        viewModel.gasValueObservable.subscribe(testableObserver)
        scheduler.start()

        let expectedEvents = [
            next(0, "0L"),
            completed(0)
        ]

        XCTAssertEqual(expectedEvents, testableObserver.events)
    }

    func testGasValueObservableIsCorrectWhen3Liters() {
        let viewModel = GasCalculatorViewModel(
            gasObservable: Observable.just(Gasoline(amount: 3, unit: .Liter)),
            oilMixObservable: Observable.empty()
        )

        viewModel.gasValueObservable.subscribe(testableObserver)
        scheduler.start()

        let expectedEvents = [
            next(0, "0L"),
            next(0, "3L"),
            completed(0)
        ]

        XCTAssertEqual(expectedEvents, testableObserver.events)
    }
}
