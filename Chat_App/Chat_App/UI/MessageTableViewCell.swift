//
//  MessageTableViewCell.swift
//  Chat_App
//
//  Created by Gi Oo on 01.05.23.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = MessageLabelConstants.numberOfLines
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = DateLabelConstants.labelText
        label.font = UIFont.systemFont(ofSize: DateLabelConstants.fontSize)
        return label
    }()

    private let chatBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = ChatBubbleConstants.cornerRadius
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = ChatBubbleConstants.backgroundColor
        return bubble
    }()

    private let middleBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = MiddleBubbleConstants.cornerRadius
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = MiddleBubbleConstants.backgroundColor
        return bubble
    }()

    private let smallBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = SmallBubbleConstants.cornerRadius
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = SmallBubbleConstants.backgroundColor
        return bubble
    }()

    static let reuseIdentifier = "MessageTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with message: Message, bubble: Bubble) {
        messageLabel.text = message.text
        switch bubble {
        case .left:
            setUpLeftBubbleLayoutConstraints()
        case .right:
            setUpRightBubbleLayoutConstraints()
            setUpSecondBubbleColor()
        }
    }

    func setUpSecondBubbleColor() {
        chatBubble.backgroundColor = chatBubbleConstraints2.backgroundColor
        middleBubble.backgroundColor = middleBubblConstaints2.backgroundColor
        smallBubble.backgroundColor = smallBubbleConstraints2.backgroundColor
    }

    // MARK: Setup
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        setUpBubbles()
        setUpMessageLabel()
        setUpDateLabel()
    }

    private func setUpBubbles() {
        contentView.addSubview(chatBubble)
        contentView.addSubview(middleBubble)
        contentView.addSubview(smallBubble)
        chatBubble.translatesAutoresizingMaskIntoConstraints = false
        middleBubble.translatesAutoresizingMaskIntoConstraints = false
        smallBubble.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUpMessageLabel() {
        chatBubble.addSubview(messageLabel)
        messageLabel.font = MessageLabelConstants.messageLabelFontSize
        messageLabel.textColor = .black
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUpDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.font = DateLabelConstants.dateLabelFontSize
        dateLabel.textColor = .lightGray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func setUpLeftBubbleLayoutConstraints() {
        setUpLeftSmallBubbleConstraints()
        setUpLeftMiddleBubbleConstraints()
        setUpLeftChatBubbleConstraints()
        setUpLeftMessageLabelConstraints()
        setUpLeftDateLabelConstraints()
    }

    func setUpRightBubbleLayoutConstraints() {
        setUpRightSmallBubbleConstraints()
        setUpRightMiddleBubbleConstraints()
        setUpRightChatBubbleConstraints()
        setUpRightMessageLabelConstraints()
        setUpRightDateLabelConstraints()
    }

    private func setUpRightSmallBubbleConstraints() {
        NSLayoutConstraint.activate([
            smallBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: smallBubbleConstraints2.trailing),
            smallBubble.topAnchor.constraint(equalTo: middleBubble.bottomAnchor, constant: smallBubbleConstraints2.topAnchor),
            smallBubble.widthAnchor.constraint(equalToConstant: smallBubbleConstraints2.widthHeight),
            smallBubble.heightAnchor.constraint(equalToConstant: smallBubbleConstraints2.widthHeight)
        ])
    }

    private func setUpRightMiddleBubbleConstraints() {
        NSLayoutConstraint.activate([
            middleBubble.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: middleBubblConstaints2.trailing),
            middleBubble.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: middleBubblConstaints2.bottom),
            middleBubble.widthAnchor.constraint(equalToConstant: middleBubblConstaints2.width),
            middleBubble.heightAnchor.constraint(equalToConstant: middleBubblConstaints2.height),
        ])
    }

    private func setUpRightChatBubbleConstraints() {
        NSLayoutConstraint.activate([
            chatBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: chatBubbleConstraints2.top),
            chatBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: chatBubbleConstraints2.trailing),
            chatBubble.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: chatBubbleConstraints2.bottom),
            chatBubble.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: chatBubbleConstraints2.lessThanOrEqualTo)
        ])
    }

    private func setUpRightMessageLabelConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: chatBubble.topAnchor, constant: messageLabelConstrains2.top),
            messageLabel.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: messageLabelConstrains2.trailing),
           // messageLabel.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: messageLabelConstrains2.bottom),
            messageLabel.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: messageLabelConstrains2.leading)
        ])
    }

    private func setUpRightDateLabelConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: dateLabelConstraints2.top),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: dateLabelConstraints2.trailing),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: dateLabelConstraints2.bottom),
        ])
    }

    private func setUpLeftSmallBubbleConstraints() {
        NSLayoutConstraint.activate([
            smallBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SmallBubbleConstants.leadingAnchor),
            smallBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: SmallBubbleConstants.bottomAnchor),
            smallBubble.widthAnchor.constraint(equalToConstant: SmallBubbleConstants.widthHeightAnchor),
            smallBubble.heightAnchor.constraint(equalToConstant: SmallBubbleConstants.widthHeightAnchor)
        ])
    }

    private func setUpLeftMiddleBubbleConstraints() {
        NSLayoutConstraint.activate([
            middleBubble.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: MiddleBubbleConstants.leadingAnchor),
            middleBubble.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: MiddleBubbleConstants.bottomAnchor),
            middleBubble.widthAnchor.constraint(equalToConstant: MiddleBubbleConstants.widthHeightAnchor),
            middleBubble.heightAnchor.constraint(equalToConstant: MiddleBubbleConstants.widthHeightAnchor)
        ])
    }

    private func setUpLeftChatBubbleConstraints() {
        NSLayoutConstraint.activate([
            chatBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ChatBubbleConstants.topAnchor),
            chatBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ChatBubbleConstants.leadingAnchor),
            chatBubble.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: ChatBubbleConstants.lessThanOrEqualTo)
        ])
    }

    private func setUpLeftMessageLabelConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: chatBubble.topAnchor, constant: MessageLabelConstants.topAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: MessageLabelConstants.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: MessageLabelConstants.trailingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: MessageLabelConstants.bottomAnchor),
        ])
    }

    private func setUpLeftDateLabelConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: DateLabelConstants.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DateLabelConstants.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: DateLabelConstants.bottomAnchor),
        ])
    }
}

