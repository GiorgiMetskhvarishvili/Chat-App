//
//  ViewController.swift
//  Chat_App
//
//  Created by Gi Oo on 24.04.23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{

    // MARK: Properties
    private lazy var topMessageHistoryView = MessageHistoryView()
    private lazy var bottomChatHistoryView = MessageHistoryView()
    private lazy var switchButtonView = SwitchButtonView()
    private lazy var viewControllerModel = ViewControllerModel()
    private lazy var currentDate = Date()
    private lazy var formattedDate = DateFormatter.formatCustomDate(currentDate)
    private var statusBarStyle: UIStatusBarStyle = .darkContent
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.dividerViewColor
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpLayoutConstraints()
        setUpSwitchButtonViewToggle()
        setUpInitialAppearance()
        addTapGestureRecognizer()
        //chatViewModel.removeMessages()
        viewControllerModel.loadMessages()
        topMessageHistoryView.sendMessageDelegate = self
        bottomChatHistoryView.sendMessageDelegate = self
        viewControllerModel.delegate = self
        topMessageHistoryView.example(erti: self, ori: self)
        bottomChatHistoryView.example(erti: self, ori: self)
    }

    //MARK: - addTapGestureRecognizer
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    //MARK: - dismissKeyboard
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    //MARK: - PreferredStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // MARK: - SetUpInitialAppearance
    private func setUpInitialAppearance() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "AppTheme")
        updateAppearance(isDarkMode: isDarkMode)
    }
    
    // MARK: - SetUpMessageViewTextColor
    private func setUpMessageViewTextColor(with color: UIColor) {
        topMessageHistoryView.setUpTypingComponentView(with: color)
        bottomChatHistoryView.setUpTypingComponentView(with: color)
    }
    
    // MARK: - SetUpSwitchButtonViewToggle
    private func setUpSwitchButtonViewToggle() {
        switchButtonView.onToggle = { [weak self] isOn in
            UserDefaults.standard.set(isOn, forKey: "AppTheme")
            self?.updateAppearance(isDarkMode: isOn)
        }
    }
    
    private func updateAppearance(isDarkMode: Bool) {
        view.backgroundColor = isDarkMode ? AppColors.darkModeColor : .white
        switchButtonView.checkButtonState(isDarkMode: isDarkMode)
        statusBarStyle = isDarkMode ? .lightContent : .darkContent
        setUpMessageViewTextColor(with: isDarkMode ? .white : .black)
        setNeedsStatusBarAppearanceUpdate()
    }

    //MARK: Add Subviews
    private func addSubviews() {
        [topMessageHistoryView, dividerView, switchButtonView, bottomChatHistoryView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    // MARK: Layout constraint
    private func setUpLayoutConstraints() {
        [topMessageHistoryView, dividerView, bottomChatHistoryView, switchButtonView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        setUpTopMessageHistoryView()
        setUpTopbottomChatHistoryView()
        setUpdividerView()
        setUpswitchButtonView()
    }
    
    private func setUpTopMessageHistoryView() {
        NSLayoutConstraint.activate([
            topMessageHistoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: TopMessageHistoryViewConstants.topAnchor),
            topMessageHistoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topMessageHistoryView.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: TopMessageHistoryViewConstants.bottomAnchor),
            topMessageHistoryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setUpTopbottomChatHistoryView() {
        NSLayoutConstraint.activate([
            bottomChatHistoryView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
            bottomChatHistoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomChatHistoryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomChatHistoryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setUpdividerView() {
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: topMessageHistoryView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: DividerViewConstants.dividerHeightConstans),
            dividerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setUpswitchButtonView() {
        NSLayoutConstraint.activate([
            switchButtonView.bottomAnchor.constraint(equalTo: topMessageHistoryView.topAnchor),
            switchButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: SwitchButtonViewConstants.trailingAnchor),
            switchButtonView.widthAnchor.constraint(equalToConstant: SwitchButtonViewConstants.switchButtonWidth),
            switchButtonView.heightAnchor.constraint(equalToConstant: SwitchButtonViewConstants.switchButtonHeight),
        ])
    }
}

extension ViewController: ChatViewModelDelegate {
    func messagesLoaded() {
        topMessageHistoryView.tableView.reloadData()
        bottomChatHistoryView.tableView.reloadData()
    }
}

extension ViewController: SendMessageDelegate {
    func sendButton(with text: String, view: MessageHistoryView) {
        if view === topMessageHistoryView {
            viewControllerModel.sendMessages(with: text, userID: 1, date: formattedDate)
        } else if view === bottomChatHistoryView {
            viewControllerModel.sendMessages(with: text, userID: 2, date: formattedDate)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewControllerModel.numberOfMessages()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        let message = viewControllerModel.message(at: indexPath.row)

        var bubble: Bubble
        if message.userID == 1 {
            if tableView == topMessageHistoryView.tableView {
                bubble = .right
            } else {
                bubble = .left
            }
        } else {
            if tableView == topMessageHistoryView.tableView {
                bubble = .left
            } else {
                bubble = .right
            }
        }
        cell.configure(with: message, bubble: bubble)
        return cell
    }
}
