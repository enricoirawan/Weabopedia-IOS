//
//  AnimeLocalDataSource.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 03/12/22.
//

import Foundation
import Combine
import RealmSwift

protocol AnimeLocalDataSource: AnyObject {
    func insertAnimeToFavorite(with anime: Anime) -> AnyPublisher<Bool, Error>
    func deleteAnimeFromFavorite(with animeId: Int) -> AnyPublisher<Bool, Error>
    func checkIsFavorite(with animeId: Int) -> AnyPublisher<Bool, Error>
    func getFavoriteList() -> AnyPublisher<[AnimeObject], Error>
}

class AnimeLocalDataSourceImpl: AnimeLocalDataSource {
    private let realm: Realm

    required init(realm: Realm) {
        self.realm = realm
    }
    
    func insertAnimeToFavorite(with anime: Anime) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try self.realm.write {
                let animeObject = AnimeObject(
                    id: anime.id,
                    imageUrl: anime.images.jpg.imageURL,
                    title: anime.title,
                    status: anime.status,
                    duration: anime.duration,
                    score: anime.score,
                    scoreBy: anime.scoredBy
                )
                self.realm.add(animeObject)
                completion(.success(true))
              }
            } catch {
              completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteAnimeFromFavorite(with animeId: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try self.realm.write {
                let animeObjects = self.realm.objects(AnimeObject.self)
                let results = animeObjects.where {
                    $0.id == animeId
                }
                self.realm.delete(results)
                completion(.success(true))
              }
            } catch {
              completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    func checkIsFavorite(with animeId: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try self.realm.write {
                let animeObjects = self.realm.objects(AnimeObject.self)
                let results = animeObjects.where {
                    $0.id == animeId
                }
                let data = results.toArray(ofType: AnimeObject.self)
                if data.isEmpty {
                    completion(.success(false))
                } else {
                    completion(.success(true))
                }
              }
            } catch {
              completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteList() -> AnyPublisher<[AnimeObject], Error> {
        return Future<[AnimeObject], Error> { completion in
            do {
                try self.realm.write({
                let animeList: Results<AnimeObject> = {
                    self.realm.objects(AnimeObject.self)
                    .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(animeList.toArray(ofType: AnimeObject.self)))
                })
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
