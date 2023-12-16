//
//  SliderCell.swift
//  SliderDemo_1
//
//  Created by Ravshan Winter on 15/12/23.
//

import UIKit
import Lottie

class SliderCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let textLabel = UILabel()
    
    private let lottieView = LottieAnimationView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSlider() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func setupAnimation(animationName: String) {
        contentView.addSubview(lottieView)
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.animation = LottieAnimation.named(animationName)
        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            lottieView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lottieView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lottieView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lottieView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        lottieView.play()
    }
}
