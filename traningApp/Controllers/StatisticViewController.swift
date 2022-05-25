//
//  StatisticViewController.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 29.04.2022.
//

import UIKit

class StatisticViewController: UIViewController {

    private let statisticWorkoutLabel: UILabel = {
       let label = UILabel()
        label.text = "STATISTIC"
        label.textAlignment = .center
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let exercisesLabel = UILabel(text: "Exercises")
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .specialBackground
        tableView.separatorStyle = .singleLine
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let idStatisticTableViewCell = "idStatisticTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegate()
        tableView.register(StatisticTableViewCell.self, forCellReuseIdentifier: idStatisticTableViewCell)
        view.backgroundColor = .specialBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        view.addSubview(statisticWorkoutLabel)
        view.addSubview(exercisesLabel)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            statisticWorkoutLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            statisticWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statisticWorkoutLabel.heightAnchor.constraint(equalToConstant: 25),
            statisticWorkoutLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            exercisesLabel.topAnchor.constraint(equalTo: statisticWorkoutLabel.bottomAnchor, constant: 75),
            exercisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            exercisesLabel.heightAnchor.constraint(equalToConstant: 21),
            exercisesLabel.widthAnchor.constraint(equalToConstant: 120)
            
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: exercisesLabel.bottomAnchor, constant: 3),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
        ])
    
    }
}

extension StatisticViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticTableViewCell, for: indexPath) as! StatisticTableViewCell
        return cell
    }
    

}

extension StatisticViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}
