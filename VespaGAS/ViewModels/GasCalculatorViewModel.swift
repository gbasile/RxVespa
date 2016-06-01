import Foundation
import RxSwift

struct GasCalculatorViewModel {
    private let disposeBag = DisposeBag()

    let oilMixValueObservable: Observable<String>
    let oilValueObservable: Observable<String>
    let gasValueObservable: Observable<String>

    init(gasObservable: Observable<Gasoline>, oilMixObservable: Observable<OilMix>) {
        oilMixValueObservable = Observable.combineLatest(gasObservable, oilMixObservable) { (gasoline, oilMix) -> String in
            let oil = oilMix.oilForGasoline(gasoline)
            return oil.toUnit(.Milliliter).roundAmount().description.lowercaseString
        }.startWith(Oil(amount: 0, unit: .Milliliter).description.lowercaseString)

        oilValueObservable = oilMixObservable
            .map {$0.description}
            .startWith(OilMix(amount: 0).description)

        gasValueObservable = gasObservable
            .map {$0.description}
            .startWith(Gasoline(amount: 0, unit: .Liter).description)
    }
}
