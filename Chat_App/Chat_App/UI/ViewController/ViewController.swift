//
//  ViewController.swift
//  Chat_App
//
//  Created by Gi Oo on 24.04.23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    private lazy var topMessageHistoryView = MessageHistoryView()
    private lazy var bottomChatHistoryView = MessageHistoryView()
    private lazy var switchButtonView = SwitchButtonView()
    private var statusBarStyle: UIStatusBarStyle = .darkContent
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.dividerViewColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpLayoutConstraints()
        setUpSwitchButtonViewToggle()
        setUpInitialAppearance()
    }

    // MARK: - PreferredStatusBarStyle
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




