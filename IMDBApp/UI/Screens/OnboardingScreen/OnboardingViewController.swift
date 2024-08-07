//
//  OnboardingViewController.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 18.07.24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private var list: [OnboardingModel] = [
        .init(image: "onb1", title: "Register", subtitle: "Join us to discover the best movies and create your own personalized experience."),
        .init(image: "onb2", title: "Find the Movies", subtitle: "Explore a vast collection of movies, from the latest blockbusters to timeless classics."),
        .init(image: "onb3", title: "Create Your Own Watchlist", subtitle: "Save your favorite movies and keep track of what you want to watch next.")
    ]
    
    private var showingItemIndex = 0
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width - 32, height: 360)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let buttonStackView: UIStackView = {
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 180
        return buttonStackView
    }()
    
    private lazy var previousButton: UIButton = {
        let previousButton = UIButton()
        previousButton.setImage(UIImage(named: "previousButton"), for: .normal)
        previousButton.addTarget(self, action: #selector(didTapPrevious), for: .touchUpInside)
        previousButton.isHidden = showingItemIndex == 0
        return previousButton
    }()
    
    private lazy var continueButton: CustomButton = {
        let continueButton = CustomButton()
        continueButton.configure(.init(title: "Davam et", titleColor: .white, backgroundColor: .primaryYellow))
        continueButton.customButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        return continueButton
    }()
    
    private lazy var loginButton: CustomButton = {
        let loginButton = CustomButton()
        loginButton.configure(.init(title: "Login", titleColor: .white, backgroundColor: .primaryYellow))
        loginButton.customButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.isHidden = showingItemIndex < 2
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        view.backgroundColor = .white
        setupUI()
    }
    
    func completeOnboarding() {
        UserDefaultsManager.hasCompletedOnboarding = true
        let tabbarVC = TabBarController()
        navigationController?.setViewControllers([tabbarVC], animated: true)
    }
    
    private func setupUI() {
        [collectionView, buttonStackView].forEach(view.addSubview)
        [previousButton, continueButton, loginButton].forEach(buttonStackView.addArrangedSubview)

        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(400)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    @objc func didTapPrevious() {
        if showingItemIndex > 0 {
            showingItemIndex -= 1
        }
        previousButton.isHidden = showingItemIndex == 0
        continueButton.isHidden = showingItemIndex == 2
        collectionView.scrollToItem(at: .init(row: showingItemIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @objc func didTapContinue() {
        if showingItemIndex < 2 {
            showingItemIndex += 1
        }
        loginButton.isHidden = showingItemIndex < 2
        previousButton.isHidden = showingItemIndex == 0
        previousButton.isHidden = showingItemIndex == 2
        continueButton.isHidden = showingItemIndex == 2
        collectionView.scrollToItem(at: .init(row: showingItemIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @objc func didTapLoginButton() {
        let loginVC = LoginViewController()
        navigationController?.setViewControllers([loginVC], animated: true)
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        let item = list[indexPath.row]
        cell.configure(item: item)
        return cell
    }
}

