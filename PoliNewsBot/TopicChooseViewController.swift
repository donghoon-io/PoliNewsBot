//
//  TopicChooseViewController.swift
//  PoliNewsBot
//
//  Created by Donghoon Shin on 2021/06/08.
//

import UIKit
import TagListView

class TopicChooseViewController: BottomPopupViewController, TagListViewDelegate {
    
    var count = 0
    
    var delegate: TopicChooseDelegate?
    
    @IBOutlet weak var tagListView: TagListView!
    
    @IBOutlet weak var chooseButton: UIButton!
    @IBAction func chooseButtonClicked(_ sender: UIButton) {
        delegate?.chooseComplete()
        self.dismiss(animated: true) {
            print("yaya")
        }
    }
    
    let themes = ["LH 혁신위원회", "더불어민주당", "도지코인", "김부겸 청문회", "윤석헌 금감원장", "택배기사 파업", "국내 첫 여성목사"]
    
    override var popupTopCornerRadius: CGFloat { return 15 }
    
    override var popupPresentDuration: Double { return 0.4 }
    
    override var popupDismissDuration: Double { return 0.4 }
    
    override var popupHeight: CGFloat { return 200 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseButton.isHidden = true
        
        for (index, item) in themes.enumerated() {
            if [100].contains(index) {
                let tag = tagListView.addTag(item)
                tag.tagBackgroundColor = UIColor(hex: "B6E3D8")
                tag.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
                tag.textFont = UIFont.systemFont(ofSize: 14)
                tag.cornerRadius = 12
                tag.paddingY = 5
                tag.paddingX = 10
                tag.onTap = { tagView in
                    if tagView.tagBackgroundColor == UIColor(hex: "B6E3D8") {
                        tag.tagBackgroundColor = .systemGray5
                        tag.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
                    } else {
                        tagView.tagBackgroundColor = UIColor(hex: "B6E3D8")
                        tag.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
                    }
                    self.count += 1
                    if self.count == 2 {
                        self.chooseButton.isHidden = false
                    }
                }
            } else {
                let tag = tagListView.addTag(item)
                tag.tagBackgroundColor = .systemGray5
                tag.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
                tag.textFont = UIFont.systemFont(ofSize: 14)
                tag.cornerRadius = 12
                tag.paddingY = 5
                tag.paddingX = 10
                tag.onTap = { tagView in
                    if tagView.tagBackgroundColor == UIColor(hex: "B6E3D8") {
                        tag.tagBackgroundColor = .systemGray5
                        tag.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
                    } else {
                        tagView.tagBackgroundColor = UIColor(hex: "B6E3D8")
                        tag.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
                    }
                    self.count += 1
                    if self.count == 2 {
                        self.chooseButton.isHidden = false
                    }
                }
            }
        }
        tagListView.delegate = self
    }
}

protocol TopicChooseDelegate {
    func chooseComplete()
}
