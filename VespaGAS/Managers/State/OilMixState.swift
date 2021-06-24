import Foundation

struct OilMixState {
    var gasoline: Gasoline
    var oil: Oil
    var oilMix: OilMix

    static func initialState() -> OilMixState {
        return OilMixState(
            gasoline: Gasoline(amount: 4, unit: .Liter),
            oil:Oil(amount: 80, unit: .Milliliter),
            oilMix: OilMix(amount: 2))
    }
}
