import Foundation

struct OilMix: CustomStringConvertible, Equatable {
    let amount: Float
    var description: String {
        return "\(amount.cleanValue)%"
    }

    func oilForGasoline(gasoline: Gasoline) -> Oil {
        return Oil(amount: gasoline.amount / 100 * self.amount, unit: gasoline.unit)
    }
}

func ==(lhs: OilMix, rhs: OilMix) -> Bool {
    return lhs.amount == rhs.amount
}
