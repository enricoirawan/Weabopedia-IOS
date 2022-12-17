//
//  DI.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 30/11/22.
//
import Swinject
import RealmSwift

class Injection {
    let container: Container = {
        let container = Container()
        
        // MARK: - Data Source
        container.register(AnimeLocalDataSource.self) { _ in
            AnimeLocalDataSourceImpl(realm: try! Realm())
        }
        container.register(AnimeRemoteDataSource.self) { _ in
            AnimeRemoteDataSourceImpl()
        }
        container.register(GenreRemoteDataSource.self) { _ in
            GenreRemoteDataSourceImpl()
        }
        
        // MARK: - Repository
        container.register(AnimeRepository.self) { resolver in
            AnimeRepositoryImpl(
                animeRemoteDataSource: resolver.resolve(
                    AnimeRemoteDataSource.self
                )!,
                animeLocalDataSource: resolver.resolve(
                    AnimeLocalDataSource.self
                )!
            )
        }
        container.register(GenreRepository.self) { resolver in
            GenreRepositoryImpl(
                genreRemoteDataSource: resolver.resolve(
                    GenreRemoteDataSource.self
                )!
            )
        }
        
        // MARK: - Use Case
        container.register(GetListAnimeUseCase.self) { resolver in
            GetListAnimeUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        container.register(GetListGenreUseCase.self) { resolver in
            GetListGenreUseCase(
                genreRepository: resolver.resolve(
                    GenreRepository.self
                )!
            )
        }
        container.register(GetAnimeDetailUseCase.self) { resolver in
            GetAnimeDetailUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        container.register(SearchAnimeUseCase.self) { resolver in
            SearchAnimeUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        container.register(InsertAnimeToFavoriteUseCase.self) { resolver in
            InsertAnimeToFavoriteUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        container.register(DeleteAnimeFromFavoriteUseCase.self) { resolver in
            DeleteAnimeFromFavoriteUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        container.register(GetFavoriteListUseCase.self) { resolver in
            GetFavoriteListUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        container.register(CheckIsFavoriteUseCase.self) { resolver in
            CheckIsFavoriteUseCase(
                animeRepository: resolver.resolve(
                    AnimeRepository.self
                )!
            )
        }
        
        // MARK: - Presenter
        container.register(HomeViewController.self) { resolver in
            let controller = HomeViewController()
            controller.getListAnimeUseCase = resolver.resolve(GetListAnimeUseCase.self)
            controller.getListGenreUseCase = resolver.resolve(GetListGenreUseCase.self)
            return controller
        }
        container.register(DetailViewController.self) { resolver in
            let controller = DetailViewController()
            controller.getAnimeDetailUseCase = resolver.resolve(GetAnimeDetailUseCase.self)
            controller.checkIsFavoriteUseCase = resolver.resolve(CheckIsFavoriteUseCase.self)
            controller.insertAnimeToFavoriteUseCase = resolver.resolve(InsertAnimeToFavoriteUseCase.self)
            controller.deleteAnimeFromFavoriteUseCase = resolver.resolve(DeleteAnimeFromFavoriteUseCase.self)
            return controller
        }
        container.register(SearchViewController.self) { resolver in
            let controller = SearchViewController()
            controller.searchAnimeUseCase = resolver.resolve(SearchAnimeUseCase.self)
            return controller
        }
        container.register(FavoriteViewController.self) { resolver in
            let controller = FavoriteViewController()
            controller.getFavoriteListUseCase = resolver.resolve(GetFavoriteListUseCase.self)
            return controller
        }
        return container
    }()
}
