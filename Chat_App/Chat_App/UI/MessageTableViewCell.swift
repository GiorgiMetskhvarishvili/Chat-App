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
    label.text = "18:25"
    label.font = UIFont.systemFont(ofSize: DateLabelConstants.fontSize)
    return label
  }()

  private let chatBubble: UIView = {
    let bubble = UIView()
    bubble.layer.cornerRadius = 25
    bubble.layer.masksToBounds = true
    bubble.backgroundColor = .lightGray
    return bubble
  }()

  private let middleBubble: UIView = {
    let bubble = UIView()
    bubble.layer.cornerRadius = 12
    bubble.layer.masksToBounds = true
    bubble.backgroundColor = .lightGray
    return bubble
  }()

  private let smallBubble: UIView = {
    let bubble = UIView()
    bubble.layer.cornerRadius = 10
    bubble.layer.masksToBounds = true
    bubble.backgroundColor = .lightGray
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

  func configure(with item: String) {
    messageLabel.text = item
  }

  // MARK: Setup

  private func setupViews() {
    backgroundColor = .clear
    setUpBubbles()
    setUpMessageLabel()
    setUpDateLabel()
    setUpLayoutConstraints()
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
    messageLabel.font = UIFont.systemFont(ofSize: 16)
    messageLabel.textColor = .black
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setUpDateLabel() {
    contentView.addSubview(dateLabel)
    dateLabel.font = UIFont.systemFont(ofSize: 12)
    dateLabel.textColor = .lightGray
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
  }

  // MARK: - Layout Constraints

  private func setUpLayoutConstraints() {
    setUpSmallBubbleConstraints()
    setUpMiddleBubbleConstraints()
    setUpChatBubbleConstraints()
    setUpMessageLabelConstraints()
    setUpDateLabelConstraints()
  }

  private func setUpSmallBubbleConstraints() {
    NSLayoutConstraint.activate([
      smallBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SmallBubbleConstants.leadingAnchor),
      smallBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: SmallBubbleConstants.bottomAnchor),
      smallBubble.widthAnchor.constraint(equalToConstant: SmallBubbleConstants.widthHeightAnchor),
      smallBubble.heightAnchor.constraint(equalToConstant: SmallBubbleConstants.widthHeightAnchor)
    ])
  }

  private func setUpMiddleBubbleConstraints() {
    NSLayoutConstraint.activate([
      middleBubble.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: MiddleBubbleConstants.leadingAnchor),
      middleBubble.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: MiddleBubbleConstants.bottomAnchor),
      middleBubble.widthAnchor.constraint(equalToConstant: MiddleBubbleConstants.widthHeightAnchor),
      middleBubble.heightAnchor.constraint(equalToConstant: MiddleBubbleConstants.widthHeightAnchor)
    ])
  }

  private func setUpChatBubbleConstraints() {
    NSLayoutConstraint.activate([
      chatBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ChatBubbleConstans.topAnchor),
      chatBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ChatBubbleConstans.leadingAnchor),
    ])
  }

  private func setUpMessageLabelConstraints() {
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: chatBubble.topAnchor, constant: MessageLabelConstants.topAnchor),
      messageLabel.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: MessageLabelConstants.leadingAnchor),
      messageLabel.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: MessageLabelConstants.trailingAnchor),
      messageLabel.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: MessageLabelConstants.bottomAnchor),
    ])
  }

  private func setUpDateLabelConstraints() {
    NSLayoutConstraint.activate([
      dateLabel.topAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: DateLabelConstants.topAnchor),
      dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DateLabelConstants.leadingAnchor),
      dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: DateLabelConstants.bottomAnchor),
    ])
  }
}

// MARK: MessageTableViewCellcConstants Extension
private extension MessageTableViewCell {

  enum ChatBubbleConstans {
    static let topAnchor: CGFloat = 5
    static let leadingAnchor: CGFloat = 30
  }

  enum MessageLabelConstants {
    static let topAnchor: CGFloat = 16
    static let leadingAnchor: CGFloat = 16
    static let trailingAnchor: CGFloat = -16
    static let bottomAnchor: CGFloat = -16
    static let numberOfLines = 0
  }

  enum MiddleBubbleConstants {
    static let leadingAnchor: CGFloat = -4
    static let bottomAnchor: CGFloat = 2
    static let widthHeightAnchor: CGFloat = 24
  }

  enum SmallBubbleConstants {
    static let leadingAnchor: CGFloat = 10
    static let bottomAnchor: CGFloat = -20
    static let widthHeightAnchor: CGFloat = 18
  }

  enum DateLabelConstants {
    static let topAnchor: CGFloat = 5
    static let leadingAnchor: CGFloat = 50
    static let bottomAnchor: CGFloat = -16
    static let fontSize: CGFloat = 12
  }
}
