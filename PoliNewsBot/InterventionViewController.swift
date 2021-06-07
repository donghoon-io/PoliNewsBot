//
//  InterventionViewController.swift
//  PoliNewsBot
//
//  Created by Donghoon Shin on 2021/05/15.
//

import UIKit
import TagListView
import InputBarAccessoryView
import FirebaseFirestore
import MessageKit
import IQKeyboardManagerSwift

class InterventionViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, TagListViewDelegate, TopicChooseDelegate {
    
    func chooseComplete() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.sendBotMessage(text: "(비밀메시지)\n'조희연 교육감 공수처 수사' 기사에 80%의 만족도를 보인 참가자들이 토의하고 있는 방에 들어오셨습니다.")
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                self.sendBotMessage(text: "(비밀메시지)\n현재 참가자의 66%는 공수처의 수사 행태를 비난하고 있고, 33%는 조희연 교육감를 문제삼는 의견을 보이고 있습니다.")
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    self.sendAnon1Message(text: "그래도 첫 수사대상으로 설립 취지에 맞게 큰 권력을 건드는 상징적인 사건이었으면 좋았을텐데 좀 아쉽네요 ㅠㅠ 기대가 컸는데", true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                        self.sendAnon2Message(text: "뭔소리임? 조희연ㅉㅉ이런 사람이 교육감인게 말이나 되냐", true)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                            self.sendAnon2Message(text: "그러면 교사가 정치질하는거 봐줘야하냐?", true)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                                self.sendAnon2Message(text: "왜 도대체 서울시민들 저런애를 뽑은거임??", true)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+2.5) {
                                    self.sendBotMessage(text: "익명2님은 욕설/메시지 도배로 숨김처리 되었습니다.")
                                    
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now()+5.0) {
                                        self.sendBotMessage(text: "다른 채팅룸에서는 해당기사에 대해\n#검찰개혁 #전교조\n라는 키워드로 대화를 나누고 있어요. 이런 키워드로 대화를 해보는건 어떨까요?")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    var displayName = "나"
    var experimentID = "hci_theory_and_practice"
    var botID = "bot_id"
    var participant1 = "participant1"
    var participant2 = "participant2"
    var participant3 = "participant3"
    
    var messages: [Message] = [
        Message(id: UUID().uuidString+"thisistrue", content: "공수처가 너무 몸사리는 거 아닌가요? 공수처 설치 이유는 검찰이 못 건드릴 것 같은 권력을 정정당당하게 수사하기 위해서 잖아요", created: Timestamp(date: Date(timeIntervalSinceNow: -100)), senderID: "participant1", senderName: "익명1"),
        Message(id: UUID().uuidString+"thisistrue", content: "처음부터 삐걱거리는 느낌이..피래미 말고 베스 잡으러 갑시다", created: Timestamp(date: Date(timeIntervalSinceNow: -100)), senderID: "participant2", senderName: "익명2"),
        Message(id: UUID().uuidString+"thisistrue", content: "공수처 소속 검사가 13명 밖에 안되는군요.. 저 사람들도 사람인데 부담감이 컸을거라 생각됩니다. 이번 수사 잘 성과 내서 다음 수사에 힘을 얻을 수 있으면 좋겠네요.", created: Timestamp(date: Date(timeIntervalSinceNow: -100)), senderID: "participant3", senderName: "익명3")
    ]
    
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
        
        bot()
        
        let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
        layout?.setMessageIncomingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout?.setMessageIncomingAccessoryViewPadding(HorizontalEdgeInsets(left: 8, right: 0))
        layout?.setMessageIncomingAccessoryViewPosition(.messageBottom)
        layout?.setMessageOutgoingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout?.setMessageOutgoingAccessoryViewPadding(HorizontalEdgeInsets(left: 0, right: 8))
    }
    
