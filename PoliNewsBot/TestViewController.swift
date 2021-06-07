//
//  TestViewController.swift
//  PoliNewsBot
//
//  Created by Donghoon Shin on 2021/05/07.
//

import UIKit
import InputBarAccessoryView
import FirebaseFirestore
import MessageKit
import IQKeyboardManagerSwift

class TestViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, TopicChooseDelegate {
    
    var buttonIdx = 0
    
    @objc func nextGo() {
        if buttonIdx == 0 {
            buttonIdx += 1
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                self.sendBotMessage(text: "다음으로, '택배기사 노조 파업' 이슈에 대한 두가지 종류의 기사입니다. 읽으신 후 더 선호하는 기사를 알려주세요!")
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    self.sendBotMessage(text: "[위] 대책마련에 잇단 파업까지’ 안팎으로 치이는 택배업계\n\n코로나19 여파로 택배 물동량은 급격하게 늘고 있지만 수익성은 갈수록 악화되면서 택배업계의 고민이 깊어지고 있다. 수익성이 악화된 이유로는, 업체 간 경쟁과 인건비와 자동화설비에 대한 투자가 늘어났기 때문이다. 또한, 작년부터 본격적으로 논의가 시작된 택배기사 과로사 대책에 노조의 잇단 파업 문제까지 안팎으로 해결해야 할 과제가 산적해 있는 상황이다.", isTrue: true)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                        self.sendBotMessage(text: "[아래] 이번에도···정부가 나서 택배 파업 막았다\n\n택배기사의 파업을 기업이 아닌 정부가 나서 해결하는 일이 반복되고 있다. 택배회사 측은 “지상진입 갈등은 아파트와 택배기사가 대화로 풀 문제”라고 한발 빠져있었다. 그러자 택배노조는 지난달 말 CJ대한통운 대표를 지상진입 금지지역에 노동강도가 센 저상차량을 이용하게 했다며 산업안전보건법 위반 혐의로 고발했다.", isTrue: true)
                    }
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                self.sendBotMessage(text: "답변해주셔서 감사합니다. 혹시 선호하는 기사 종류에 대한 추가 의견은 없을까요?")
            }
        }
    }
    
    var chooseIdx = 0
    
    func chooseComplete() {
        if chooseIdx == 0 {
            chooseIdx += 1
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                self.sendBotMessage(text: "먼저, '도지코인' 이슈에 대한 두가지 종류의 기사입니다. 읽으신 후 더 선호하는 기사의 우측 체크버튼을 클릭해주세요!")
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    self.sendBotMessage(text: "[위] 머스크 한마디에 울고웃고...도지코인 국내 거래량 한달새 15배\n\n4월 중순 머스크의 언급으로 도지코인의 폭발적인 거래가 이루어졌다. 머스크는 8일(현지시간) SNL에 출연해 도지코인을 소재로 한 콩트를 선보인 뒤 '도지코인은 사기인가'라는 질문에 '맞다, 사기다'라고 답했고, 도지코인 가격은 급락했다. 다만 머스크의 우주 탐사 기업 스페이스X가 한 민간 기업의 달 탐사 계획에서 가상화폐인 도지코인을 결제 수단으로 허용하기로 하면서 향후 가격 흐름은 또 달라질 수도 있다.", isTrue: true)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                        self.sendBotMessage(text: "[아래] 이더리움, 역대 최고치 경신...도지코인 22%↓\n\n시가총액 2위의 가상화폐 이더리움이 계속해서 사상 최고가를 기록하고 있다. 경제매체 CNBC는 코인메트릭스를 인용해 이더리움이 역대 가장 높은 4196.63달러까지 상승했다고 전했다. 전기차 업체 테슬라의 일론 머스크 최고경영자(CEO)가 적극적으로 띄우기에 나섰던 도지코인 가격은 24시간 전보다 무려 22.0%나 빠지며 0.4422달러로 주저앉았다.", isTrue: true)
                    }
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                self.sendBotMessage(text: "챗봇 기사추천 서비스 설정이 완료되었습니다!")
            }
        }
    }
    
    
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
    
    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        // Cells are reused, so only add a button here once. For real use you would need to
        // ensure any subviews are removed if not needed
        
        
        accessoryView.subviews.forEach { $0.removeFromSuperview() }
        accessoryView.backgroundColor = .clear
        
        if message.messageId.contains("thisistrue") {
            let button = UIButton()
            button.setImage(UIImage(named: "check"), for: .normal)
            button.tintColor = UIColor(hex: "666666")
            accessoryView.addSubview(button)
            button.frame = accessoryView.bounds
            button.addTarget(self, action: #selector(nextGo), for: .touchUpInside)
            accessoryView.layer.cornerRadius = accessoryView.frame.height / 2
            accessoryView.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        messagesCollectionView.contentInset.top = 10
        
        let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
        layout?.setMessageIncomingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout?.setMessageIncomingAccessoryViewPadding(HorizontalEdgeInsets(left: 8, right: 0))
        layout?.setMessageIncomingAccessoryViewPosition(.messageBottom)
        layout?.setMessageOutgoingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout?.setMessageOutgoingAccessoryViewPadding(HorizontalEdgeInsets(left: 0, right: 8))
        
        bot()
    }
    
    func sendBotMessage(text: String, isTrue: Bool = false) {
        let message = Message(id: isTrue ? UUID().uuidString + "thisistrue" : UUID().uuidString, content: text, created: Timestamp(), senderID: botID, senderName: "봇")
        
        insertNewMessage(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func bot() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.sendBotMessage(text: "안녕하세요:) 저는 여러분들의 평가를 바탕으로 뉴스 기사를 분류하고 맞춤형 기사를 추천해드릴 PoliNewsBot입니다")
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                self.sendBotMessage(text: "여러분이 관심 있는 이슈들에 대한 요약문을 읽고 더 선호하는 기사를 선택해주시면, 그것을 토대로 원하시는 조건에 맞는 기사를 추천해드릴게요!")
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    self.sendBotMessage(text: "먼저, 다음 이슈들 중 가장 관심 있는 이슈를 2가지 이상 선택해주세요:")
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopicChooseViewController") as! TopicChooseViewController
                        vc.delegate = self
                        self.present(vc, animated: true, completion: nil)
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
            case "없어요":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "기사 평가가 완료되었습니다! 신동훈 님의 기사 선호 유형을 분석중입니다")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                        self.sendBotMessage(text: "분석이 완료되었습니다! 이슈 1개당 추천받을 기사의 개수를 선택해주세요")
                    }
                }
            case "2개":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "본인의 선호도와 어느 정도 유사한 성향의 기사를 추천받을지 선택해주세요:")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseSimilarityViewController") as! ChooseSimilarityViewController
                        vc.delegate = self
                        self.present(vc, animated: true, completion: nil)
                    }
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
        case experimentID: return UIColor.systemGray5
        default: return UIColor(hex: "B6E3D8")
        }
    }
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        switch message.sender.senderId {
        case experimentID: return UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        default: return UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        switch message.sender.senderId {
        case experimentID: avatarView.initials = "나"
        default: avatarView.image = UIImage(named: "chatbot_profile")
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
        
    }
    
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
