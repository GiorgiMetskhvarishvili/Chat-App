//
//  MessageTableViewCell.swift
//  Chat_App
//
//  Created by Gi Oo on 01.05.23.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {

    private var leftBubbleConstraints: [NSLayoutConstraint] = []
    private var rightBubbleConstraints: [NSLayoutConstraint] = []

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = LeftMessageLabelConstants.numberOfLines
        label.font = LeftMessageLabelConstants.messageLabelFontSize
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = LeftDateLabelConstants.dateLabelFontSize
        label.textColor = .lightGray
        return label
    }()

    private let chatBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = LeftChatBubbleConstants.cornerRadius
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = LeftChatBubbleConstants.backgroundColor
        return bubble
    }()

    private let middleBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = LeftMiddleBubbleConstants.cornerRadius
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = LeftMiddleBubbleConstants.backgroundColor
        return bubble
    }()

    private let smallBubble: UIView = {
        let bubble = UIView()
        bubble.layer.cornerRadius = LeftSmallBubbleConstants.cornerRadius
        bubble.layer.masksToBounds = true
        bubble.backgroundColor = LeftSmallBubbleConstants.backgroundColor
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

    func configure(with message: MessageEntity, bubble: Bubble) {
        messageLabel.text = message.text

        if message.isSent {
            dateLabel.text = message.date
            dateLabel.textColor = .lightGray
        }else{
            dateLabel.text = "aრ გაიგზავნა"
            dateLabel.textColor = .red
        }

        switch bubble {
        case .left:
            NSLayoutConstraint.deactivate(rightBubbleConstraints)
            NSLayoutConstraint.activate(leftBubbleConstraints)
            setUpLeftBubbleColor()
        case .right:
            NSLayoutConstraint.deactivate(leftBubbleConstraints)
            NSLayoutConstraint.activate(rightBubbleConstraints)
            setUpRightBubbleColor()
        }
    }

    private func setUpRightBubbleColor() {
        chatBubble.backgroundColor = RightChatBubbleConstraints.backgroundColor
        middleBubble.backgroundColor = RightMiddleBubblConstaints.backgroundColor
        smallBubble.backgroundColor = RightSmallBubbleConstraints.backgroundColor
    }

    private func setUpLeftBubbleColor() {
        chatBubble.backgroundColor = LeftChatBubbleConstants.backgroundColor
        middleBubble.backgroundColor = LeftMiddleBubbleConstants.backgroundColor
        smallBubble.backgroundColor = LeftSmallBubbleConstants.backgroundColor
    }

    // MARK: Setup
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        setUpBubbles()
        setUpDatelabel()
        setUpBubble()
    }

    private func setUpDatelabel() {
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUpBubbles() {
        contentView.addSubview(chatBubble)
        contentView.addSubview(middleBubble)
        contentView.addSubview(smallBubble)
        chatBubble.addSubview(messageLabel)
        chatBubble.translatesAutoresizingMaskIntoConstraints = false
        middleBubble.translatesAutoresizingMaskIntoConstraints = false
        smallBubble.translatesAutoresizingMaskIntoConstraints = false
    }

    func setUpBubble() {
        rightBubbleConstraints = [
            smallBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: RightSmallBubbleConstraints.trailing),
            smallBubble.topAnchor.constraint(equalTo: middleBubble.bottomAnchor, constant: RightSmallBubbleConstraints.topAnchor),
            smallBubble.widthAnchor.constraint(equalToConstant: RightSmallBubbleConstraints.widthHeight),
            smallBubble.heightAnchor.constraint(equalToConstant: RightSmallBubbleConstraints.widthHeight),

            middleBubble.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: RightMiddleBubblConstaints.trailing),
            middleBubble.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: RightMiddleBubblConstaints.bottom),
            middleBubble.widthAnchor.constraint(equalToConstant: RightMiddleBubblConstaints.width),
            middleBubble.heightAnchor.constraint(equalToConstant: RightMiddleBubblConstaints.height),

            chatBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: RightChatBubbleConstraints.top),
            chatBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: RightChatBubbleConstraints.trailing),
            chatBubble.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: RightChatBubbleConstraints.bottom),
            chatBubble.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: RightChatBubbleConstraints.lessThanOrEqualTo),

            dateLabel.topAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: RightDateLabelConstraints.top),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: RightDateLabelConstraints.trailing),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: RightDateLabelConstraints.bottom),

            messageLabel.topAnchor.constraint(equalTo: chatBubble.topAnchor, constant: RightMessageLabelConstrains.top),
            messageLabel.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: RightMessageLabelConstrains.trailing),
            messageLabel.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: RightMessageLabelConstrains.leading)
        ]

        leftBubbleConstraints = [
            smallBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LeftSmallBubbleConstants.leadingAnchor),
            smallBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LeftSmallBubbleConstants.bottomAnchor),
            smallBubble.widthAnchor.constraint(equalToConstant: LeftSmallBubbleConstants.widthHeightAnchor),
            smallBubble.heightAnchor.constraint(equalToConstant: LeftSmallBubbleConstants.widthHeightAnchor),

            middleBubble.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: LeftMiddleBubbleConstants.leadingAnchor),
            middleBubble.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: LeftMiddleBubbleConstants.bottomAnchor),
            middleBubble.widthAnchor.constraint(equalToConstant: LeftMiddleBubbleConstants.widthHeightAnchor),
            middleBubble.heightAnchor.constraint(equalToConstant: LeftMiddleBubbleConstants.widthHeightAnchor),

            messageLabel.topAnchor.constraint(equalTo: chatBubble.topAnchor, constant: LeftMessageLabelConstants.topAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: LeftMessageLabelConstants.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: LeftMessageLabelConstants.trailingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: LeftMessageLabelConstants.bottomAnchor),

            dateLabel.topAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: LeftDateLabelConstants.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LeftDateLabelConstants.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LeftDateLabelConstants.bottomAnchor),

            chatBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LeftChatBubbleConstants.topAnchor),
            chatBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LeftChatBubbleConstants.leadingAnchor),
            chatBubble.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: LeftChatBubbleConstants.lessThanOrEqualTo)
        ]
    }
}

