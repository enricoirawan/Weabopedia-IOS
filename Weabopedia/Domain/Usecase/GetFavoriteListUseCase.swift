//
//  GetFavoriteListUseCase.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 04/12/22.
//
import Combine

class GetFavoriteListUseCase {
    private let animeRepository: AnimeRepository
    
    required init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func execute() -> AnyPublisher<[AnimeEntity], Error> {
        return animeRepository.getFavoriteList()
    }
}
