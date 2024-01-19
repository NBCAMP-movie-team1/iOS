//
//  SignUserView.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class SignUserView: UIView {
    
    // MARK: - UI Properties

    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LogoImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 100 * 1.5).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40 * 1.5).isActive = true
        
        return imageView
    }()
    
    let usernameTextField: UITextField = {
        let textField = GrayTextField()
        textField.leftLabelText = "ID"
        textField.placeholder = "아이디를 입력하세요"
        
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = GrayTextField()
        textField.leftLabelText = "PW"
        textField.placeholder = "비밀번호를 입력하세요"
        textField.isSecureTextEntry = true
        return textField
    }()

    let loginButton: UIButton = {
        let button = PointButton(title: "로그인")
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return button
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

extension SignUserView {
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        let usernameStackView = UIStackView(arrangedSubviews: [logoImageView, usernameTextField])
        usernameStackView.axis = .vertical
        usernameStackView.spacing = 100
        
        let stackView = UIStackView(arrangedSubviews: [usernameStackView, passwordTextField, loginButton, signUpButton])
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
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}
