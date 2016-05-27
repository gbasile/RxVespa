import Foundation

struct OilMix: CustomStringConvertible, Equatable {
    let amount: Float
    var description: String {
        return "\(amount.cleanValue)%"
    }
}

func ==(lhs: OilMix, rhs: OilMix) -> Bool {
    return lhs.amount == rhs.amount
}
