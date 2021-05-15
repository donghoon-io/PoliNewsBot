//
//  ViewController.swift
//  PoliNewsBot
//
//  Created by Donghoon Shin on 2021/05/07.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testButton: UIButton! {
        didSet {
            testButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var recommendationButton: UIButton! {
        didSet {
            recommendationButton.layer.cornerRadius = 10
        }
    }
    @IBAction func testButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func moderateButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModerateViewController") as! ModerateViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func interventionButtonClicked(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InterventionViewController") as! InterventionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

