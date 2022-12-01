//
//  DetailViewController.swift
//  Interview
//
//  Created by niknil01 on 2022-11-22.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    let viewModel: DetailViewControllerViewModel
    
    var cancellables: Set<AnyCancellable> = []

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 9/16).isActive = true
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            descriptionLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        return scrollView
    }()
    
    init(viewModel: DetailViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
            
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
        
        viewModel.title.sink(receiveValue: { title in
            if let title = title {
                self.title = title
            }
        })
        .store(in: &cancellables)
        
        viewModel.imageUrl.sink(receiveValue: { imageURLString in
            if let imageURLString = imageURLString, let imageURL = URL(string: imageURLString) {
                self.imageView.load(from: imageURL)
            }
            
        })
        .store(in: &cancellables)
        
        viewModel.description.sink(receiveValue: { description in
            if let description = description {
                self.descriptionLabel.text = description
            }
        })
        .store(in: &cancellables)
    }
    
    

}

