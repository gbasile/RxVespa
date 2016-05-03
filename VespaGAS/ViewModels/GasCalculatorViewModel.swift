import Foundation
import RxSwift

struct GasCalculatorViewModel {
    private let disposeBag = DisposeBag()
    private let oilValueSubject = BehaviorSubject(value: "0%")
    private let gasValueSubject = BehaviorSubject(value: "0L")

    var oilMixObservable: Observable<String> = Observable.empty()
    var oilValueObservable: Observable<String> {
        return oilValueSubject.asObservable()
    }
    var gasValueObservable: Observable<String> {
        return gasValueSubject.asObservable()
    }

    init(gasObservable: Observable<GasType>, oilPercentageObservable: Observable<OilMixType>) {
        oilMixObservable = Observable.combineLatest(gasObservable, oilPercentageObservable) { (gasInLiter, oilPercentage) -> String in
            if let oilValue = OilMixCalculator.oilMLForGasoline(gasInLiter, oilPercentage: oilPercentage) {
                return "\(Int(round(oilValue)))ml"
            } else {
                return "Error"
            }
        }.startWith("0ml")

        oilPercentageObservable.subscribeNext() { oilValue in
            let text = "\(Int(oilValue))%"
            self.oilValueSubject.onNext(text)
        }.addDisposableTo(disposeBag)

        gasObservable.subscribeNext() { gasValue in
            let text = "\(gasValue)L"
            self.gasValueSubject.onNext(text)
        }.addDisposableTo(disposeBag)
    }
}
