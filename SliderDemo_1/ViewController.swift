//
//  ViewController.swift
//  SliderDemo_1
//
//  Created by Ravshan Winter on 15/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let sliderData: [SliderItem] = [
        .init(color: .brown, title: "Cosmic Whispers", 
              text: "Whispers of stardust danced in the moonlight, weaving tales only the cosmos could comprehend.",
              animationName: "animation_1"),
        .init(color: .orange, title: "Chronicles of the Ancient Clock",
              text: "The ancient clock sighed, its gears echoing the forgotten rhythms of a bygone era.",
              animationName: "animation_2"),
        .init(color: .gray, title: "Neon Dreams",
              text: "Neon dreams flickered in the city's embrace, where echoes of yesterday collided with the pulse of tomorrow.",
              animationName: "animation_3")
    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(SliderCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView;
    }()
    
    lazy var skipButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        return btn
    }()
    
    lazy var hStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        return stack
    }()
    
    lazy var nextBtn: UIView = {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right.circle.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    private var pagers: [UIView] = []
    private var currentSlide = 0
    private var widthConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        setupSlideControl()
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        view.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupSlideControl() {
        let pagerStack = UIStackView()
        pagerStack.axis = .horizontal
        pagerStack.spacing = 5
        pagerStack.alignment = .center
        pagerStack.distribution = .fill
        
        for tag in 1...sliderData.count {
            let pager = UIView()
            pager.tag = tag
            pager.layer.cornerRadius = 5
            pager.backgroundColor = .white
            pager.translatesAutoresizingMaskIntoConstraints = false
            self.pagers.append(pager)
            pagerStack.addArrangedSubview(pager)
        }
        
        vStack.addArrangedSubview(pagerStack)
        vStack.addArrangedSubview(skipButton)
        
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(nextBtn)
    }
    
    @IBAction func nextSlide(sender: UIButton) {
        
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sliderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SliderCell
        else { return UICollectionViewCell() }
        let item = sliderData[indexPath.item]
        cell.textLabel.text = item.text
        cell.titleLabel.text = item.title
        cell.contentView.backgroundColor = sliderData[indexPath.item].color
        //cell.setupAnimation(animationName: item.animationName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSlide = indexPath.item
        pagers.forEach { page in
            page.constraints.forEach { constraint in
                page.removeConstraint(constraint)
            }
            
            let tag = page.tag
            let viewTag = indexPath.row + 1
            if viewTag == tag {
                page.layer.opacity = 1
                widthConstraint = page.widthAnchor.constraint(equalToConstant: 20)
            } else {
                page.layer.opacity = 0.5
                widthConstraint = page.widthAnchor.constraint(equalToConstant: 10)
            }
            widthConstraint?.isActive = true
            page.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
    }
}

struct SliderItem {
    let color: UIColor
    let title: String
    let text: String
    let animationName: String
}
