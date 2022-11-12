//
//  ActiveWeekLogsRowView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-09.
//

import SwiftUI

struct ActiveWeekLogsRowView: View {
  let log: FastLog
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        Label(log.startedDate.inReadableFormat, systemImage: "play.fill")
        
        Spacer()
        
        if log.stoppedDate != nil {
          Text(log.duration.inHoursAndMinutes)
            .font(.callout.bold())
            .foregroundColor(.mint.opacity(0.75))
        }
      }
      
      if let stoppedDate = log.stoppedDate {
        Label(stoppedDate.inReadableFormat, systemImage: "stop.fill")
      }
    }
    .foregroundColor(.mint)
  }
}

struct ActiveWeekLogsRowView_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataProvider.preview.viewContext
    let log = FastLog(context: context)
    log.startedDate = .now.subtracting(minutes: 620)
    log.stoppedDate = .now
    log.save(using: context)
    
    return ActiveWeekLogsRowView(log: log)
      .environment(\.managedObjectContext, context)
      .padding()
      .preferredColorScheme(.dark)
  }
}
