//
//  LogView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-18.
//

import SwiftUI

struct LogView: View {
  
  var log: FastLog
  
  var body: some View {
    Text(log.isFault ? "" : log.startedDate.inReadableFormat)
      .font(.title)
      .bold()
      .padding(.top)
  }
}
