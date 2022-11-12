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
  
  private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
  
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
      VStack(alignment: .leading, spacing: 10) {
        Text(log.startedDate.inReadableFormat)

        Button("Stop", action: onStopTapped)
          .buttonStyle(.borderedProminent)
          .tint(.purple)
      }

      Spacer()

      Text(log.startedDate.duration(to: currentTime).inHoursAndMinutesDigitalClockStyle)
        .font(.title3.bold())
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.secondary.opacity(0.5))
        )
    }
    .padding()
  }
}
