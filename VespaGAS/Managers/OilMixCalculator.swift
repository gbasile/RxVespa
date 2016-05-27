import Foundation

let MLInLiter: Float = 1000

typealias Oil = Volume
typealias Gasoline = Volume

struct OilMixCalculator {
    static func oilFor(gasoline: Gasoline, oilMix: OilMix) -> Oil {
        return Oil(amount: gasoline.amount / 100 * oilMix.amount, unit: gasoline.unit)
    }
}
