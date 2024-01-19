//
//  SignUpViewController.swift
//  loginTest
//
//  Created by t2023-m0051 on 1/16/24.
//

import UIKit


class SignUpViewController: UIViewController {
    
    // MARK: - UI Properties
    
    let signUpUserView = SignUpUserView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
}

// MARK: - Extensions

extension SignUpViewController {
    private func setUI() {
        view.backgroundColor = .white
            
        signUpUserView.signUpButton.addTarget(self , action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(signUpUserView)
        
        signUpUserView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpUserView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            signUpUserView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUpUserView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUpUserView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension SignUpViewController {
    @objc private func signUpButtonTapped() {
        guard let username = signUpUserView.usernameTextField.text,
              let nickname = signUpUserView.nicknameTextField.text,
              let password = signUpUserView.passwordTextField.text else {
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
        }
//        else {
//            // 회원가입이 실패했을 때
//            showSignUpFailureAlert()
//        }
        
    }
    
        private func showSignUpSuccessAlert() {
            let alertController = UIAlertController(title: "가입 완료", message: "회원가입이 성공적으로 완료되었습니다.", preferredStyle: .alert)
    
            let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                // Alert 창의 확인 버튼을 눌렀을 때 수행할 동작
                if let navigationController = self?.navigationController {
                    navigationController.popViewController(animated: true)
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
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
