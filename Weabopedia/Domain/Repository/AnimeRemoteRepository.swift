//
//  AnimeRemoteRepository.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//

import Combine

protocol AnimeRepository: AnyObject {
    func getListAnime(withGenreId genreId: Int) -> AnyPublisher<[Anime], Error>
    func getAnimeDetail(withAnimeId id: Int) -> AnyPublisher<Anime, Error>
    func searchAnime(withQuery query: String) -> AnyPublisher<[Anime], Error>
    func insertAnimeToFavorite(with anime: Anime) -> AnyPublisher<Bool, Error>
    func deleteAnimeFromFavorite(with animeId: Int) -> AnyPublisher<Bool, Error>
    func checkIsFavorite(with animeId: Int) -> AnyPublisher<Bool, Error>
    func getFavoriteList() -> AnyPublisher<[AnimeEntity], Error>
}
