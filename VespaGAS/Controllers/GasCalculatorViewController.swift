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
        viewModel = GasCalculatorViewModel(gasObservable: self.gasSlider.rx_value.asObservable(), oilPercentageObservable: self.oilSlider.rx_value.asObservable())
        _ = viewModel?.oilMixObservable.subscribeNext({ oilValue in
            self.oilValueLabel.text = oilValue
        }).addDisposableTo(disposeBag)
    }
}
