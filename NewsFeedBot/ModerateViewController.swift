//
//  ModerateViewController.swift
//  NewsFeedBot
//
//  Created by Donghoon Shin on 2021/05/07.
//

import UIKit
import TagListView
import InputBarAccessoryView
import FirebaseFirestore
import MessageKit
import IQKeyboardManagerSwift

class ModerateViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, TagListViewDelegate {
    
    let themes = ["LH 혁신위원회", "더불어민주당", "도지코인", "김부겸 청문회", "윤석헌 금감원장", "택배기사 파업"]
    
    @IBOutlet weak var tagTopView: UIView!
    @IBOutlet weak var tagListView: TagListView!
    
    var displayName = "나"
    var experimentID = "hci_theory_and_practice"
    var botID = "bot_id"
    
    var messages: [Message] = []
    
    func currentSender() -> SenderType {
        return Sender(id: experimentID, displayName: displayName)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        if messages.count == 0 {
            return 0
        } else {
            return messages.count
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, item) in themes.enumerated() {
            if [1,5].contains(index) {
                let tag = tagListView.addTag(item)
                tag.tagBackgroundColor = .link
                tag.textFont = UIFont.systemFont(ofSize: 14)
                tag.cornerRadius = 12
                tag.paddingY = 5
                tag.paddingX = 10
                tag.onTap = { tagView in
                    if tagView.tagBackgroundColor == .link {
                        tagView.tagBackgroundColor = .gray
                    } else {
                        tagView.tagBackgroundColor = .link
                    }
                }
            } else {
                let tag = tagListView.addTag(item)
                tag.tagBackgroundColor = .gray
                tag.textFont = UIFont.systemFont(ofSize: 14)
                tag.cornerRadius = 12
                tag.paddingY = 5
                tag.paddingX = 10
                tag.onTap = { tagView in
                    if tagView.tagBackgroundColor == .link {
                        tagView.tagBackgroundColor = .gray
                    } else {
                        tagView.tagBackgroundColor = .link
                    }
                }
            }
        }
        tagListView.delegate = self
        
        navigationItem.largeTitleDisplayMode = .never
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = .lightGray
        messageInputBar.inputTextView.autocorrectionType = .no
        messageInputBar.sendButton.setTitleColor(.darkGray, for: .normal)
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.inputTextView.placeholder = "메시지를 입력하세요"
        messageInputBar.sendButton.setTitle("전송", for: .normal)
        messagesCollectionView.contentInset.top = 140
        
        bot()
        
        let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
        layout?.setMessageIncomingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout?.setMessageIncomingAccessoryViewPadding(HorizontalEdgeInsets(left: 8, right: 0))
        layout?.setMessageIncomingAccessoryViewPosition(.messageBottom)
        layout?.setMessageOutgoingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout?.setMessageOutgoingAccessoryViewPadding(HorizontalEdgeInsets(left: 0, right: 8))
        
        self.view.bringSubviewToFront(tagTopView)
    }
    
    
    
