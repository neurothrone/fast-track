//
//  ActiveWeekLogsRowView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-09.
//

import SwiftUI

struct ActiveWeekLogsRowView: View {
  @ObservedObject var log: FastLog
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        // TODO: Fatal error here sometimes when deleting logs on All Weeks Screen
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
  }
}

struct ActiveWeekLogsRowView_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataProvider.preview.viewContext
    let log = FastLog(context: context)
    log.startedDate = .now.subtracting(minutes: 45)
    log.stoppedDate = .now
    log.save(using: context)
    
    return ActiveWeekLogsRowView(log: log)
      .environment(\.managedObjectContext, context)
      .padding()
  }
}
