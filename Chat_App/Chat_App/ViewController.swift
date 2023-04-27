//
//  ViewController.swift
//  Chat_App
//
//  Created by Gi Oo on 24.04.23.
//

import UIKit

class ViewController: UIViewController {

  let maxNumberOfLines = 5
  let maxHeight: CGFloat = 130
  let userDefaults = UserDefaults.standard


  override func viewDidLoad() {
    super.viewDidLoad()

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let viewHeight: CGFloat = 6


    let view = UIView(frame: CGRect(x: 0, y: (screenHeight - viewHeight) / 2, width: screenWidth, height: viewHeight))
    view.backgroundColor = UIColor(red: 0.97, green: 0.81, blue: 0.50, alpha: 1.00)

    self.view.addSubview(view)

    let textView = UITextView(frame: CGRect(x: 16, y: view.frame.origin.y - 70, width: screenWidth - 32, height: 50))
    textView.layer.borderWidth = 1.0
    textView.layer.borderColor = CGColor(red: 0.62, green: 0.38, blue: 1.00, alpha: 1.00)
    textView.layer.cornerRadius = 23
    textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.isScrollEnabled = false
    textView.delegate = self
    textView.textAlignment = .left
    textView.setContentOffset(CGPoint.zero, animated: false)
    textView.text = " დაწერე შეტყობინება..."
    textView.textColor = UIColor.lightGray
    textView.translatesAutoresizingMaskIntoConstraints = false


    self.view.addSubview(textView)
    self.view.addSubview(view)



    let textView2 = UITextView(frame: CGRect(x: 16, y: screenHeight - 30 - 50, width: screenWidth - 32, height: 50))
    textView2.layer.borderWidth = 1.0
    textView2.layer.borderColor = CGColor(red: 0.62, green: 0.38, blue: 1.00, alpha: 1.00)
    textView2.layer.cornerRadius = 23
    textView2.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    textView2.font = UIFont.systemFont(ofSize: 16)
    textView2.isScrollEnabled = false
    textView2.delegate = self
    textView2.textAlignment = .left
    textView2.setContentOffset(CGPoint.zero, animated: false)
    textView2.text = " დაწერე შეტყობინება..."
    textView2.textColor = UIColor.lightGray

    self.view.addSubview(textView2)

    let switchView = UISwitch(frame: CGRect(x: screenWidth - 70, y: 40, width: 0, height: 0))
    switchView.addTarget(self, action: #selector(themeChanged(_:)), for: .valueChanged)
    self.view.addSubview(switchView)


    let sendButton = UIButton(type: .custom)
        let sendButtonImage = UIImage(named: "SendButton")
        sendButton.frame = CGRect(x: screenWidth - 60, y: view.frame.origin.y - 70 + 8, width: 32, height: 32)
        sendButton.setImage(sendButtonImage, for: .normal)
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        self.view.addSubview(sendButton)

    let secondSendButton = UIButton(type: .custom)
    let secondSendButtonImage = UIImage(named: "SendButton")
    secondSendButton.frame = CGRect(x: screenWidth  - 60, y: screenHeight - 50 - 22, width: 32, height: 32)
    secondSendButton.setImage(secondSendButtonImage, for: .normal)
    secondSendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    self.view.addSubview(secondSendButton)
  }

  @objc func themeChanged(_ sender: UISwitch) {
    if sender.isOn {
      self.view.backgroundColor = UIColor.black
      self.navigationController?.navigationBar.barStyle = .black
      self.tabBarController?.tabBar.barStyle = .black
    } else {

      self.view.backgroundColor = UIColor.white
      self.navigationController?.navigationBar.barStyle = .default
      self.tabBarController?.tabBar.barStyle = .default
    }
  }

  @objc func sendMessage() {
      guard let textView = view.subviews.first(where: { $0 is UITextView }) as? UITextView else {
          return
      }

      let message = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
      guard !message.isEmpty else {
          // Don't send an empty message
          return
      }

      // Perform your sending logic here

      // Clear the textView after sending
      textView.text = ""
      textView.textColor = UIColor.black
      textViewDidChange(textView)
  }

  func textViewDidChange(_ textView: UITextView) {
    let maxHeightOffset: CGFloat = 20
    let originalHeight = textView.frame.height
    let size = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
    var newFrame = textView.frame
    if size.height > maxHeight {
      newFrame.size.height = maxHeight - maxHeightOffset
      textView.isScrollEnabled = true
    } else {
      newFrame.size.height = size.height
      textView.isScrollEnabled = false
    }
    let delta = newFrame.size.height - originalHeight
    newFrame.origin.y -= delta
    textView.frame = newFrame
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
      if textView.text == " დაწერე შეტყობინება..." {
          textView.text = ""
          textView.textColor = UIColor.black
      }
  }
}



extension ViewController: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
    return newText.count <= 2000
  }
}
