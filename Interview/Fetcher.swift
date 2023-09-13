//
//  APIClient.swift
//  Interview
//
//  Created by niknil01 on 2022-11-22.
//

import Foundation
import Combine

// Mockad api-klient. Inte en del av "testet"
class Fetcher {

    static let shared: Fetcher = Fetcher()
    
    private let urlSession: URLSession = .shared
    
    func getEpisode(id: Int) -> AnyPublisher<Result<EpisodeModel, Error>, Never> {
        return Just(.success(getMockedEpisode(id: id))).eraseToAnyPublisher()
    }
    
    func getPopularEpisodes() -> AnyPublisher<Result<[EpisodeModel], Error>, Never> {
        let mockedPopularEpisodeIds: [Int] = [3, 7, 33, 44, 23, 15, 73, 34, 35, 47, 61, 30, 701, 677, 551]
        
        let mockedPopularEpisodes = mockedPopularEpisodeIds.map(getMockedEpisode)
        
        return Just(.success(mockedPopularEpisodes)).eraseToAnyPublisher()
    }
    
    private func getMockedEpisode(id: Int) -> EpisodeModel {
        return EpisodeModel(
            id: id,
            name: "Episode with id \(id)",
            description: "Description of episode with id \(id). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean porttitor pharetra orci at sollicitudin. Fusce accumsan luctus erat, id porttitor dui dictum id. Maecenas leo risus, pulvinar at suscipit id, sagittis id elit.",
            audioUrl: "www.fakeaudiourl\(id)",
            lengthInSeconds: id + 1 * 10,
            imageUrl: "https://fakeimg.pl/350x200/?text=Episode\(id)"
        )
    }
    
    
}
