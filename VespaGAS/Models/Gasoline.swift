import Foundation

struct Gasoline: Volume {
    var amount: Float
    var unit: VolumeUnit

    var description: String {
        let roundedAmount = round(amount * 10) / 10
        return "\(roundedAmount.cleanValue)\(unit)"
    }
}
