//
//  TimerDetailsView.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 12.05.2022.
//

import UIKit

protocol NextSetTimerProtocol: AnyObject {
    func nextSetTimerTapped()
    func editingTimerTapped()
}

class TimerDetailsView: UIView {

    let workoutNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Squats"
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let setsLabel: UILabel = {
       let label = UILabel()
        label.text = "Sets"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfSetsLabel: UILabel = {
       let label = UILabel()
        label.text = "1/4"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let timeOfSetLabel: UILabel = {
       let label = UILabel()
        label.text = "Time of set"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let remainingTimeLabel: UILabel = {
       let label = UILabel()
        label.text = "1 min 30 sec"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstRectangleView: UIView = {
        let view = UIView()
//        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.8110429645, green: 0.8110429049, blue: 0.8110428452, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let secondRectangleView: UIView = {
        let view = UIView()
//        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.8110429645, green: 0.8110429049, blue: 0.8110428452, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     let nextSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.tintColor = .specialGray
        button.setTitle("NEXT SET", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.layer.cornerRadius = 10
//        button.tintColor = .white
        button.addTarget(self, action: #selector(nextSetButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     let editWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "editingImage")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Editing", for: .normal)
        button.tintColor = .specialLightBrown
        button.titleLabel?.font = .robotoMedium16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editWorkoutButtonTapped), for: .touchUpInside)
        return button
    }()
    

    var setsStackView = UIStackView()
    var timeOfSetsStackView = UIStackView()
    
    weak var cellNextSetDelegate: NextSetTimerProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = .specialBrown
        translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func editWorkoutButtonTapped() {
        print(#function)
        
    }
    
    @objc private func nextSetButtonTapped() {
        
        print(#function)
        
    }
    
    private func setupViews() {
        
        addSubview(workoutNameLabel)
        setsStackView = UIStackView(arrangedSubviews: [setsLabel,
                                                       numberOfSetsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(setsStackView)
        
        timeOfSetsStackView = UIStackView(arrangedSubviews: [timeOfSetLabel,
                                                       remainingTimeLabel],
                                    axis: .horizontal,
                                    spacing: 91)
        addSubview(timeOfSetsStackView)
        addSubview(firstRectangleView)
        addSubview(secondRectangleView)
        addSubview(nextSetButton)
        addSubview(editWorkoutButton)
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            workoutNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            workoutNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            workoutNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 20),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            setsStackView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            firstRectangleView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 3),
            firstRectangleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            firstRectangleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            firstRectangleView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            timeOfSetsStackView.topAnchor.constraint(equalTo: firstRectangleView.bottomAnchor, constant: 25),
            timeOfSetsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timeOfSetsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            timeOfSetsStackView.heightAnchor.constraint(equalToConstant: 28)    

        ])
        
        NSLayoutConstraint.activate([
            secondRectangleView.topAnchor.constraint(equalTo: timeOfSetsStackView.bottomAnchor, constant: 3),
            secondRectangleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            secondRectangleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            secondRectangleView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            nextSetButton.topAnchor.constraint(equalTo: secondRectangleView.bottomAnchor, constant: 47),
            nextSetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            nextSetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            nextSetButton.heightAnchor.constraint(equalToConstant: 43)
        ])
        
        NSLayoutConstraint.activate([
            editWorkoutButton.topAnchor.constraint(equalTo: secondRectangleView.bottomAnchor, constant: 10),
            editWorkoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editWorkoutButton.heightAnchor.constraint(equalToConstant: 20),
            editWorkoutButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
    }
    
}



