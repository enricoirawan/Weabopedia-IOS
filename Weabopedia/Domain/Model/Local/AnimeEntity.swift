//
//  AnimeEntity.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 04/12/22.
//
struct AnimeEntity: Equatable, Identifiable {
    let id: Int
    let imageUrl: String
    let title: String
    let status: String
    let duration: String
    let score: Double
    let scoredBy: Int
}
