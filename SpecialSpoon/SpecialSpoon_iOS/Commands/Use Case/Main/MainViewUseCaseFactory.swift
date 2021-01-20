//
//  MainViewUseCaseFactory.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import Foundation
import AVFoundation

class PlaySampleUseCase: UseCase {
    static var player: AVPlayer?
    
    init(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        PlaySampleUseCase.player = AVPlayer(playerItem: playerItem)
    }
    
    func start() {
        PlaySampleUseCase.player?.play()
    }
}

protocol MainViewUseCaseFactory {
    func makePlaySampleUseCase(url: URL) -> UseCase
}
