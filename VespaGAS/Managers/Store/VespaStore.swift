import ReSwift

class VespaStore: Store<State> {
    static let sharedInstance = VespaStore(reducer: MainReducer(), state: nil)

    required init(reducer: AnyReducer, state: State?, middleware: [Middleware]) {
        super.init(reducer: reducer, state: state, middleware: middleware)
    }
}
