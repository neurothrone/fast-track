//
//  LogListRowView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-09.
//

import SwiftUI

struct LogListRowView: View {
  @ObservedObject var log: FastLog
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        Label(
          log.isFault
          ? "Unknown"
          :  log.startedDate.inReadableFormat,
          systemImage: "play.fill"
        )
        
        Spacer()
        
        if log.stoppedDate != nil {
          Text(log.duration.inHoursAndMinutes)
            .font(.callout.bold())
            .foregroundColor(.purple)
        }
      }
      
      if let stoppedDate = log.stoppedDate {
        Label(stoppedDate.inReadableFormat, systemImage: "stop.fill")
      }
    }
    .foregroundColor(.mint)
  }
}

struct FastLogsRowView_Previews: PreviewProvider {
  static var previews: some View {
    let context = CoreDataProvider.preview.viewContext
    let log = FastLog(context: context)
    log.startedDate = .now.subtracting(minutes: 620)
    log.stoppedDate = .now
    log.save(using: context)
    
    return LogListRowView(log: log)
      .environment(\.managedObjectContext, context)
      .padding()
      .preferredColorScheme(.dark)
  }
}