    func sendBotMessage(text: String, _ isTrue: Bool = false) {
        let message = Message(id: isTrue ? "thisistrue"+UUID().uuidString:UUID().uuidString, content: text, created: Timestamp(), senderID: botID, senderName: "봇")
        
        insertNewMessage(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    
    func bot() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.sendBotMessage(text: "[더불어민주당]에 대한 기사입니다")
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                self.sendBotMessage(text: "김남국 더불어민주당 의원이 '알고리즘이 공정하고 중립적이며 객관적인지에 대한 문제들이 지속적으로 제기되고 있다'며 규제 필요성을 재차 주장했다. 최근 김의원의 발의안에 따르면, 문화체육관광부 소속 뉴스포털이용자위원회를 설치하고, 포털의 기사배열 알고리즘을 공개 및 검증하게 된다.", true)
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    self.sendBotMessage(text: "박용진 더불어민주당 의원이 9일 '정치의 세대교체로 대한민국의 시대교체를 이루겠다'며 20대 대선 출마를 공식 선언했다. '낡고 무기력한 정치로 청년 세대를 분노하게 만든 책임이 있는 인물·세력은 새 시대를 이끌 수 없다'라고도 밝혔다.", true)
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                        self.sendBotMessage(text: "[택배기사 파업]에 대한 기사입니다")
                        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                            self.sendBotMessage(text: "지난달 서울 강동구 아파트에서 택배차량의 지상 진입을 금지하면서 해당아파트, 택배사와 갈등을 빚고 있는 전국택배노동조합이 총파업을 결정했다. 택배노조 파업은 서울 강동구 고덕동의 한 대단지 아파트에서 벌어진 '택배갈등'에서 시작됐다.", true)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                                self.sendBotMessage(text: "정부가 부분파업을 예고한 전국택배노동조합에 '택배사가 참여하는 사회적 논의기구를 만들자'고 제안한 것으로 9일 알려졌다. 택배차량의 지상도로 진입 차단 문제로 공원형 아파트에서 입주자들과 택배기사들 간의 갈등이 반복되는 상황에서 이 문제 해결을 위해 별도의 '사회적 논의기구' 설치를 언급한 것은 처음이다.", true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
            
            switch message.content {
            case "3":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "선택하신 이슈에 대한 5개 기사의 요약문입니다. 읽으신 후 다음 평가 기준에 따라 각 기사에 대한 별점을 매겨주세요!")
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                        self.sendBotMessage(text: "밈에서 장난처럼 탄생한 가상자산인 도지코인이 거침없는 상승세를 이어가고 있다. 도지코인은 6개월만에 2만 5000% 이상의 상승률을 보이며 시가 총액도 860역 달러에 이르고 있다. 도지 코인의 상승세에는 일런 머스크 테슬라 CEO의 영향이 크다. 그는 꾸준히 자신의 트위터에 도지 코인 관련 글을 올리고 있다. 하지만 도지 코인의 급격한 상승을 부정적으로 보는 시각도 크다. 가격 변동성이 크기 때문에 실제 결제 수단으로 쓰인 적이 없었기 때문에 전형적인 투기의 결과물로 보는 쪽이 우세하다.")
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                            self.sendBotMessage(text: "기사 내용에 대한 선호도 (1~5점)")
                        }
                    }
                }
            case "1점":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "기사의 정치적 중립성 (1~5점)")
                }
            case "2점":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "기사의 선한 영향력 (1~5점)")
                }
            case "3점":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "혹시 추가 의견이 있으시다면 남겨주세요!")
                }
            case "없어요":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "기사 평가가 완료되었습니다! 신동훈 님의 기사 선호 유형을 분석중입니다")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                        self.sendBotMessage(text: "분석이 완료되었습니다! 이슈 1개당 추천받을 기사의 개수를 선택해주세요")
                    }
                }
            case "3개":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "본인의 선호도와 어느 정도 유사한 성향의 기사를 추천받을지 선택해주세요 (0~100%)")
                }
            default:
                print("no")
            }
        }
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: experimentID, senderName: self.displayName)
        
        //messages.append(message)
        insertNewMessage(message)
        
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
        
        inputBar.inputTextView.resignFirstResponder()
    }
    
    // MARK: - MessagesLayoutDelegate
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    // MARK: - MessagesDisplayDelegate
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        switch message.sender.senderId {
        case experimentID: return .systemBlue
        default: return .systemGray5
        }
    }
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        switch message.sender.senderId {
        case experimentID: return .white
        default: return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        }
    }
    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        // Cells are reused, so only add a button here once. For real use you would need to
        // ensure any subviews are removed if not needed
        
        
        accessoryView.subviews.forEach { $0.removeFromSuperview() }
        accessoryView.backgroundColor = .clear
        
        if message.messageId.contains("thisistrue") {
            let button = UIButton(type: .infoLight)
            button.tintColor = .link
            accessoryView.addSubview(button)
            button.frame = accessoryView.bounds
            button.addTarget(self, action: #selector(click), for: .touchUpInside)
            accessoryView.layer.cornerRadius = accessoryView.frame.height / 2
            accessoryView.backgroundColor = .clear
        }
        
    }
    
    @objc func click() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RateViewController") as! RateViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        switch message.sender.senderId {
        case experimentID: avatarView.initials = "나"
        default: avatarView.initials = "봇"
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
        
    }
}
