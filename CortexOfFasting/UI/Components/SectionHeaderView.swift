//
//  SectionHeaderView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-09.
//

import SwiftUI

struct SectionHeaderView: View {
  let leftText: String
  let rightText: String
  
  var body: some View {
    HStack {
      Text(leftText)
      Spacer()
      Text(rightText)
    }
    .font(.headline)
    .textCase(.none)
    .foregroundColor(.black.opacity(0.75))
  }
}

struct SectionHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    SectionHeaderView(leftText: "Fasting times", rightText: "Fasting duration")
  }
}
