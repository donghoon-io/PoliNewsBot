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
        messagesCollectionView.contentInset.top = 10
        
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
            self.sendBotMessage(text: "안녕하세요:) 저는 여러분들의 평가를 바탕으로 뉴스 기사를 분류하고 맞춤형 기사를 추천해드릴 NewsBot입니다")
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                self.sendBotMessage(text: "여러분이 관심 있는 이슈들에 대한 5개의 기사 요약문을 읽고 해당 기사에 대해 별점을 매겨주시면, 그것을 토대로 원하시는 조건에 맞는 기사를 추천해드릴게요!")
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    self.sendBotMessage(text: "먼저, 최근 이슈들 중 가장 관심 있는 이슈를 골라주세요:")
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        self.sendBotMessage(text: "1. LH 혁신위원회 출범\n2. 더불어민주당 경선 연기\n3. 도지코인\n4. 고 손정민 군 한강 사망 사건\n5. 김부겸 청문회\n6. 윤석헌 금감원장 퇴임\n7. 택배기사 노조 파업\n8. 한국교회 첫 여성목사")
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
