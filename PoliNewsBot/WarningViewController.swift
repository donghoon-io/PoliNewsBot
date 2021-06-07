//
//  WarningViewController.swift
//  PoliNewsBot
//
//  Created by Donghoon Shin on 2021/06/08.
//

import UIKit

class WarningViewController: UIViewController {
    
    var delegate: TopicChooseDelegate?
    
    var representNeeded = true

    @IBAction func okayClicked(_ sender: UIButton) {
        if representNeeded {
            delegate?.chooseComplete()
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var warningView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warningView.layer.cornerRadius = 15.0
        warningView.clipsToBounds = true
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
