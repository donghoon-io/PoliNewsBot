//
//  ChooseSimilarityViewController.swift
//  PoliNewsBot
//
//  Created by Donghoon Shin on 2021/06/08.
//

import UIKit

class ChooseSimilarityViewController: BottomPopupViewController, SwiftlySliderDelegate {
    
    var delegate: TopicChooseDelegate?
    
    func swiftlySliderValueChanged(_ value: Int) {
        self.chooseButton.isHidden = false
    }
    
    override var popupTopCornerRadius: CGFloat { return 15 }
    
    override var popupPresentDuration: Double { return 0.4 }
    
    override var popupDismissDuration: Double { return 0.4 }
    
    override var popupHeight: CGFloat { return 150 }
    
    @IBOutlet weak var rateView: SwiftlySlider!
    
    @IBOutlet weak var chooseButton: UIButton!
    @IBAction func chooseButtonClicked(_ sender: UIButton) {
        delegate?.chooseComplete()
        self.dismiss(animated: true) {
            print("yaya")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rateView.currentValue = 50
        rateView.maxValue = 100
        rateView.minValue = 0
        
        rateView.delegate = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
