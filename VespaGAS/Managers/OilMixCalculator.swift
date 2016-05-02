import Foundation

typealias GasType = Double
typealias OilType = Double

let MLInLiter: Double = 1000

struct OilMixCalculator {
    static func oilMLForGasoline(gasInLiter: GasType, oilPercentage: Double) -> OilType? {
        if oilPercentage == 0 {
            return nil
        }

        return gasInLiter * MLInLiter / 100 * oilPercentage
    }
}
