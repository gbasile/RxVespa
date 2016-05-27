import Foundation

enum VolumeUnit: CustomStringConvertible {
    case Liter
    case Milliliter

    func inLiter() -> Float {
        switch self {
        case .Liter:
            return 1
        default:
            return 1000
        }
    }

    var description: String {
        switch self {
        case .Liter:
            return "L"
        default:
            return "ML"
        }
    }
}

struct Volume: CustomStringConvertible, Equatable {
    let amount: Float
    let unit: VolumeUnit
    var description: String {
        return "\(amount.cleanValue)\(unit.description)"
    }

    func toUnit(newUnit: VolumeUnit) -> Volume {
        return Volume(amount: self.amountInUnit(newUnit), unit: newUnit)
    }

    func amountInUnit(unit: VolumeUnit) -> Float {
        return amount * unit.inLiter() / self.unit.inLiter()
    }

    func roundAmount() -> Volume {
        return Volume(amount: round(self.amount), unit: unit)
    }
}

func ==(lhs: Volume, rhs: Volume) -> Bool {
    return lhs.amount == rhs.amount && lhs.unit == rhs.unit
}
