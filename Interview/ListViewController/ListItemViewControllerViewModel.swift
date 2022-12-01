//
//  ListItemViewControllerViewModel.swift
//  Interview
//
//  Created by niknil01 on 2022-11-22.
//

import Foundation
import Combine

class ListViewControllerViewModel {
    
    let fetcher = Fetcher.shared
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetcher.getPopularEpisodes().sink { result in
            switch result {
            case .success(let episodes):
                var listItems: [ListItem] = []
                
                for episode in episodes {
                    let listItem = ListItem(episode: episode)
                    listItems.append(listItem)
                }
                
                guard !listItems.isEmpty else {
                    return
                }
                
                self.listItems = listItems
                self.listItemsSubject.send(listItems)
                
            case .failure(let error):
                print("Network request failed with error: \(error.localizedDescription)")
            }
            
        }.store(in: &cancellables)
    }
    
    var listItems: [ListItem] = []
    
    let listItemsSubject = CurrentValueSubject<[ListItem], Never>([])
    
    var listItemsPublisher: AnyPublisher<[ListItem], Never> {
        listItemsSubject.eraseToAnyPublisher()
    }
}
