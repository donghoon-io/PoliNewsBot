//
//  TestViewController.swift
//  NewsFeedBot
//
//  Created by Donghoon Shin on 2021/05/07.
//

import UIKit
import InputBarAccessoryView
import FirebaseFirestore
import MessageKit
import IQKeyboardManagerSwift

class TestViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
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
        
        bot()
    }
    
    func sendBotMessage(text: String) {
        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: botID, senderName: "봇")
        
        insertNewMessage(message)
        
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func bot() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.sendBotMessage(text: "안녕하세요! 저는 오늘 여러분들의 정치성향을 바탕으로 뉴스기사를 추천해드릴 NewsBot이라고 합니다:)")
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                self.sendBotMessage(text: "여러분은 총 10개의 퀴즈에서 본인의 선호 선지를 선택하고, 이를 바탕으로 비슷한 정치 성향의 사람들이 즐겨찾는 기사를 추천받게 됩니다")
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    self.sendBotMessage(text: "먼저, 본인의 이름을 입력해주세요")
                }
            }
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
            
            if message.content == "신동훈" {
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    self.sendBotMessage(text: "안녕하세요, 신동훈님!")
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                        self.sendBotMessage(text: "자, 그럼 지금부터 퀴즈를 시작하겠습니다")
                    }
                }
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
