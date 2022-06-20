//
//  TimerStartViewController.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 12.05.2022.
//

import UIKit

class TimerStartWorkoutViewController: UIViewController {
   
    

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
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let ellipseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9294117647, blue: 0.8862745098, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named:"timerCircle")
//        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timerLabel: UILabel = {
       let label = UILabel()
        label.text = "01:30"
        label.textAlignment = .center
        label.textColor = .specialBlack
        label.font = .robotoBold48()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    

    
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
    private var numberOfSet = 0
    let customAlert = CustomAlert()
    let shapeLayer = CAShapeLayer()
    
    var timer = Timer()
    var durationTimer = 10
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .specialBackground
        
        setupViews()
        setConstraints()
        setWorkoutParameters()
        setDelegates()
        addTaps()
    }
    
    private func setDelegates() {
        detailsView.cellNextSetDelegate = self
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
        timer.invalidate()
    }
    
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel, bool: true)
        } else {
            alertOkCancel(title: "Warning", message: "You haven't finished your workout") {
                self.dismiss(animated: true)
            }
        }
        timer.invalidate()
    }
    
    private func setWorkoutParameters() {
        detailsView.workoutNameLabel.text = workoutModel.workoutName
        detailsView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        
        let (min, sec) = workoutModel.workoutTimer.convertSeconds()
        detailsView.remainingTimeLabel.text = "\(min) min \(sec) sec"
        
        timerLabel.text = "\(min):\(sec.setZeroForSeconds())"
        durationTimer = workoutModel.workoutTimer
    }
    
    private func addTaps() {
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(tapLabel)
    }
    
    @objc private func startTimer() {
        
        detailsView.editWorkoutButton.isEnabled = false
        detailsView.nextSetButton.isEnabled = false
        
        if numberOfSet == workoutModel.workoutSets {
            alertOk(title: "Error", message: "Finish your workout")
        } else {
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    @objc private func timerAction() {
        durationTimer -= 1
        print(durationTimer)
        
        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = workoutModel.workoutTimer
            
            numberOfSet += 1
            detailsView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
            
            detailsView.editWorkoutButton.isEnabled = true
            detailsView.nextSetButton.isEnabled = true
        }
        
        let (min, sec) = durationTimer.convertSeconds()
        timerLabel.text = "\(min):\(sec.setZeroForSeconds())"
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(startWorkoutLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(ellipseImageView)
        scrollView.addSubview(detailsLabel)
        scrollView.addSubview(timerLabel)
        scrollView.addSubview(detailsView)
        scrollView.addSubview(finishButton)
    }
    
}
 
extension TimerStartWorkoutViewController {
    
    private func animationCircular() {
        
        let center = CGPoint(x: ellipseImageView.frame.width / 2, y: ellipseImageView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 135, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.specialGreen.cgColor
        ellipseImageView.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}

    extension TimerStartWorkoutViewController {
    
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
            ellipseImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            ellipseImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ellipseImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            ellipseImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: ellipseImageView.leadingAnchor, constant: 40),
            timerLabel.trailingAnchor.constraint(equalTo: ellipseImageView.trailingAnchor, constant: -40),
            timerLabel.centerYAnchor.constraint(equalTo: ellipseImageView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.topAnchor.constraint(equalTo: ellipseImageView.bottomAnchor, constant: 26),
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

extension TimerStartWorkoutViewController: NextSetTimerProtocol {

    
    func nextSetTimerTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            detailsView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOk(title: "Error", message: "Finish your workout")
        }
    }

    func editingTimerTapped() {
        customAlert.alertCustom(viewController: self, repsOrTimer: "Timer of set") { [self] sets, timerOfset in

            if sets != "" && timerOfset != "" {
                guard let numberOfSets = Int(sets) else { return }
                guard let numberOfTimer = Int(timerOfset) else { return }
                let (min, sec) = numberOfTimer.convertSeconds()
                detailsView.numberOfSetsLabel.text = "\(numberOfSet)/\(sets)"
                detailsView.timeOfSetLabel.text = "\(min) min \(sec) sec"
                timerLabel.text = "\(min):\(sec.setZeroForSeconds())"
                durationTimer = numberOfTimer
                RealmManager.shared.updateSetsTimerWorkoutModel(model: workoutModel, sets: numberOfSets, timer: numberOfTimer)
            }
        }
    }
}
