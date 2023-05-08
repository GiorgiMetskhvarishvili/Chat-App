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
  private let placeHolder: String
  private let sendButtonImageName: String

  // MARK: - Initializers

  init(placeHolder: String, sendButtonImageName: String) {
    self.placeHolder = placeHolder
    self.sendButtonImageName = sendButtonImageName
    super.init(frame: .zero)
    setUpViews()
    setUpLayoutConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setups

  private func setUpViews() {
    setUpContainerView()
    setUpTextView()
    setUpButton()
  }

  private func setUpContainerView() {
    containerView.layer.borderWidth = ContainerViewConstants.containerBorderWidth
    containerView.layer.borderColor = AppColors.containerBorderColor.cgColor
    containerView.layer.cornerRadius = ContainerViewConstants.containerCornerRadius
    containerView.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setUpTextView() {
    textView.text = placeHolder
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.isScrollEnabled = true
    textView.textColor = .lightGray
    textView.font = .systemFont(ofSize: ContainerViewConstants.textViewFontSize)
    textView.delegate = self
    textView.backgroundColor = UIColor.clear
    containerView.addSubview(textView)
  }

  private func setUpButton() {
    button.setImage(UIImage(named: sendButtonImageName), for: .normal)
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
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ContainerViewConstants.containerLeadingPadding),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ContainerViewConstants.containerTrailingPadding),

      textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ContainerViewConstants.textViewtopLeadingPadding),
      textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: ContainerViewConstants.textViewbottomPadding),
      textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ContainerViewConstants.textViewtopLeadingPadding),
      textView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: ContainerViewConstants.textViewtrailingPadding),
      //textView.heightAnchor.constraint(greaterThanOrEqualToConstant: textView.font!.lineHeight * 5),


      button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: ContainerViewConstants.sendButtonBottomPadding),
      button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: ContainerViewConstants.containerTrailingPadding),
      button.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      button.heightAnchor.constraint(equalToConstant: ContainerViewConstants.sendButtonWidthAndHeight),
      button.widthAnchor.constraint(equalToConstant: ContainerViewConstants.sendButtonWidthAndHeight),
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
          textView.text = placeHolder
          textView.textColor = .lightGray
      }
  }
}
