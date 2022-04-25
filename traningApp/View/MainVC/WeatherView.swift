//
//  WeatherView.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 25.04.2022.
//

import UIKit

class WeatherView: UIView {
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Солнечно"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.font = .robotoMedium14()
        label.textColor = #colorLiteral(red: 0.8044065833, green: 0.8044064641, blue: 0.8044064641, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImage: UIImageView = {
          let image = UIImageView()
          image.backgroundColor = .white
          image.image = UIImage(named:"sunny")
          image.layer.cornerRadius = 3
          image.translatesAutoresizingMaskIntoConstraints = false
          return image
      }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        addShadowOnView()
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weatherLabel)
        addSubview(weatherImage)
        addSubview(descriptionWeatherLabel)
    }
    
}

extension WeatherView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            weatherLabel.heightAnchor.constraint(equalToConstant: 21),
        ])
        
        NSLayoutConstraint.activate([
            descriptionWeatherLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 5),
            descriptionWeatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionWeatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -80),
            descriptionWeatherLabel.heightAnchor.constraint(equalToConstant: 31)
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: topAnchor,constant: 7),
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            weatherImage.heightAnchor.constraint(equalToConstant: 62),
            weatherImage.widthAnchor.constraint(equalToConstant: 62)
        ])
    }
}
