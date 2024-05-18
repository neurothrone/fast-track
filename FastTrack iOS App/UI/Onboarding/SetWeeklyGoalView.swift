import SwiftUI

struct SetWeeklyGoalView: View {
  @EnvironmentObject private var cloudUserDefaults: CloudUserDefaults
  
  var body: some View {
    VStack {
      Text("Set your weekly goal")
        .font(.largeTitle)
      
      Text("It takes your body up to 12 hours since your last meal to fully enter the fasted state. Set your weekly goal for the amount of hours in the fasted state.")
        .padding([.horizontal, .top])

      List {
        Section {
          ForEach(WeeklyFastingHoursGoal.allCases) { goal in
            Button {
              withAnimation(.linear) {
                cloudUserDefaults.weeklyGoal = goal
              }
            } label: {
              if cloudUserDefaults.weeklyGoal == goal {
                HStack {
                  Text(goal.toString)
                  Spacer()
                  Image(systemName: "checkmark")
                }
              } else {
                Text(goal.toString)
              }
            }
          }
          .listRowBackground(Color.black)
          .listRowSeparatorTint(.white.opacity(0.4))
        } footer: {
          Text("You can change this later at anytime.")
            .font(.footnote.bold())
        }
      }
      .scrollContentBackground(.hidden)
      .scrollDisabled(true)
      
      Button {
        withAnimation(.linear) {
          cloudUserDefaults.isFirstTimeUsingApp = false          
        }
      } label: {
        Text("Get started")
          .padding(.vertical)
          .font(.title2)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .padding([.horizontal, .bottom])
    }
    .linearBackground()
  }
}

struct SetWeeklyGoalView_Previews: PreviewProvider {
  static var previews: some View {
    SetWeeklyGoalView()
      .environmentObject(CloudUserDefaults.shared)
      .preferredColorScheme(.dark)
  }
}
