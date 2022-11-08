//
//  ActiveLogView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

struct ActiveLogView: View {
  @ObservedObject var log: FastLog
  
  @State private var startTime: Date = .now
  @State private var currentTime: Date = .now
  
  @State private var isTimerRunning = false
  
  let onStopTapped: () -> Void
  
  private let timer = Timer.publish(every: 60, on: .main, in: .default).autoconnect()
  
  private var duration: TimeInterval {
    log.startedDate.distance(to: currentTime)
  }
  
  var body: some View {
    content
      .onAppear {
        guard log.stoppedDate == nil else { return }
        
        isTimerRunning = true
        startTime = log.startedDate
        currentTime = .now
      }
      .onReceive(timer) { newTime in
        guard isTimerRunning else { return }
        
        currentTime = newTime
      }
  }
  
  private var content: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("Started fasting")
        Text(log.startedAt)
        
        Button("Stop", action: onStopTapped)
          .buttonStyle(.borderedProminent)
          .tint(.orange)
      }
      
      Spacer()
      
      Text(log.startedDate.duration(to: currentTime).inHoursAndMinutesDigitalClockStyle)
        .frame(width: 75, height: 75)
        .overlay(
          Circle()
            .fill(.purple.opacity(0.5))
        )
    }
    .padding()
  }
}
