import Foundation
import ReSwift

func oilMixReducer(state: OilMixState?, action: Action) -> OilMixState {
    let newState = state ?? OilMixState.initialState()
    switch action {
    case let gasolineAction as UpdateWithGasolineAction:
        return updateOilMixStateWithNewGasoline(newState, action: gasolineAction)
    case let oilMixAction as UpdateWithOilMixAction:
        return updateOilMixStateWithNewOilMix(newState, action: oilMixAction)
    default:
        return newState
    }
}

func updateOilMixStateWithNewOilMix(state: OilMixState, action: UpdateWithOilMixAction) -> OilMixState {
    var newState = state
    newState.oil = action.oilMix.oilForGasoline(state.gasoline)
    newState.oilMix = action.oilMix

    return newState
}

func updateOilMixStateWithNewGasoline(state: OilMixState, action: UpdateWithGasolineAction) -> OilMixState {
    var newState = state
    newState.oil = state.oilMix.oilForGasoline(action.gasoline)
    newState.gasoline = action.gasoline

    return newState
}
