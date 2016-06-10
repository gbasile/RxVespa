import ReSwift

struct MainReducer: Reducer {
    func handleAction(action: Action, state: State?) -> State {
        return State(
            oilMixState: oilMixReducer(state?.oilMixState, action: action)
        )
    }
}
