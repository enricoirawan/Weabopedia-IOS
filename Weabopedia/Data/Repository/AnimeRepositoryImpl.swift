//
//  AnimeRepository.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//
import Combine

class AnimeRepositoryImpl: AnimeRepository {
    private let animeRemoteDataSource: AnimeRemoteDataSource
    private let animeLocalDataSource: AnimeLocalDataSource
    
    required init(
        animeRemoteDataSource: AnimeRemoteDataSource,
        animeLocalDataSource: AnimeLocalDataSource
    ) {
        self.animeRemoteDataSource = animeRemoteDataSource
        self.animeLocalDataSource = animeLocalDataSource
    }
    
    func getListAnime(withGenreId genreId: Int) -> AnyPublisher<[Anime], Error> {
        return animeRemoteDataSource.getListAnime(withGenreId: genreId)
            .map { AnimeMapper.mapAnimeResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getAnimeDetail(withAnimeId id: Int) -> AnyPublisher<Anime, Error> {
        return animeRemoteDataSource.getAnimeDetail(withId: id)
            .map { AnimeMapper.mapAnimeResponseToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func searchAnime(withQuery query: String) -> AnyPublisher<[Anime], Error> {
        return animeRemoteDataSource.searchAnime(withQuery: query)
            .map { AnimeMapper.mapAnimeResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func insertAnimeToFavorite(with anime: Anime) -> AnyPublisher<Bool, Error> {
        return animeLocalDataSource.insertAnimeToFavorite(with: anime)
            .eraseToAnyPublisher()
    }
    
    func deleteAnimeFromFavorite(with animeId: Int) -> AnyPublisher<Bool, Error> {
        return animeLocalDataSource.deleteAnimeFromFavorite(with: animeId)
            .eraseToAnyPublisher()
    }
    
    func checkIsFavorite(with animeId: Int) -> AnyPublisher<Bool, Error> {
        return animeLocalDataSource.checkIsFavorite(with: animeId)
            .eraseToAnyPublisher()
    }
    
    func getFavoriteList() -> AnyPublisher<[AnimeEntity], Error> {
        return animeLocalDataSource.getFavoriteList()
            .map { AnimeMapper.mapAnimeObjectsToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
}
