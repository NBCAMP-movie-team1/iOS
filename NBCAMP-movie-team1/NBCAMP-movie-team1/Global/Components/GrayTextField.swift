//
//  GrayTextField.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/18/24.
//

import UIKit

final class GrayTextField: UITextField {
    var leftLabelText: String? {
        didSet {
            leftLabel.text = leftLabelText
        }
    }
    
    override var placeholder: String? {
        didSet {
            attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        }
    }
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTextField()
    }
    
    private func configureTextField() {
        borderStyle = .none
        backgroundColor = .systemGray5
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        layer.cornerRadius = 20
        
        configureLeftView()
        configureRightView()
    }
    
    private func configureLeftView() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: frame.height))
        
        leftLabel.text = leftLabelText
        leftView.addSubview(leftLabel)
        
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 20),
            leftLabel.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -15),
            leftLabel.topAnchor.constraint(equalTo: leftView.topAnchor),
            leftLabel.bottomAnchor.constraint(equalTo: leftView.bottomAnchor)
        ])
        
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    private func configureRightView() {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.height))
        self.rightView = rightView
        self.rightViewMode = .always
    }
}
