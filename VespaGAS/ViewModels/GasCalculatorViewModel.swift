import Foundation
import RxSwift

public struct GasCalculatorViewModel {
    var oilValueObservable: Observable<String> = Observable.empty()

    init(gasObservable: Observable<GasType>, oilPercentageObservable: Observable<OilMixType>) {
        oilValueObservable = Observable.combineLatest(gasObservable, oilPercentageObservable) { (gasInLiter, oilPercentage) -> String in
            if let oilValue = OilMixCalculator.oilMLForGasoline(gasInLiter, oilPercentage: oilPercentage) {
                return "\(Int(round(oilValue)))ml"
            } else {
                return "Error"
            }
        }.startWith("0ml")
    }
}
