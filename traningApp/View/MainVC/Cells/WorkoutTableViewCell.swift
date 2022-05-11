//
//  WorkoutTableViewCell.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 25.04.2022.
//

import UIKit

protocol StartWorkoutProtocol: AnyObject {
    
    func startButtonTapped(model:WorkoutModel)
    
}

class WorkoutTableViewCell: UITableViewCell {
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9294117647, blue: 0.8862745098, alpha: 1)
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named:"pullUpsImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
//        button.setTitle("START", for: .normal)
        button.titleLabel?.font = .robotoBold16()
//        button.tintColor = .specialDarkGreen
//        button.backgroundColor = .specialYellow
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let setsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets: 2"
        label.font = .robotoMedium14()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: 10"
        label.font = .robotoMedium14()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutName: UILabel = {
        let label = UILabel()
        label.text = "Pull Ups"
        label.font = .robotoMedium24()
        label.textColor = .specialBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let backgroundCell: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let exerciseBackgroundView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var labelStackView = UIStackView()
    var workoutModel = WorkoutModel()
    weak var cellStartWorkoutDelegate: StartWorkoutProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(backgroundCell)
        addSubview(exerciseBackgroundView)
        addSubview(exerciseImageView)
        contentView.addSubview(startButton)
        addSubview(workoutName)
//        addSubview(repsLabel)
//        addSubview(setsLabel)
        
        labelStackView = UIStackView(arrangedSubviews: [repsLabel,setsLabel], axis: .horizontal, spacing: 10)
        
        addSubview(labelStackView)
        
    }
    
    @objc private func startButtonTapped() {
        
        cellStartWorkoutDelegate?.startButtonTapped(model: workoutModel)
        
    }
    
    
    func cellConfigure(model: WorkoutModel) {
        workoutModel = model

        workoutName.text = model.workoutName
        
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs / 60, secs % 60)}(model.workoutTimer)
        
        repsLabel.text = (model.workoutTimer == 0 ? "Reps: \(model.workoutReps)" : "Timer: \(min) min \(sec) sec")
        setsLabel.text = "Sets: \(model.workoutSets)"
        
        guard let imageData = model.workoutImage else { return }
        guard let image = UIImage(data: imageData) else { return }
        exerciseImageView.image = image
        
        if model.status {
            startButton.setTitle("COMPLETE", for: .normal)
            startButton.tintColor = .white
            startButton.backgroundColor = .specialGreen
            startButton.isEnabled = false
        } else {
            startButton.setTitle("START", for: .normal)
            startButton.tintColor = .specialDarkGreen
            startButton.backgroundColor = .specialYellow
            startButton.isEnabled = true
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            exerciseBackgroundView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            exerciseBackgroundView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor,constant: 8),
            exerciseBackgroundView.heightAnchor.constraint(equalToConstant: 75),
            exerciseBackgroundView.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            exerciseImageView.topAnchor.constraint(equalTo: exerciseBackgroundView.topAnchor,constant: 7),
            exerciseImageView.leadingAnchor.constraint(equalTo: exerciseBackgroundView.leadingAnchor, constant: 10),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 63),
            exerciseImageView.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10),
            startButton.leadingAnchor.constraint(equalTo: exerciseBackgroundView.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor,constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 29),
        ])
        
        NSLayoutConstraint.activate([
            workoutName.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            workoutName.leadingAnchor.constraint(equalTo: exerciseBackgroundView.trailingAnchor, constant: 10),
            workoutName.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -100),
            workoutName.heightAnchor.constraint(equalToConstant: 26)
            
        ])
        
//        NSLayoutConstraint.activate([
//            repsLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -2),
//            repsLabel.leadingAnchor.constraint(equalTo: exerciseBackgroundView.trailingAnchor, constant: 10),
//            repsLabel.heightAnchor.constraint(equalToConstant: 19),
//            repsLabel.heightAnchor.constraint(equalToConstant: 65)
//        ])
//
//        NSLayoutConstraint.activate([
//            setsLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -2),
//            setsLabel.leadingAnchor.constraint(equalTo: repsLabel.trailingAnchor, constant: 10),
//            setsLabel.heightAnchor.constraint(equalToConstant: 19),
//            setsLabel.heightAnchor.constraint(equalToConstant: 65)
//
//        ])
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: workoutName.bottomAnchor, constant: 0),
            labelStackView.leadingAnchor.constraint(equalTo: exerciseBackgroundView.trailingAnchor, constant: 10),
            labelStackView.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
}
