//
//  MessageTableViewCell.swift
//  Chat_App
//
//  Created by Gi Oo on 01.05.23.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {
  
  let messageLabel = UILabel()
  private let timeLabel = UILabel()
  
  static let reuseIdentifier = "MessageTableViewCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    addSubview(messageLabel)
    addSubview(timeLabel)
    backgroundColor = .blue
    
    messageLabel.numberOfLines = 0
    messageLabel.font = UIFont.systemFont(ofSize: 17)
    messageLabel.textColor = .black
    messageLabel.layer.cornerRadius = 24
    messageLabel.layer.masksToBounds = true
    
    timeLabel.font = UIFont.systemFont(ofSize: 12)
    timeLabel.textColor = .gray
    timeLabel.text = "12:34"
    
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      messageLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -4),
      
      timeLabel.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
      timeLabel.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor),
      timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
      timeLabel.heightAnchor.constraint(equalToConstant: 12)
    ])
  }
}

