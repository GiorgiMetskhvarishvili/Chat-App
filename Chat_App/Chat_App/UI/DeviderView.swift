//
//  DeviderView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//
import UIKit

class DividerView: UIView {

  // MARK: - Properties

  private let dividerView = UIView()
  private let viewHeight: CGFloat = 6.0

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setUp()
  }

  // MARK: - Setups

  private func setUp() {
    setUpDividerView()
    setUpLayoutConstraints()
  }

  private func setUpDividerView() {
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.backgroundColor = UIColor(red: 0.97, green: 0.81, blue: 0.50, alpha: 1.0)
  }

  // MARK: - Layout Constraints

  private func setUpLayoutConstraints() {
    addSubview(dividerView)
    NSLayoutConstraint.activate([
      dividerView.topAnchor.constraint(equalTo: topAnchor),
      dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      dividerView.heightAnchor.constraint(equalToConstant: viewHeight)
    ])
  }
}
