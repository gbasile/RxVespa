import Foundation

typealias GasType = Float
typealias OilType = Float
typealias OilMixType = Float

let MLInLiter: Float = 1000

struct OilMixCalculator {
    static func oilMLForGasoline(gasInLiter: GasType, oilPercentage: OilMixType) -> OilType? {
        if oilPercentage == 0 {
            return nil
        }

        return gasInLiter * MLInLiter / 100 * oilPercentage
    }
}
