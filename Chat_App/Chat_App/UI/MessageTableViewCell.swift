//
//  MessageTableViewCell.swift
//  Chat_App
//
//  Created by Gi Oo on 01.05.23.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {

  let containerView = UIView()
  let messageLabel = UILabel()
  let timeLabel = UILabel()

  static let reuseIdentifier = "MessageTableViewCell"

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
}

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

  private func setupViews() {
    addSubview(containerView)
    containerView.addSubview(messageLabel)
    containerView.addSubview(timeLabel)
    containerView.backgroundColor = .clear

    messageLabel.numberOfLines = 0
    messageLabel.font = UIFont.systemFont(ofSize: 16)
    messageLabel.textColor = .black
    messageLabel.text = "როგორ ხარ"

    timeLabel.font = UIFont.systemFont(ofSize: 12)
    timeLabel.textColor = .gray
    timeLabel.text = "12:34"

    containerView.backgroundColor = .lightGray
    containerView.layer.cornerRadius = 25
    containerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    containerView.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
      messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      messageLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 0),

      timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 18),
      timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18),
      timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
    ])
  }

  override func awakeFromNib() {
    super.awakeFromNib()
}

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
