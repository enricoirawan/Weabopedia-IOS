//
//  CheckIsFavoriteUseCase.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 04/12/22.
//

import Combine

class CheckIsFavoriteUseCase {
    private let animeRepository: AnimeRepository
    
    required init(animeRepository: AnimeRepository) {
        self.animeRepository = animeRepository
    }
    
    func execute(with animeId: Int) -> AnyPublisher<Bool, Error> {
        return animeRepository.checkIsFavorite(with: animeId)
    }
}
