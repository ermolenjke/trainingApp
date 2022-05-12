//
//  TimerStartViewController.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 12.05.2022.
//

import UIKit

class TimerStartViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let startWorkoutLabel: UILabel = {
       let label = UILabel()
        label.text = "START WORKOUT"
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
    
    private let timerCircleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9294117647, blue: 0.8862745098, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named:"timerCircle")
//        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
//    private let detailsView: UIView = {
//           let view = UIView()
//            view.layer.cornerRadius = 10
//            view.backgroundColor = .specialBrown
//            view.translatesAutoresizingMaskIntoConstraints = false
//            return view
//        }()
    
    private let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.tintColor = .white
        button.setTitle("FINISH", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let detailsView = TimerDetailsView()
    var workoutModel = WorkoutModel()
    private var numberOfSet = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .specialBackground
        
        setupViews()
        setConstraints()
     
    }
    
    @objc private func closeVC() {
        dismiss(animated: true)
    }
    
    @objc private func finishButtonTapped() {
        
        
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(startWorkoutLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(timerCircleImageView)
        scrollView.addSubview(detailsLabel)
        scrollView.addSubview(detailsView)
        scrollView.addSubview(finishButton)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            startWorkoutLabel.heightAnchor.constraint(equalToConstant: 25),
            startWorkoutLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            timerCircleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 74),
            timerCircleImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 34),
            timerCircleImageView.heightAnchor.constraint(equalToConstant: 242),
            timerCircleImageView.widthAnchor.constraint(equalToConstant: 242)
            
        ])
        
        NSLayoutConstraint.activate([
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.topAnchor.constraint(equalTo: timerCircleImageView.bottomAnchor, constant: 26),
            detailsLabel.heightAnchor.constraint(equalToConstant: 21),
            detailsLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 0),
            detailsView.heightAnchor.constraint(equalToConstant: 248),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 13),
            finishButton.heightAnchor.constraint(equalToConstant: 55),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            finishButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
        
        
    }
    
}
