//
//  Constants.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-28.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

// testAdUnitIds
let testAdBannerUnitID = "ca-app-pub-3940256099942544/2934735716"
let testAdInterstitialUnitID = "ca-app-pub-3940256099942544/4411468910"
let testAdInterstitialVideoUnitID = "ca-app-pub-3940256099942544/5135589807"
let testAdRewardedVideoUnitID = "ca-app-pub-3940256099942544/1712485313"
let testAdNativeAdvancedUnitID = "ca-app-pub-3940256099942544/3986624511"
let testAdNativeAdvancedVideoUnitID = "ca-app-pub-3940256099942544/2521693316"
// my ads unit ids
let adBannerStatisticBottom = "ca-app-pub-5525602383489545/8205609453"
let adBannerConfigurationBottom = "ca-app-pub-5525602383489545/7273463869"
let adRewardedConfiguration = "ca-app-pub-5525602383489545/1429082572"
let adRewardedQuestion = "ca-app-pub-5525602383489545/4870468280"
enum Constants {
  enum Keys: String {
    case fontScale = "com.storageKey.fontScale"
    case fontFamily = "com.storageKey.fontFamily"
    
    case snoozeMinutes = "com.storageKey.snoozeMinutes"
    case watchedRewardAd = "com.storageKey.watchedRewardAd"
    case watchedRewardAdInQuestion = "com.storageKey.watchedRewardAdInQuestion"
    case removeAds = "com.storageKey.removeAds"
    case isOnboardingWatched = "com.storageKey.isOnboardingWatched"
    case appOpenedCount = "com.storageKey.appOpenedCount"
    case userFullName = "com.storageKey.userFullName"
  }
  enum Links: String {
    case youtube = "https://www.youtube.com/channel/UCVv19836gsoYpdpU_FTE21Q"
    case instagram = "https://www.instagram.com/viruscareapp"
    case mail = "coronacareapp@gmail.com"
    case mailSubject = "About virus care application"
  }
}
