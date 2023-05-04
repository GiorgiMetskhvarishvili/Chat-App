//
//  TypinComponentView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

class TypingComponentView: UIView {

  // MARK: - Properties

  private lazy var containerView = UIView()
  private lazy var textView = UITextView()
  private lazy var button = UIButton()
  private var typingComponentModel: TypingComponentModel?

  // MARK: - Initializers

  init(typingComponentModel: TypingComponentModel) {
    self.typingComponentModel = typingComponentModel
    super.init(frame: .zero)
    setUpViews()
    setUpLayoutConstraints()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setUpViews()
    setUpLayoutConstraints()
  }

  // MARK: - Setups

  private func setUpViews() {
    setUpContainerView()
    setUpTextView()
    setUpButton()
  }

  private func setUpContainerView() {
    containerView.layer.borderWidth = 1.0
    containerView.layer.borderColor = UIColor(red: 0.62, green: 0.38, blue: 1.00, alpha: 1.00).cgColor
    containerView.layer.cornerRadius = 28
    containerView.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setUpTextView() {
    textView.text = typingComponentModel?.placeHolder
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.isScrollEnabled = true
    //  textView.textContainer.lineBreakMode = .byWordWrapping
    textView.textColor = .lightGray
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.delegate = self
    textView.backgroundColor = UIColor.clear
    containerView.addSubview(textView)
  }

  private func setUpButton() {
    button.setImage(UIImage(named: typingComponentModel!.sendButtonImageName), for: .normal)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(button)
  }

  private func updateTextViewHeight() {
    let maxNumberOfLines = 5
    let maxHeight = textView.font!.lineHeight * CGFloat(maxNumberOfLines)
    let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: maxHeight))
    if size.height <= maxHeight {
      textView.isScrollEnabled = false
      containerView.heightAnchor.constraint(equalToConstant: size.height + 20).isActive = true
    } else {
      textView.isScrollEnabled = true
      containerView.heightAnchor.constraint(equalToConstant: maxHeight + 20).isActive = true
    }
    textView.frame.size.height = min(maxHeight, size.height)
  }

  @objc private func buttonTapped() {
    textView.text = ""
  }

  // MARK: - Layout Constraints

  private func setUpLayoutConstraints() {
    addSubview(containerView)
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

      textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
      textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      textView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -5),
      textView.heightAnchor.constraint(greaterThanOrEqualToConstant: textView.font!.lineHeight * 5),

      // button.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
      button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
      button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
      button.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      button.heightAnchor.constraint(equalToConstant: 32),
      button.widthAnchor.constraint(equalToConstant: 32),
    ])
  }
}

// MARK: - UITextViewDelegate

extension TypingComponentView: UITextViewDelegate {

  func textViewDidChange(_ textView: UITextView) {
    updateTextViewHeight()
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = nil
      textView.textColor = .black
    }
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = typingComponentModel?.placeHolder
      textView.textColor = .lightGray
    }
  }
}
