//
//  ViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/15/24.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI Properties

    lazy var movieListViewController = MovieListViewController()
    
    let signUserView = SignInUserView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        
    }
    
}

// MARK: - Extensions

extension MainViewController {
    @objc private func goToMovieListButton() {
        self.navigationController?.pushViewController(movieListViewController, animated: true)
    }
    
    @objc func loginButtonTapped() {
        guard let inputUsername = signUserView.usernameTextField.text,
              let inputPassword = signUserView.passwordTextField.text else {
            return
        }

        let savedUsername = UserDefaults.standard.string(forKey: "username")
        let savedPassword = UserDefaults.standard.string(forKey: "password")

        // 아이디와 비밀번호가 모두 저장되어 있을 때만 비교합니다.
        if let savedUsername = savedUsername, let savedPassword = savedPassword {
            // 로그인을 처리하는 로직
            if savedUsername == inputUsername && savedPassword == inputPassword  {
                print("로그인 성공")
                self.navigationController?.pushViewController(movieListViewController, animated: true)
            } else {
                let alertController = UIAlertController(title: "로그인 실패", message: "아이디 또는 비밀번호가 일치하지 않습니다.", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alertController.addAction(okAction)

                present(alertController, animated: true, completion: nil)
            }
        }

    }

    @objc func signUpButtonTapped() {
        // 회원가입 버튼이 눌렸을 때의 동작을 여기에 추가
        print("signUpButtonTapped called")
        let signUpViewController = SignUpViewController()
        
        // 생성한 SignUpViewController를 현재 뷰 컨트롤러에 푸시 또는 모달로 표시
        // 예시로는 네비게이션 컨트롤러를 사용하여 푸시하는 방법을 보여줍니다.
        if let navigationController = self.navigationController {
            navigationController.pushViewController(signUpViewController, animated: true)
        } else {
            // 네비게이션 컨트롤러가 없는 경우, 모달로 표시
            self.present(signUpViewController, animated: true, completion: nil)
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
            
        signUserView.loginButton.addTarget(self , action: #selector(loginButtonTapped), for: .touchUpInside)
        signUserView.signUpButton.addTarget(self , action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(signUserView)
        
        signUserView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUserView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            signUserView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUserView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUserView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    
    
}
