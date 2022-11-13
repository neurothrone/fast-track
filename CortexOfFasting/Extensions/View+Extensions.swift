//
//  View+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-09.
//

import SwiftUI

extension View {
  func linearBackground() -> some View {
    ZStack {
      LinearGradient(
        colors: [
          .mint.opacity(0.5),
          .purple.opacity(0.5),
          .mint.opacity(0.25)
        ],
        startPoint: .top,
        endPoint: .bottom
      )
      .edgesIgnoringSafeArea(.all)
      
      self
    }
  }
}
