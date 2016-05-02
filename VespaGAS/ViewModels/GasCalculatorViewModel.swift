import Foundation
import RxSwift

public struct GasCalculatorViewModel {
    var oilObservable: Observable<OilType?> = Observable.empty()

    init(gasObservable: Observable<GasType>, oilPercentageObservable: Observable<OilMixType>) {
        oilObservable = Observable.combineLatest(gasObservable, oilPercentageObservable) { (gasInLiter, oilPercentage) -> OilType? in
            return OilMixCalculator.oilMLForGasoline(gasInLiter, oilPercentage: oilPercentage)
        }.startWith(0)
    }
}
