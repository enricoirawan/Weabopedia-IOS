//
//  InsertAnimeToFavoriteUseCase.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 04/12/22.
//
import Combine

class InsertAnimeToFavoriteUseCase {
    private let animeRepository: AnimeRepository
    
    required init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func execute(with anime: Anime) -> AnyPublisher<Bool, Error> {
        return animeRepository.insertAnimeToFavorite(with: anime)
    }
}