    func sendBotMessage(text: String, _ isTrue: Bool = false) {
        let message = Message(id: isTrue ? "thisistrue"+UUID().uuidString:UUID().uuidString, content: text, created: Timestamp(), senderID: botID, senderName: "봇")
        
        insertNewMessage(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        // Cells are reused, so only add a button here once. For real use you would need to
        // ensure any subviews are removed if not needed
        
        
        accessoryView.subviews.forEach { $0.removeFromSuperview() }
        accessoryView.backgroundColor = .clear
        
        if message.messageId.contains("thisistrue") {
            let button = UIButton(type: .infoLight)
            button.tintColor = UIColor(hex: "333333")
            accessoryView.addSubview(button)
            button.frame = accessoryView.bounds
            button.addTarget(self, action: #selector(click), for: .touchUpInside)
            accessoryView.layer.cornerRadius = accessoryView.frame.height / 2
            accessoryView.backgroundColor = .clear
        }
        
    }
    
    @objc func click() {
        let alert = UIAlertController(title: "신고하기", message: "해당 유저를 신고하는 이유를 알려주세요", preferredStyle: .alert)
        let yes1Button = UIAlertAction(title: "욕설", style: .destructive) { action in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.view.makeToast("신고 처리가 완료되었습니다", duration: 3.0, position: .top)
            }
            
        }
        let yes2Button = UIAlertAction(title: "도배", style: .destructive) { action in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.view.makeToast("신고 처리가 완료되었습니다", duration: 3.0, position: .top)
            }
        }
        let noButton = UIAlertAction(title: "취소", style: .cancel) { action in
            print("no clicked")
        }
        alert.addAction(yes1Button)
        alert.addAction(yes2Button)
        alert.addAction(noButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func sendAnon1Message(text: String, _ isTrue: Bool = false) {
        let message = Message(id: isTrue ? "thisistrue"+UUID().uuidString:UUID().uuidString, content: text, created: Timestamp(), senderID: participant1, senderName: "익명1")
        
        insertNewMessage(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    func sendAnon2Message(text: String, _ isTrue: Bool = false) {
        let message = Message(id: isTrue ? "thisistrue"+UUID().uuidString:UUID().uuidString, content: text, created: Timestamp(), senderID: participant2, senderName: "익명2")
        
        insertNewMessage(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func bot() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WarningViewController") as! WarningViewController
            vc.delegate = self
            vc.representNeeded = true
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
            
            switch message.content {
            case "#챗봇":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    let alert = UIAlertController(title: "챗봇 호출", message: "원하시는 기능을 선택하세요", preferredStyle: .actionSheet)
                    let yes1Button = UIAlertAction(title: "규칙 다시보기", style: .default) { action in
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WarningViewController") as! WarningViewController
                            vc.delegate = self
                            vc.representNeeded = false
                            self.present(vc, animated: true, completion: nil)
                        }
                        
                    }
                    let yes2Button = UIAlertAction(title: "더 높은 선호도의 톡방으로 이동", style: .default) { action in
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            self.view.makeToast("해당 기사에 대한 만족도가 평균 93%인 톡방으로 이동합니다", duration: 3.0, position: .top)
                            
                            if let nav = self.navigationController {
                                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InterventionViewController") as! InterventionViewController
                                nav.pushViewController(vc, animated: true)
                            }
                            
                        }
                    }
                    let yes3Button = UIAlertAction(title: "더 낮은 선호도의 톡방으로 이동", style: .default) { action in
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            self.view.makeToast("해당 기사에 대한 만족도가 평균 28%인 톡방으로 이동합니다", duration: 3.0, position: .top)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+3.5) {
                                if let nav = self.navigationController {
                                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InterventionViewController") as! InterventionViewController
                                    nav.pushViewController(vc, animated: true)
                                }
                            }
                        }
                    }
                    let noButton = UIAlertAction(title: "취소", style: .cancel) { action in
                        print("no clicked")
                    }
                    alert.addAction(yes1Button)
                    alert.addAction(yes2Button)
                    alert.addAction(yes3Button)
                    alert.addAction(noButton)
                    self.present(alert, animated: true, completion: nil)
                }
            case "1":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "어느 참여자를 신고하시겠습니까?")
                }
                
            case "익명2":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "어떤 이유로 신고하시는지 적어주세요")
                }
            case "도배":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "신고 감사합니다. 익명2의 메시지는 숨김 처리 되었습니다.")
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
        case participant1: return .systemGray5
        case participant2: return .systemGray5
        case participant3: return .systemGray5
        default: return UIColor(hex: "B6E3D8")
        }
    }
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        switch message.sender.senderId {
        case experimentID: return .white
        case participant1: return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        case participant2: return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        case participant3: return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        default: return UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        switch message.sender.senderId {
        case experimentID: avatarView.initials = "나"
        case participant1: avatarView.initials = "익명1"
        case participant2: avatarView.initials = "익명2"
        case participant3: avatarView.initials = "익명3"
        default: avatarView.image = UIImage(named: "chatbot_profile")
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
        
    }
    
}

