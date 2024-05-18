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
          systemImage: MyApp.SystemImage.startClock
        )
        
        Spacer()
        
        if log.stoppedDate != nil {
          Text(log.duration.inHoursAndMinutes)
            .font(.callout.bold())
            .foregroundColor(.purple)
        }
      }
      
      if let stoppedDate = log.stoppedDate {
        Label(stoppedDate.inReadableFormat, systemImage: MyApp.SystemImage.stopClock)
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
