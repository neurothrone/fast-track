//
//  SwipeableLogView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-11.
//

import SwiftUI

struct SwipeableLogView: View {
  private enum SwipeDirection {
    case left, right
  }
  
  @Environment(\.managedObjectContext) private var viewContext
  @EnvironmentObject private var dataManager: DataManager
  
  @FetchRequest(
    fetchRequest: FastLog.incompleteLogs,
    animation: .default
  )
  private var fastLogs: FetchedResults<FastLog>
  
  @State private var hasSwipedLeft = false
  @State private var hasSwipedRight = false
  @State private var isHidden = false
  @State private var offset: CGFloat = 75
  
  @State private var startTime: Date = .now
  @State private var currentTime: Date = .now
  
  private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
  
  private var duration: TimeInterval {
    startTime.distance(to: currentTime)
  }
  
  private var isTimerRunning: Bool {
    dataManager.isTimerRunning
  }
  
  var body: some View {
    content
      .onAppear {
        guard let incompleteLog = fastLogs.first else { return }
        
        dataManager.isTimerRunning = true
        startTime = incompleteLog.startedDate
        currentTime = .now
      }
      .onReceive(timer) { newTime in
        guard isTimerRunning else { return }
        
        currentTime = newTime
      }
  }
  
  private var content: some View {
    HStack(alignment: .firstTextBaseline, spacing: .zero) {
      ZStack {
        
        //MARK: - Content
        Group {
          if isTimerRunning {
            Text(duration.inHoursAndMinutesDigitalClockStyle)
          } else {
            Text("Swipe in from left to begin.")
          }
        }
        .opacity(isHidden ? .zero : 1)
        .padding()
        .offset(x: hasSwipedLeft ? offset : .zero)
        .offset(x: hasSwipedRight ? -offset : .zero)
        
        //MARK: - Swipe from Left
        HStack {
          CustomSwipeButton(
            label: isTimerRunning ? "Stop" : "Start",
            systemImage: isTimerRunning ? "clock.badge.xmark" : "clock.badge.checkmark",
            backgroundColor: .purple,
            action: {
              onSwipeAction(from: .left)
              isTimerRunning
              ? completePartialFeedLog()
              : createPartialFeedLog()
            }
          )
          
          Spacer()
        }
        .opacity(hasSwipedLeft ? 1 : .zero)
        .offset(x: hasSwipedLeft ? .zero : -offset)
        
        //MARK: - Swipe from Right
        HStack {
          Spacer()
          
          CustomSwipeButton(
            label: "Delete",
            systemImage: "trash",
            backgroundColor: isTimerRunning ? .red : .secondary,
            action: {
              onSwipeAction(from: .right)
              
              guard let log = fastLogs.first else { return }
              log.delete(using: viewContext)
            }
          )
          .disabled(!isTimerRunning)
        }
        .opacity(hasSwipedRight ? 1 : .zero)
        .offset(x: hasSwipedRight ? .zero : offset)
      }
    }
    .background(.ultraThinMaterial)
    .cornerRadius(20)
    .gesture(
      DragGesture()
        .onEnded(onDragEnded)
    )
  }
}

extension SwipeableLogView {
  private func createPartialFeedLog() {
    let newLog = FastLog(context: viewContext)
    newLog.startedDate = .now
    newLog.save(using: viewContext)
    
    startTime = newLog.startedDate
    currentTime = .now
  }
  
  private func completePartialFeedLog() {
    guard let incompleteLog = fastLogs.first else { return }
    
    incompleteLog.stoppedDate = .now
    incompleteLog.save(using: viewContext)
  }
  
  private func onDragEnded(gesture: DragGesture.Value) {
    withAnimation(.easeInOut) {
      if (gesture.location.x - gesture.startLocation.x) > .zero {
        if hasSwipedRight {
          hasSwipedRight = false
        } else {
          hasSwipedLeft = true
        }
      } else if (gesture.location.x - gesture.startLocation.x) < .zero {
        if hasSwipedLeft {
          hasSwipedLeft = false
        } else {
          hasSwipedRight = true
        }
      }
    }
  }
  
  private func onSwipeAction(from direction: SwipeDirection) {
    withAnimation(.easeInOut) {
      if direction == .left {
        hasSwipedLeft = false
      } else {
        hasSwipedRight = false
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        isHidden = true
        
        if direction == .left {
          dataManager.isTimerRunning = isTimerRunning ? false : true
        } else {
          dataManager.isTimerRunning = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          isHidden = false
        }
      }
    }
  }
}

struct SwipeableLogView_Previews: PreviewProvider {
  static var previews: some View {
    SwipeableLogView()
      .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
      .environmentObject(DataManager.shared)
      .padding()
      .linearBackground()
      .preferredColorScheme(.dark)
  }
}
