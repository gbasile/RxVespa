import UIKit
import RxSwift
import RxCocoa

class GasCalculatorViewController: UIViewController {

    @IBOutlet weak var oilLabel: UILabel!
    @IBOutlet weak var oilSlider: UISlider!
    @IBOutlet weak var gasLabel: UILabel!
    @IBOutlet weak var gasSlider: UISlider!
    @IBOutlet weak var oilValueLabel: UILabel!

    var viewModel: GasCalculatorViewModel? = nil
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        let gasolineObservable = self.gasSlider.rx_value.asObservable().map { (amount) -> Gasoline in
            return Gasoline(amount: amount, unit: .Liter)
        }

        let oilMixObservable = self.oilSlider.rx_value.asObservable().map { (amount) -> OilMix in
            return OilMix(amount: amount)
        }

        viewModel = GasCalculatorViewModel(gasObservable: gasolineObservable,
                                           oilMixObservable: oilMixObservable)

        _ = viewModel?.oilMixValueObservable.subscribeNext { oilValue in
            self.oilValueLabel.text = oilValue
        }.addDisposableTo(disposeBag)

        _ = viewModel?.oilValueObservable.subscribeNext { oilValue in
            self.oilLabel.text = oilValue
        }.addDisposableTo(disposeBag)

        _ = viewModel?.gasValueObservable.subscribeNext { gasValue in
            self.gasLabel.text = gasValue
        }.addDisposableTo(disposeBag)
    }

    @IBAction func sliderOilMixDidChange(sender: UISlider) {
        sender.value = round(sender.value)
    }

    @IBAction func sliderGasolineValueDidChange(sender: UISlider) {
        sender.value = round(sender.value * 10) / 10
    }
}
