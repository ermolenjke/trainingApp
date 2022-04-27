//
//  WorkoutTableViewCell.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 25.04.2022.
//

import UIKit

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
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .specialDarkGreen
        button.backgroundColor = .specialYellow
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
    
    private let exerciseLabel: UILabel = {
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
        addSubview(exerciseImageView)
        addSubview(startButton)
        addSubview(exerciseLabel)
        addSubview(repsLabel)
        addSubview(setsLabel)
        
    }
    
    @objc private func startButtonTapped() {
        print(#function)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            exerciseImageView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            exerciseImageView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor,constant: 8),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 75),
            exerciseImageView.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 29),
            startButton.widthAnchor.constraint(equalToConstant: 254)
        ])
        
        NSLayoutConstraint.activate([
            exerciseLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            exerciseLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
            exerciseLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -100),
            exerciseLabel.heightAnchor.constraint(equalToConstant: 26)
            
        ])
        
        NSLayoutConstraint.activate([
            repsLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -2),
            repsLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
            repsLabel.heightAnchor.constraint(equalToConstant: 19),
            repsLabel.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            setsLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -2),
            setsLabel.leadingAnchor.constraint(equalTo: repsLabel.trailingAnchor, constant: 10),
            setsLabel.heightAnchor.constraint(equalToConstant: 19),
            setsLabel.heightAnchor.constraint(equalToConstant: 65)
            
        ])
        
    }
}
