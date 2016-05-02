import Foundation
import RxSwift

public struct GasCalculatorViewModel {
    var oilObservable: Observable<OilType>

    init() {
        oilObservable = Observable.empty()
    }
}
