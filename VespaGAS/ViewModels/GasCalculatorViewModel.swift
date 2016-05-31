import Foundation
import RxSwift

struct GasCalculatorViewModel {
    private let disposeBag = DisposeBag()
    private let oilValueSubject = BehaviorSubject(value: OilMix(amount:0))
    private let gasValueSubject = BehaviorSubject(value: Gasoline(amount:0, unit:.Liter))

    var oilMixValueObservable: Observable<String> = Observable.empty()
    var oilValueObservable: Observable<String> {
        return oilValueSubject.asObservable().map({ (oilMix) -> String in
            return oilMix.description
        })
    }

    var gasValueObservable: Observable<String> {
        return gasValueSubject.asObservable().map({ (gasoline) -> String in
            return gasoline.description
        })
    }

    init(gasObservable: Observable<Gasoline>, oilMixObservable: Observable<OilMix>) {
        oilMixValueObservable = Observable.combineLatest(gasObservable, oilMixObservable) { (gasoline, oilMix) -> String in
            let oil = oilMix.oilForGasoline(gasoline)
            return oil.toUnit(.Milliliter).roundAmount().description.lowercaseString
        }.startWith(Oil(amount: 0, unit: .Milliliter).description.lowercaseString)

        oilMixObservable.subscribeNext() { oilMix in
            let oilSubject = self.oilValueSubject
            oilSubject.onNext(oilMix)
        }.addDisposableTo(disposeBag)

        gasObservable.subscribeNext() { gasValue in
            let gasSubject = self.gasValueSubject
            gasSubject.onNext(gasValue)
        }.addDisposableTo(disposeBag)
    }
}
