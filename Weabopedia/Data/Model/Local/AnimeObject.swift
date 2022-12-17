//
//  AnimeObject.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 03/12/22.
//

import RealmSwift

class AnimeObject: Object {
    @Persisted var id: Int = 0
    @Persisted var imageUrl: String = ""
    @Persisted var title: String = ""
    @Persisted var status: String = ""
    @Persisted var duration: String = ""
    @Persisted var score: Double = 0.0
    @Persisted var scoreBy: Int = 0
    
    convenience init(
        id: Int,
        imageUrl: String,
        title: String,
        status: String,
        duration: String,
        score: Double,
        scoreBy: Int
    ) {
        self.init()
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.status = status
        self.duration = duration
        self.score = score
        self.scoreBy = scoreBy
    }
}
