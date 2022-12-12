//
//  ActiveLogView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-16.
//

import SwiftUI

struct ActiveLogView: View {
  @ObservedObject var log: FastLog
  
  @State private var startTime: Date = .now
  @State private var currentTime: Date = .now
  
  private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
  
  private var duration: TimeInterval {
    log.startedDate.distance(to: currentTime)
  }
  
  var body: some View {
    content
      .onAppear {
        startTime = log.startedDate
        currentTime = .now
      }
      .onReceive(timer) { newTime in
        currentTime = newTime
      }
  }
  
  @ViewBuilder
  private var content: some View {
#if os(iOS)
    HStack {
      Text(log.isFault ? "Unknown" : log.startedDate.inReadableFormat)
      
      Spacer()
      
      Text(log.isFault ? "Unknown" :  log.startedDate.duration(to: currentTime).inHoursAndMinutesDigitalClockStyle)
        .font(.title3.bold())
        .padding()
        .frame(width: 140)
        .background(.ultraThickMaterial)
        .cornerRadius(20)
        .background(
          RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.mint.opacity(0.5))
        )
    }
    .frame(maxWidth: .infinity, alignment: .center)
#elseif os(macOS)
    HStack {
      Text(log.isFault ? "Unknown" : log.startedDate.inReadableFormat)
      
      Spacer()
      
      Text(log.isFault ? "Unknown" :  log.startedDate.duration(to: currentTime).inHoursAndMinutesDigitalClockStyle)
        .font(.title3.bold())
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(.ultraThickMaterial)
        .cornerRadius(20)
        .background(
          RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.mint.opacity(0.5))
        )
    }
    .frame(maxWidth: .infinity, alignment: .center)
#elseif os(watchOS)
    Text(log.isFault ? "Unknown" :  log.startedDate.duration(to: currentTime).inHoursAndMinutesDigitalClockStyle)
      .font(.title3.bold())
      .padding()
      .frame(maxWidth: .infinity, alignment: .center)
      .background(
        RoundedRectangle(cornerRadius: 20, style: .continuous)
          .fill(.mint.opacity(0.5))
      )
      .frame(maxWidth: .infinity, alignment: .center)
#endif
  }
}

//struct ActiveLogView_Previews: PreviewProvider {
//  static var previews: some View {
//    ActiveLogView()
//  }
//}
