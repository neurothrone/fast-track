//
//  CustomSwipeView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-10.
//

import SwiftUI

struct CustomSwipeButton: View {
  let label: String
  let systemImage: String
  let backgroundColor: Color
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack(alignment: .firstTextBaseline, spacing: 10) {
        Image(systemName: systemImage)
          .imageScale(.large)
        Text(label)
      }
      .padding()
      .cornerRadius(20)
      .foregroundColor(.primary)
      .background(backgroundColor)
    }
  }
}

struct CustomSwipeView: View {
  private enum SwipeDirection {
    case left, right
  }
  
  @Binding var text: String
  
  @State private var hasStarted = false
  @State private var hasSwipedLeft = false
  @State private var hasSwipedRight = false
  @State private var isHidden = false
  @State private var offset: CGFloat = 75
  
  let onStartTapped: () -> Void
  let onStopTapped: () -> Void
  let onDeleteTapped: () -> Void
  
  var body: some View {
    HStack(alignment: .firstTextBaseline, spacing: 0) {
      ZStack {
        
        //MARK: - Content
        Text(text)
          .opacity(isHidden ? .zero : 1)
          .padding()
          .offset(x: hasSwipedLeft ? offset : .zero)
          .offset(x: hasSwipedRight ? -offset : .zero)
        
        //MARK: - Swipe from Left
        HStack {
          CustomSwipeButton(
            label: hasStarted ? "Stop" : "Start",
            systemImage: hasStarted ? "clock.badge.xmark" : "clock.badge.checkmark",
            backgroundColor: .purple,
            action: { onSwipeAction(from: .left) }
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
            backgroundColor: hasStarted ? .red : .secondary,
            action: { onSwipeAction(from: .right) }
          )
          .disabled(!hasStarted)
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

extension CustomSwipeView {
  private func onDragEnded(gesture: DragGesture.Value) {
    withAnimation(.easeInOut) {
      if (gesture.location.x - gesture.startLocation.x) > 0 {
        if hasSwipedRight {
          hasSwipedRight = false
        } else {
          hasSwipedLeft = true
        }
      } else if (gesture.location.x - gesture.startLocation.x) < 0 {
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
          hasStarted = hasStarted ? false : true
        } else {
          hasStarted = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          isHidden = false
        }
      }
    }
  }
}

struct CustomSwipeView_Previews: PreviewProvider {
  @State private static var text = "Swipe from left to begin fasting."
  
  static var previews: some View {
//    CustomSwipeView()
//      .padding()
    //      .linearBackground()
    //      .preferredColorScheme(.dark)
    
    CustomSwipeView(
      text: $text,
      onStartTapped: {},
      onStopTapped: {},
      onDeleteTapped: {}
    )
    .padding()
    .linearBackground()
    .preferredColorScheme(.dark)
  }
}
