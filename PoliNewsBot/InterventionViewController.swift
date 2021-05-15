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

class InterventionViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, TagListViewDelegate {
    
    var displayName = "나"
    var experimentID = "hci_theory_and_practice"
    var botID = "bot_id"
    var participant1 = "participant1"
    var participant2 = "participant2"
    var participant3 = "participant3"
    
    var messages: [Message] = [
        Message(id: UUID().uuidString, content: "공수처가 너무 몸사리는 거 아닌가요? 공수처 설치 이유는 검찰이 못 건드릴 것 같은 권력을 정정당당하게 수사하기 위해서 잖아요", created: Timestamp(date: Date(timeIntervalSinceNow: -100)), senderID: "participant1", senderName: "익명1"),
        Message(id: UUID().uuidString, content: "처음부터 삐걱거리는 느낌이..피래미 말고 베스 잡으러 갑시다", created: Timestamp(date: Date(timeIntervalSinceNow: -100)), senderID: "participant2", senderName: "익명2"),
        Message(id: UUID().uuidString, content: "공수처 소속 검사가 13명 밖에 안되는군요.. 저 사람들도 사람인데 부담감이 컸을거라 생각됩니다. 이번 수사 잘 성과 내서 다음 수사에 힘을 얻을 수 있으면 좋겠네요.", created: Timestamp(date: Date(timeIntervalSinceNow: -100)), senderID: "participant3", senderName: "익명3")
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
    }
    
    func sendBotMessage(text: String) {
        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: botID, senderName: "봇")
        
        insertNewMessage(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func sendAnon1Message(text: String) {
        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: participant1, senderName: "익명1")
        
        insertNewMessage(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    func sendAnon2Message(text: String) {
        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: participant2, senderName: "익명2")
        
        insertNewMessage(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func bot() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.sendBotMessage(text: "(비밀메시지)\n'조희연 교육감 공수처 수사' 기사를 토의하고 있는 방에 들어오셨습니다.")
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                self.sendBotMessage(text: "(비밀메시지)\n현재 참가자의 66%는 공수처의 수사 행태를 비난하고 있고, 33%는 조희연 교육감를 문제삼는 의견을 보이고 있습니다.")
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    self.sendBotMessage(text: "(비밀메시지)\n다음과 같은 규칙을 지켜주세요:\n1. 욕설 금지\n2. 도배 금지")
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        self.sendAnon1Message(text: "그래도 첫 수사대상으로 설립 취지에 맞게 큰 권력을 건드는 상징적인 사건이었으면 좋았을텐데 좀 아쉽네요 ㅠㅠ 기대가 컸는데")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                            self.sendAnon2Message(text: "뭔소리임? 조희연ㅉㅉ이런 사람이 교육감인게 말이나 되냐")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                                self.sendAnon2Message(text: "그러면 교사가 정치질하는거 봐줘야하냐?")
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                                    self.sendAnon2Message(text: "왜 도대체 서울시민들 저런애를 뽑은거임??")
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now()+2.5) {
                                            self.sendBotMessage(text: "익명2님은 욕설/메시지 도배로 숨김처리 되었습니다.")
                                            
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now()+5.0) {
                                                    self.sendBotMessage(text: "다른 채팅룸에서는 해당기사에 대해\n#검찰개혁 #전교조\n라는 키워드로 대화를 나누고 있어요. 이에 대해 대화를 나눠보는건 어떨까요?")
                                                }
                                        }
                                }
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
            case "#챗봇":
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.sendBotMessage(text: "(비밀메시지)\n봇에게 명령하세요:\n1. 도배/욕설 신고하기\n2. 다른 채팅방 요약 보기")
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
        default: return .darkGray
        }
    }
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        switch message.sender.senderId {
        case experimentID: return .white
        case participant1: return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        case participant2: return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        case participant3: return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        default: return .white
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        switch message.sender.senderId {
        case experimentID: avatarView.initials = "나"
        case participant1: avatarView.initials = "익명1"
        case participant2: avatarView.initials = "익명2"
        case participant3: avatarView.initials = "익명3"
        default: avatarView.initials = "봇"
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
        
    }
    
}

