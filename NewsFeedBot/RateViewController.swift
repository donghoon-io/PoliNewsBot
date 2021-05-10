//
//  RateViewController.swift
//  NewsFeedBot
//
//  Created by Donghoon Shin on 2021/05/10.
//

import UIKit

class RateViewController: BottomPopupViewController {
    @IBAction func cancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var rateView: SwiftlySlider!
    
    override var popupTopCornerRadius: CGFloat { return 15 }
    
    override var popupPresentDuration: Double { return 0.4 }
    
    override var popupDismissDuration: Double { return 0.4 }
    
    override var popupHeight: CGFloat { return 600 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rateView.currentValue = 50
        rateView.maxValue = 100
        rateView.minValue = 0
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
