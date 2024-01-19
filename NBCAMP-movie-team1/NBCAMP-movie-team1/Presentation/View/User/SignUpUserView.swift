//
//  SignUpUserView.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/19/24.
//


import UIKit

class SignUpUserView: UIView {
    
    // MARK: - UI Properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LogoImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 40 * 1.5)
        ])
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        
        return label
    }()
    
    let nicknameTextField: UITextField = {
        let textField = GrayTextField()
        textField.leftLabelText = "USER"
        textField.placeholder = "닉네임을 입력하세요"
        
        return textField
    }()
    
    let usernameTextField: UITextField = {
        let textField = GrayTextField()
        textField.leftLabelText = "ID"
        textField.placeholder = "아이디를 입력하세요"
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = GrayTextField()
        textField.leftLabelText = "PWD"
        textField.placeholder = "비밀번호를 입력하세요"
        textField.isSecureTextEntry = true
        
        return textField
    }()

    let signUpButton: UIButton = {
        let button = PointButton(title: "회원가입")
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions

extension SignUpUserView {
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        let usernameStackView = UIStackView(arrangedSubviews: [logoImageView, nicknameTextField])
        usernameStackView.axis = .vertical
        usernameStackView.spacing = 100
        
        let stackView = UIStackView(arrangedSubviews: [usernameStackView, usernameTextField, passwordTextField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)
        
        setAutoLayout(stackView)
    }

    // MARK: - Auto Layout

    private func setAutoLayout(_ stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
        ])
    }
}