// MARK: Constants
private extension MessageTableViewCell {

    enum LeftChatBubbleConstants {
        static let topAnchor: CGFloat = 5
        static let leadingAnchor: CGFloat = 30
        static let cornerRadius: CGFloat = 25
        static let lessThanOrEqualTo: CGFloat = -30
        static let backgroundColor = UIColor(red: 241/255,
                                             green: 241/255,
                                             blue: 241/255,
                                             alpha: 1)
    }

    enum LeftMessageLabelConstants {
        static let topAnchor: CGFloat = 16
        static let leadingAnchor: CGFloat = 16
        static let trailingAnchor: CGFloat = -16
        static let bottomAnchor: CGFloat = -16
        static let numberOfLines = 0
        static let messageLabelFontSize = UIFont.systemFont(ofSize: 16)
    }

    enum LeftMiddleBubbleConstants {
        static let leadingAnchor: CGFloat = -4
        static let bottomAnchor: CGFloat = 2
        static let widthHeightAnchor: CGFloat = 22
        static let cornerRadius: CGFloat = 12
        static let backgroundColor = UIColor(red: 241/255,
                                             green: 241/255,
                                             blue: 241/255,
                                             alpha: 1)
    }

    enum LeftSmallBubbleConstants {
        static let leadingAnchor: CGFloat = 10
        static let bottomAnchor: CGFloat = -20
        static let widthHeightAnchor: CGFloat = 15
        static let cornerRadius: CGFloat = 8
        static let backgroundColor = UIColor(red: 241/255,
                                             green: 241/255,
                                             blue: 241/255,
                                             alpha: 1)
    }

    enum LeftDateLabelConstants {
        static let topAnchor: CGFloat = 5
        static let leadingAnchor: CGFloat = 50
        static let bottomAnchor: CGFloat = -16
        static let fontSize: CGFloat = 12
        static let dateLabelFontSize = UIFont.systemFont(ofSize: 8)
    }

    //MARK: RightBubbleConstraints
    enum RightSmallBubbleConstraints {
        static let topAnchor: CGFloat = -5
        static let trailing: CGFloat = -10
        static let widthHeight: CGFloat = 15
        static let backgroundColor = UIColor(red: 218/255,
                                             green: 194/255,
                                             blue: 255/255,
                                             alpha: 1)
    }

    enum RightMiddleBubblConstaints {
        static let trailing: CGFloat = 4
        static let bottom: CGFloat = 4
        static let width: CGFloat = 22
        static let height: CGFloat = 22
        static let backgroundColor = UIColor(red: 218/255,
                                             green: 194/255,
                                             blue: 255/255,
                                             alpha: 1)
    }
    enum RightChatBubbleConstraints {
        static let top: CGFloat = 5
        static let trailing: CGFloat = -30
        static let bottom: CGFloat = 16
        static let lessThanOrEqualTo: CGFloat = 30
        static let backgroundColor = UIColor(red: 218/255,
                                             green: 194/255,
                                             blue: 255/255,
                                             alpha: 1)
    }

    enum RightMessageLabelConstrains {
        static let top: CGFloat = 16
        static let bottom: CGFloat = 16
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16

    }

    enum RightDateLabelConstraints {
        static let top: CGFloat = 5
        static let trailing: CGFloat = -50
        static let bottom: CGFloat = -16
    }
}
