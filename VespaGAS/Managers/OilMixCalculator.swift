import Foundation

typealias GasType = Double
typealias OilType = Double
typealias OilMixType = Double

let MLInLiter: Double = 1000

struct OilMixCalculator {
    static func oilMLForGasoline(gasInLiter: GasType, oilPercentage: OilMixType) -> OilType? {
        if oilPercentage == 0 {
            return nil
        }

        return gasInLiter * MLInLiter / 100 * oilPercentage
    }
}
