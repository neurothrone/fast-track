//
//  FastLogsRowView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct FastLogsRowView: View {
  @ObservedObject var log: FastLog
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        Text(log.startedDate.inReadableFormat)
        .foregroundColor(.blue)
        
        Spacer()
        
        if log.stoppedDate != nil {
          Text(log.duration.inHoursAndMinutes)
            .font(.callout.bold())
            .foregroundColor(.secondary)
        }
      }
      
      if let stoppedDate = log.stoppedDate {
        Text(stoppedDate.inReadableFormat)
        .foregroundColor(.orange)
      }
    }
    
//    VStack(alignment: .leading, spacing: 4) {
//      HStack {
////        Text(log.startedAt)
//        Text(log.startedDate.formatted(Date.FormatStyle().year().month().day().hour().minute()))
//          .foregroundColor(.blue)
//        Spacer()
//        Text(log.stoppedAt)
//          .foregroundColor(.orange)
//      }
//
//      Text(log.duration.toHoursAndMinutes)
//        .font(.caption.bold())
//        .foregroundColor(.secondary)
//    }
  }
}

//struct FastLogsRowView_Previews: PreviewProvider {
//  static var previews: some View {
//    FastLogsRowView(log: <#FastLog#>)
//  }
//}
