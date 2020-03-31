//
//  AppSoundEffects.swift
//  OKala
//
//  Created by Behrad Kazemi on 11/25/19.
//  Copyright © 2019 Golrang. All rights reserved.
//

import Foundation
import AudioToolbox

public struct AppSoundEffects {
    public init() {}
    public func playPopSound() {
        play(url: AppEffectSoundsType.splash())
    }
    public func playErrorSound() {
        play(url: AppEffectSoundsType.error())
    }

    private func play(url: URL) {
        var sound: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
}
fileprivate enum AppEffectSoundsType {
  
    public static let splash = { return Bundle.main.url(forResource: "SplashSound", withExtension: "mp3")!}
    public static let error = { return Bundle.main.url(forResource: "ErrorSound", withExtension: "mp3")!}

}

