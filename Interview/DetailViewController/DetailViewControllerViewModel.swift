//
//  DetailViewControllerViewModel.swift
//  Interview
//
//  Created by niknil01 on 2022-11-22.
//

import Foundation
import Combine

// 🧐
class DetailViewControllerViewModel {
    
    var title: AnyPublisher<String?, Never> {
        return titleSubject.eraseToAnyPublisher()
    }
    
    let titleSubject = CurrentValueSubject<String?, Never>(nil)
    
    var description: AnyPublisher<String?, Never> {
        return descriptionSubject.eraseToAnyPublisher()
    }
    
    let descriptionSubject = CurrentValueSubject<String?, Never>(nil)
    
    var imageUrl: AnyPublisher<String?, Never> {
        imageUrlSubject.eraseToAnyPublisher()
    }
    
    let imageUrlSubject = CurrentValueSubject<String?, Never>(nil)
    
    // 🧐
    let fetcher: Fetcher = .shared
    
    // 🧐
    private var episodeModel: EpisodeModel?
    
    var cancellables: Set<AnyCancellable> = []
    
    // 🧐
    init(episodeId: Int?) {
        guard let episodeId = episodeId else {
            return
        }
        
        fetcher.getEpisode(id: episodeId).sink { result in
            switch result {
            case .success(let episodeModel):
                self.episodeModel = episodeModel
                self.titleSubject.send(episodeModel.name)
                self.descriptionSubject.send(episodeModel.description)
                self.imageUrlSubject.send(episodeModel.imageUrl)
            case .failure(let error):
                print("Network request failed with error: \(error.localizedDescription)")
            }
        }
        .store(in: &cancellables)
    }
    
}
