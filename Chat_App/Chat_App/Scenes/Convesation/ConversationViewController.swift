//
//  ViewController.swift
//  Chat_App
//
//  Created by Gi Oo on 24.04.23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{

    // MARK: Properties
    private var topMessageHistoryView = MessageHistoryView()
    private var bottomChatHistoryView = MessageHistoryView()
    private var switchButtonView = SwitchButtonView()
    private var viewControllerModel = ViewControllerModel()
    private var statusBarStyle: UIStatusBarStyle = .darkContent
    private var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.dividerViewColor
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.startMonitoring()
        addSubviews()
        setUpLayoutConstraints()
        setUpSwitchButtonViewToggle()
        setUpInitialAppearance()
        addTapGestureRecognizer()
        setUpMessageViews()
    }

    //MARK: setUpMessageViews()
    private func setUpMessageViews() {
        loadAndRemoveMessages()
        configureSendMessageDelegates()
        configureDataSourceDelegates()
    }

    //MARK: loadAndRemoveMessages()
    private func loadAndRemoveMessages() {
       // viewControllerModel.removeMessages()
        viewControllerModel.loadMessages()
    }

    //MARK: configureSendMessageDelegates()
    private func configureSendMessageDelegates() {
        topMessageHistoryView.sendMessageDelegate = self
        bottomChatHistoryView.sendMessageDelegate = self
    }

    //MARK: configureDataSourceDelegates()
    private func configureDataSourceDelegates() {
        topMessageHistoryView.dataSourceDelegate(dataSource: self, delegate: self)
        bottomChatHistoryView.dataSourceDelegate(dataSource: self, delegate: self)
        viewControllerModel.delegate = self
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
           let currentDate = Date()
           let formattedDate = DateFormatter.formatCustomDate(currentDate)
           let userId = view == topMessageHistoryView ? 1 : 2
           viewControllerModel.sendMessages(with: text, userID: Int32(userId), date: formattedDate, isSent: NetworkManager.shared.isConnected)
           scrollToLastMessage(for: topMessageHistoryView)
           scrollToLastMessage(for: bottomChatHistoryView)
       }

       private func scrollToLastMessage(for view: MessageHistoryView) {
           let userId = view == topMessageHistoryView ? 1 : 2
           let messageCount = viewControllerModel.numberOfMessages(userId: userId)
           if messageCount > 0 {
               let lastIndexPath = IndexPath(row: messageCount - 1, section: 0)
               view.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
           }
       }
   }

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewControllerModel.numberOfMessages(userId: tableView == topMessageHistoryView.tableView ? 1 : 2)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell

        let userId = tableView == topMessageHistoryView.tableView ? 1 : 2
        let message = viewControllerModel.message(userId: userId, index: indexPath.row)

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
