//
//  UIApplication+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-14.
//

import UIKit

extension UIApplication {
  static var appVersion: String {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
  }
}
