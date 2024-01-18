//
//  SignUpViewController.swift
//  loginTest
//
//  Created by t2023-m0051 on 1/16/24.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력하세요"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력하세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력하세요"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let signUpButton: UIButton = {
        let button =  PointButton(title: "회원가입")
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [usernameTextField, nicknameTextField, passwordTextField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    @objc private func signUpButtonTapped() {
        guard let username = usernameTextField.text,
              let nickname = nicknameTextField.text,
              let password = passwordTextField.text else {
            return
        }

        // 여기에서 UserModel을 사용하여 회원가입을 처리하는 로직을 작성
        UserModel.username = username
        UserModel.nickname = nickname
        UserModel.password = password

        // 가입이 성공했다고 가정
        let signUpSuccessful = true

        if signUpSuccessful {
            // 회원가입이 성공했을 때
            showSignUpSuccessAlert()
        } else {
            // 회원가입이 실패했을 때
            showSignUpFailureAlert()
        }
        
    }
    

    private func showSignUpSuccessAlert() {
        let alertController = UIAlertController(title: "가입 완료", message: "회원가입이 성공적으로 완료되었습니다.", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            // Alert 창의 확인 버튼을 눌렀을 때 수행할 동작
            self?.dismiss(animated: true, completion: nil) // 현재 뷰 컨트롤러를 닫음 (pop)
        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }

    private func showSignUpFailureAlert() {
        let alertController = UIAlertController(title: "가입 실패", message: "회원가입 중에 문제가 발생했습니다.", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}
