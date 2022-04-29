//
//  NewWorkoutViewController.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 27.04.2022.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let newWorkoutLabel: UILabel = {
       let label = UILabel()
        label.text = "NEW WORKOUT"
        label.textAlignment = .center
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.tintColor = .specialGreen
        button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel = UILabel(text: "Name")
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialBrown
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let dateAndRepeatLabel = UILabel(text: "Date and repeat")
    
//    private let dateAndRepeatView: UIView = {
//       let view = UIView()
//        view.layer.cornerRadius = 10
//        view.backgroundColor = .specialBrown
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private let repsOrTimerLabel = UILabel(text: "Reps or timer")
    
//    private let repsOrTimerView: UIView = {
//       let view = UIView()
//        view.layer.cornerRadius = 10
//        view.backgroundColor = .specialBrown
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.tintColor = .white
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.addTarget(self, action: #selector(saveTraining), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let dateAndRepeatView = DateAndRepeatView()
    private let repsOrTimerView = RepsOrTimerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .specialBackground
        
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    @objc private func saveTraining() {
        dismiss(animated: true)
    }
    
    @objc private func closeVC() {
        dismiss(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(newWorkoutLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(dateAndRepeatLabel)
        scrollView.addSubview(dateAndRepeatView)
        scrollView.addSubview(repsOrTimerLabel)
        scrollView.addSubview(repsOrTimerView)
        scrollView.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            newWorkoutLabel.heightAnchor.constraint(equalToConstant: 25),
            newWorkoutLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
     
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            dateAndRepeatLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 14),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            dateAndRepeatLabel.heightAnchor.constraint(equalToConstant: 16),
            dateAndRepeatLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            dateAndRepeatView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor, constant: 1),
            dateAndRepeatView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateAndRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateAndRepeatView.heightAnchor.constraint(equalToConstant: 93)
        ])
    
        NSLayoutConstraint.activate([
            repsOrTimerLabel.topAnchor.constraint(equalTo: dateAndRepeatView.bottomAnchor, constant: 20),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            repsOrTimerLabel.heightAnchor.constraint(equalToConstant: 16),
            repsOrTimerLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            repsOrTimerView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 1),
            repsOrTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsOrTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: 310)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: repsOrTimerView.bottomAnchor, constant: 14),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
    
}
