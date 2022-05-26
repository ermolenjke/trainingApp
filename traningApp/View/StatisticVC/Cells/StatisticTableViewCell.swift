//
//  StatisticTableViewCell.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 25.05.2022.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {

    private let exerciseLabel: UILabel = {
       let label = UILabel()
        label.text = "Biceps"
        label.textColor = .specialGray
        label.font = .robotoBold20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let beforeLabel = UILabel(text: "Before: 16")
    private let nowLabel = UILabel(text: "Now: 20")
    
    var labelStackView = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(exerciseLabel)
        labelStackView = UIStackView(arrangedSubviews: [beforeLabel, nowLabel], axis: .horizontal, spacing: 10)
        labelStackView.distribution = .equalSpacing
        addSubview(labelStackView)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            exerciseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            exerciseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            exerciseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            exerciseLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 1),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            labelStackView.widthAnchor.constraint(equalToConstant: 170),
            labelStackView.heightAnchor.constraint(equalToConstant: 21)
        ])
        
    }
    
}
