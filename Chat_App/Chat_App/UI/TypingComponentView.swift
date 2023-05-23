//
//  TypinComponentView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

class TypingComponentView: UIView {

    // MARK: - Properties
    private var heightConstraint: NSLayoutConstraint? = nil

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = Constants.containerBorderWidth
        view.layer.borderColor = AppColors.containerBorderColor
        view.layer.cornerRadius = Constants.containerCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = Constants.placeholderText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: Constants.textViewFontSize)
        textView.delegate = self
        textView.backgroundColor = UIColor.clear
        return textView
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.sendButtonImageName), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        updateTextViewHeight()
        setUpSubviews()
        setUpLayoutConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups
    private func setUpSubviews() {
        addSubview(containerView)
        containerView.addSubview(button)
        containerView.addSubview(textView)
    }

    func setUpTextView(with color: UIColor) {
        textView.textColor = color
    }




    // MARK: - Layout Constraints
    private func setUpLayoutConstraints() {
        setUpContainerViewLayoutConstraints()
        setUpTextViewLayoutConstraints()
        setUpButtonLayoutConstraints()
    }

    private func setUpContainerViewLayoutConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.containerLeadingPadding),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.containerTrailingPadding),
            containerView.heightAnchor.constraint(lessThanOrEqualToConstant: Constants.containerViewMaxHeigth)
        ])
    }

    private func setUpTextViewLayoutConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.textViewtopLeadingPadding),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.textViewbottomPadding),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.textViewtopLeadingPadding),
            textView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: Constants.textViewtrailingPadding)
        ])
    }

    private func setUpButtonLayoutConstraints() {
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.sendButtonBottomPadding),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.containerTrailingPadding),
            button.heightAnchor.constraint(equalToConstant: Constants.sendButtonWidthAndHeight),
            button.widthAnchor.constraint(equalToConstant: Constants.sendButtonWidthAndHeight)
        ])
    }

    // MARK: Actions
    private func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: textView.frame.width, height: CGFloat(Float.infinity))
        let font = textView.font ?? .systemFont(ofSize: Constants.textViewFontSize)
        let charSize = font.lineHeight
        let text = (textView.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }

    private func updateTextViewHeight() {
        if calculateMaxLines() > Constants.maxLineNubmer {
            if heightConstraint != nil { return }
            heightConstraint = containerView.heightAnchor.constraint(equalToConstant: containerView.frame.height)
            heightConstraint?.isActive = true
            textView.isScrollEnabled = true
        } else {
            textView.isScrollEnabled = false

            if let heightConstraint {
                heightConstraint.isActive = false
                containerView.removeConstraint(heightConstraint)
                containerView.layoutIfNeeded()
                textView.layoutIfNeeded()
                layoutIfNeeded()
            }
            heightConstraint = nil
        }
    }

    @objc private func buttonTapped() {
        textView.text = ""
    }
}

// MARK: - UITextViewDelegate
extension TypingComponentView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        self.updateTextViewHeight()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constants.placeholderText
            textView.textColor = .lightGray
        }
    }
}
// MARK: ContainerViewConstants Extension
private extension TypingComponentView {
    enum Constants {
        static let containerCornerRadius: CGFloat = 28
        static let containerBorderWidth: CGFloat = 1
        static let containerbottomPadding: CGFloat = 30
        static let containerLeadingPadding: CGFloat = 16
        static let containerTrailingPadding: CGFloat = -16
        static let containerTopAndBottomPadding: CGFloat = 16
        static let containerViewMaxHeigth:  CGFloat = 120

        static let sendButtonWidthAndHeight: CGFloat = 32
        static let sendButtonTrailingPadding: CGFloat = -12
        static let sendButtonBottomPadding: CGFloat = -12

        static let textViewtopLeadingPadding: CGFloat = 10
        static let textViewbottomPadding: CGFloat = -10
        static let textViewtrailingPadding: CGFloat = -5
        static let textViewFontSize: CGFloat = 16
        static let placeholderText: String = "დაწერე შეტყობინება..."
        static let sendButtonImageName: String = "SendButton"

        static let maxLineNubmer: Int = 5
    }
}


