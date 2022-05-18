//
//  ViewController.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 20.04.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9086238146, green: 0.9385507703, blue: 0.7489966154, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    private let calendarView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .specialGreen
//        view.layer.cornerRadius = 10
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
//    private let weatherView: UIView = {
//          let view = UIView()
//          view.backgroundColor = .white
//          view.layer.cornerRadius = 10
//          view.addShadowOnView()
//          view.translatesAutoresizingMaskIntoConstraints = false
//          return view
//      }()
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Daniil Ermolenko"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Add workout", for: .normal)
        button.titleLabel?.font = .robotoMedium12()
        button.tintColor = .specialDarkGreen
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.setImage(UIImage(named: "addWorkout"), for: .normal)
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let workoutTodayLabel: UILabel = {
       let label = UILabel()
        label.text = "Workout today"
        label.textColor = #colorLiteral(red: 0.761189878, green: 0.7422975898, blue: 0.6815395951, alpha: 1)
        label.font = .robotoMedium14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.isHidden = true
        return tableView
    }()
    
    private let noWorkoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9294117647, blue: 0.8862745098, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named:"noTraining")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>! = nil
    
    
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegate()
        getWorkouts(date: Date())
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableViewCell)
        
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.cellCollectionViewDelegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weatherView)
        view.addSubview(workoutTodayLabel)
        view.addSubview(tableView)
        view.addSubview(noWorkoutImageView)
    }
   
//    @objc private func startButtonTapped() {
//
//        let startWorkoutViewController = StartWorkoutViewController()
//
//        present(startWorkoutViewController, animated: true, completion: nil)
//
//    }
    
    @objc private func addWorkoutButtonTapped() {
        let newWorkoutViewController = NewWorkoutViewController()
        newWorkoutViewController.modalPresentationStyle = .fullScreen
        present(newWorkoutViewController, animated: true, completion: nil)
        
    }
    
    private func getWorkouts(date: Date) {
        
//        let calendar = Calendar.current
//        let formatter = DateFormatter()
//        let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date)
//        guard let weekday = components.weekday else { return }
//        guard let day = components.day else { return }
//        guard let month = components.month else { return }
//        guard let year = components.year else { return }
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//
//        guard let dateStart = formatter.date(from: "\(year)/\(month)/\(day) 00:00") else { return }
//        let dateEnd: Date = {
//            let components = DateComponents(day: 1, second: -1)
//            return Calendar.current.date(byAdding: components, to: dateStart) ?? Date()
//        }()
        
        let dateTimeZone = date.localDate()
        let weekday = dateTimeZone.getWeekdayNumber()
        let dateStart = dateTimeZone.startEndDate().0
        let dateEnd = dateTimeZone.startEndDate().1
        
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeat = true")
        let predicateUnrepeate = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeate])
        
        workoutArray = localRealm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")
        tableView.reloadData()
        
    }
    
}

extension MainViewController: SelectCollectionViewProtocol {
    func selectItem(date: Date) {
        getWorkouts(date: date)
    }
    
    
}

extension MainViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableViewCell, for: indexPath) as! WorkoutTableViewCell
        let model = workoutArray[indexPath.row]
        cell.cellConfigure(model: model)
//        cell.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        cell.cellStartWorkoutDelegate = self
        return cell
    }
}

extension MainViewController: StartWorkoutProtocol {
    
    func startButtonTapped(model: WorkoutModel) {
        
        if model.workoutTimer == 0 {
            let startWorkoutViewController = RepsStartWorkoutViewController()
            startWorkoutViewController.modalPresentationStyle = .fullScreen
            startWorkoutViewController.workoutModel = model
            present(startWorkoutViewController, animated: true, completion: nil)
            
        } else {
            print("timer")
        }
        
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            let deleteModel = self.workoutArray[indexPath.row]
            RealmManager.shared.deleteWorkoutModel(model: deleteModel)
            tableView.reloadData()
        }
        
        action.backgroundColor = .specialBackground
        action.image = UIImage(named: "deleteImage")
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
}

extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            userNameLabel.heightAnchor.constraint(equalToConstant: 28),
            
        ])
        
        NSLayoutConstraint.activate([
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80)
            
        ])
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherView.heightAnchor.constraint(equalToConstant: 80)
            
        ])
        
        NSLayoutConstraint.activate([
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            workoutTodayLabel.heightAnchor.constraint(equalToConstant: 16),
            workoutTodayLabel.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            
            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            noWorkoutImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0)
            
        ])
        
        
    }
}
