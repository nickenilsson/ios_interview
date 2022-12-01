//
//  ListViewController.swift
//  Interview
//
//  Created by niknil01 on 2022-11-22.
//

import UIKit
import Combine


class ListItem {
    
    let episode: EpisodeModel
    
    init(episode: EpisodeModel) {
        self.episode = episode
    }
    
    var title: String? { episode.name }
    var imageUrl: URL? {
        if let imageUrlString = episode.imageUrl {
            return URL(string: imageUrlString)
        }
        return nil
    }
    var description: String? { episode.description }
    
    var imageUrlString: String? { episode.imageUrl }
    
}


class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cancellables: Set<AnyCancellable>
    
    let tableView: UITableView
    
    var listItems: [ListItem]
    
    let viewModel: ListViewControllerViewModel
    
    init(viewModel: ListViewControllerViewModel) {
        self.cancellables = []
        self.listItems = viewModel.listItems
        self.viewModel = viewModel
        
        self.tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(nibName: nil, bundle: nil)
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(ListViewControllerCell.self, forCellReuseIdentifier: "\(ListViewControllerCell.self)")
        
        viewModel.listItemsPublisher.sink { listItems in
            guard !listItems.isEmpty else { return }
            self.listItems = listItems
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }
    
    override func loadView() {
        view = UIView()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Populära avsnitt"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ListViewControllerCell.self)", for: indexPath) as? ListViewControllerCell else {
            return UITableViewCell()
        }
        
        let listItem = listItems[indexPath.item]
        if let title = listItem.title {
            cell.titleLabel.text = title
        }
        
        if let description = listItem.description {
            cell.descriptionLabel.text = description
        }
        
        if let imageUrlString = listItem.imageUrlString {
            cell.mainImageView.load(from: URL(string: imageUrlString)!)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItem = listItems[indexPath.item]
        let detailViewControllerViewModel = DetailViewControllerViewModel(episodeId: listItem.episode.id)
        let detailViewController = DetailViewController(viewModel: detailViewControllerViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}


