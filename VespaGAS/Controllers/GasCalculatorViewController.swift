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
    let store = VespaStore.sharedInstance

    override func viewDidLoad() {
        _ = self.gasSlider.rx_value.asObservable().subscribeNext { (amount) in
            self.store.dispatch(UpdateWithGasolineAction(gasoline: Gasoline(amount: amount, unit: .Liter)))
        }

        _ = self.oilSlider.rx_value.asObservable().subscribeNext { (amount) in
            self.store.dispatch(UpdateWithOilMixAction(oilMix: OilMix(amount: amount)))
        }

        viewModel = GasCalculatorViewModel()

        _ = viewModel?.oilMixValueObservable.subscribeNext { oilMixValue in
            self.oilLabel.text = oilMixValue
        }.addDisposableTo(disposeBag)

        _ = viewModel?.oilValueObservable.subscribeNext { oilValue in
            self.oilValueLabel.text = oilValue
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
