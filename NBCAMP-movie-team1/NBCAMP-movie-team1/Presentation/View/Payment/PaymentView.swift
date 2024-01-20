//
//  PaymentView.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

protocol PaymentViewDelegate: AnyObject {
    func didTapOKButton()
}

class PaymentView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: PaymentViewDelegate?
    private var price: Int = 10000
    
    // MARK: - UI Properties
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 15
        
        [firstRowStack(), secondRowStack(), thirdRowStack(), fourthRowStack()].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = MovieSectionLabel(text: "제목")
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = MovieSectionLabel(text: "날짜")
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    private lazy var numberOfPeopleTitleLabel: UILabel = MovieSectionLabel(text: "인원")
    
    private lazy var numberOfPeopleLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var peopleStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = 1
        
        return stepper
    }()
    
    private lazy var amountTitleLabel: UILabel = MovieSectionLabel(text: "금액")
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var paymentButton: UIButton = PointButton(title: "결제하기")
    
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

// MARK: - UI and Layout

extension PaymentView {
    private func setUI() {
        self.backgroundColor = .white
        peopleStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        paymentButton.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
    }
    
    private func setLayout() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        [posterImageView, contentStackView, paymentButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        self.addSubview(stackView)
        
        setAutoLayout(stackView)
    }
    
    private func setAutoLayout(_ stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            posterImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3),
            posterImageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            peopleStepper.widthAnchor.constraint(equalToConstant: 100),
            peopleStepper.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

// MARK: - Data Setting

extension PaymentView {
    func setMovieInfo(_ data: MovieInfo) {
        ImageLoader.loadImage(from: "https://image.tmdb.org/t/p/w500\(data.posterPath!)", into: self.posterImageView)
        self.movieTitleLabel.text = data.title
        self.amountLabel.text = String(describing: price)
    }
    
    private func updateNumberOfPeopleLabel(value: Double) {
        numberOfPeopleLabel.text = "\(Int(value))"
        updateAmountLabel()
    }
    
    private func updateAmountLabel() {
        let numberOfPeople = Int(peopleStepper.value)
        let amount = price * numberOfPeople
        amountLabel.text = "\(amount)"
    }
}

// MARK: - Action Methods

extension PaymentView {
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfPeopleLabel(value: sender.value)
    }
    
    @objc private func paymentButtonTapped() {
        let paymentInformation = collectPaymentInformation()
        showAlert(with: paymentInformation)
    }
}

// MARK: - Alert Helper Methods

extension PaymentView {
    func collectPaymentInformation() -> String {
        let title = movieTitleLabel.text ?? "-"
        let date = DateFormatter.localizedString(from: datePicker.date, dateStyle: .medium, timeStyle: .short)
        let numberOfPeople = numberOfPeopleLabel.text ?? "1"
        let amount = amountLabel.text ?? "0"
        return "Title: \(title)\nDate: \(date)\nNumber of People: \(numberOfPeople)\nAmount: \(amount)"
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Payment Information", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.delegate?.didTapOKButton()
        }))
        
        if let viewController = findViewController() {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

// MARK: - StackView Helper Methods

extension PaymentView {
    private func firstRowStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        [titleLabel, movieTitleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
    
    private func secondRowStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        [dateLabel, datePicker].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
    
    private func thirdRowStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        
        [numberOfPeopleLabel, peopleStepper].forEach {
            stackView.addArrangedSubview($0)
        }
        
        let peopleStackView = UIStackView()
        peopleStackView.axis = .vertical
        peopleStackView.distribution = .fill
        [numberOfPeopleTitleLabel, stackView].forEach {
            peopleStackView.addArrangedSubview($0)
        }
        
        return peopleStackView
    }
    
    private func fourthRowStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        [amountTitleLabel, amountLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
}