// MARK: Constants
private extension MessageTableViewCell {

    enum ChatBubbleConstants {
        static let topAnchor: CGFloat = 5
        static let leadingAnchor: CGFloat = 30
        static let cornerRadius: CGFloat = 25
        static let lessThanOrEqualTo: CGFloat = -30
        static let backgroundColor = UIColor(red: 241/255,
                                             green: 241/255,
                                             blue: 241/255,
                                             alpha: 1)
    }

    enum MessageLabelConstants {
        static let topAnchor: CGFloat = 16
        static let leadingAnchor: CGFloat = 16
        static let trailingAnchor: CGFloat = -16
        static let bottomAnchor: CGFloat = -16
        static let numberOfLines = 0
        static let messageLabelFontSize = UIFont.systemFont(ofSize: 16)
    }

    enum MiddleBubbleConstants {
        static let leadingAnchor: CGFloat = -4
        static let bottomAnchor: CGFloat = 2
        static let widthHeightAnchor: CGFloat = 22
        static let cornerRadius: CGFloat = 12
        static let backgroundColor = UIColor(red: 241/255,
                                             green: 241/255,
                                             blue: 241/255,
                                             alpha: 1)
    }

    enum SmallBubbleConstants {
        static let leadingAnchor: CGFloat = 10
        static let bottomAnchor: CGFloat = -20
        static let widthHeightAnchor: CGFloat = 15
        static let cornerRadius: CGFloat = 8
        static let backgroundColor = UIColor(red: 241/255,
                                             green: 241/255,
                                             blue: 241/255,
                                             alpha: 1)
    }

    enum DateLabelConstants {
        static let topAnchor: CGFloat = 5
        static let leadingAnchor: CGFloat = 50
        static let bottomAnchor: CGFloat = -16
        static let fontSize: CGFloat = 12
        static let labelText = "18:25"
        static let dateLabelFontSize = UIFont.systemFont(ofSize: 12)
    }

    //MARK: SenderBubbleConstraints
    enum smallBubbleConstraints2 {
        static let topAnchor: CGFloat = -5
        static let trailing: CGFloat = -10
        static let widthHeight: CGFloat = 15
        static let backgroundColor = UIColor(red: 218/255,
                                             green: 194/255,
                                             blue: 255/255,
                                             alpha: 1)
    }

    enum middleBubblConstaints2 {
        static let trailing: CGFloat = 4
        static let bottom: CGFloat = 4
        static let width: CGFloat = 22
        static let height: CGFloat = 22
        static let backgroundColor = UIColor(red: 218/255,
                                             green: 194/255,
                                             blue: 255/255,
                                             alpha: 1)
    }
    enum chatBubbleConstraints2 {
        static let top: CGFloat = 5
        static let trailing: CGFloat = -30
        static let bottom: CGFloat = 16
        static let lessThanOrEqualTo: CGFloat = 30
        static let backgroundColor = UIColor(red: 218/255,
                                             green: 194/255,
                                             blue: 255/255,
                                             alpha: 1)
    }

    enum messageLabelConstrains2 {
        static let top: CGFloat = 16
        static let bottom: CGFloat = 16
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16

    }

    enum dateLabelConstraints2 {
        static let top: CGFloat = 5
        static let trailing: CGFloat = -55
        static let bottom: CGFloat = -16
    }
}
