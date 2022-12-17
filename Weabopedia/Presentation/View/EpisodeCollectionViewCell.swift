//
//  EpisodeCollectionViewCell.swift
//  Weabopedia
//
//  Created by Enrico Irawan on 03/12/22.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpisodeCollectionViewCell"
    
    // MARK: - Properties
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.text = "Episode"
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let episode: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .systemOrange
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    
    // MARK: - Helper
    private func configureUI() {
        addSubview(sectionTitle)
        sectionTitle.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10
        )
        
        addSubview(episode)
        episode.anchor(
            top: sectionTitle.bottomAnchor,
            leading: leadingAnchor,
            paddingTop: 10,
            paddingLeft: 10
        )
    }
    
    func configure(with episodeValue: Int) {
        episode.text = "\(episodeValue) episodes"
    }
}
