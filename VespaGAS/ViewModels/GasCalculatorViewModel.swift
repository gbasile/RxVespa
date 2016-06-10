import Foundation
import RxSwift
import ReSwift

class GasCalculatorViewModel: StoreSubscriber {
    private let oilMixBehaviourSubject = BehaviorSubject(value: OilMix(amount: 0).description)
    private let oilBehaviourSubject = BehaviorSubject(value: Oil(amount: 0, unit: .Milliliter).description.lowercaseString)
    private let gasolineBehaviourSubject = BehaviorSubject(value: Gasoline(amount: 0, unit: .Liter).description)

    var oilMixValueObservable: Observable<String> {
        get {
            return oilMixBehaviourSubject.asObservable().distinctUntilChanged()
        }
    }

    var  oilValueObservable: Observable<String> {
        get {
            return oilBehaviourSubject.asObservable().distinctUntilChanged()
        }
    }

    var gasValueObservable: Observable<String> {
        get {
            return gasolineBehaviourSubject.asObservable().distinctUntilChanged()
        }
    }

    init() {
        VespaStore.sharedInstance.subscribe(self)
    }

    func newState(state: State) {
        oilMixBehaviourSubject.onNext(state.oilMixState.oilMix.description)
        oilBehaviourSubject.onNext(state.oilMixState.oil.toUnit(.Milliliter).description.lowercaseString)
        gasolineBehaviourSubject.onNext(state.oilMixState.gasoline.toUnit(.Liter).description)
    }

    deinit {
        VespaStore.sharedInstance.unsubscribe(self)
    }
}
