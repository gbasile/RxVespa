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

protocol Volume: CustomStringConvertible, Equatable {
    var amount: Float {get set}
    var unit: VolumeUnit {get set}

    init(amount: Float, unit: VolumeUnit)
    func toUnit(newUnit: VolumeUnit) -> Self
    func amountInUnit(unit: VolumeUnit) -> Float
    func roundAmount() -> Self
}

extension Volume {
    var description: String {
        return "\(round(amount).cleanValue)\(unit)"
    }

    func toUnit(newUnit: VolumeUnit) -> Self {
        return Self(amount: self.amountInUnit(newUnit), unit: newUnit)
    }

    func amountInUnit(unit: VolumeUnit) -> Float {
        return amount * unit.inLiter() / self.unit.inLiter()
    }

    func roundAmount() -> Self {
        return Self(amount: round(amount), unit: unit)
    }
}

func ==<A where A:Volume>(lhs: A, rhs: A) -> Bool {
    return lhs.amount == rhs.amount && lhs.unit == rhs.unit
}
