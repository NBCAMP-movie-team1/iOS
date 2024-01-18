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
    
    let signUserView = SignUserView()
    
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
        guard let username = signUserView.usernameTextField.text,
              let password = signUserView.passwordTextField.text else {
            return
        }

        // 여기에서 UserModel을 사용하여 로그인을 처리하는 로직을 작성
        if true {
            // 로그인 성공 시에 다음 로직을 추가할 수 있습니다.
            print("로그인 성공")
        } else {
            // 로그인 실패 처리
            print("로그인 실패")
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
        
//        signUserView.button.addTarget(self, action: #selector(goToMovieListButton), for: .touchUpInside)
        
        signUserView.button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUserView.button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(signUserView)
        
        signUserView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUserView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            signUserView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUserView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUserView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}
