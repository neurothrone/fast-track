import SwiftUI

struct ChangeWeeklyGoalView: View {
  @EnvironmentObject var cloudUserDefaults: CloudUserDefaults
  
  var body: some View {
    VStack {
      Text("Change Weekly goal")
        .font(.headline)
        .foregroundColor(.mint)
      
      List(WeeklyFastingHoursGoal.allCases) { goal in
        Button {
          withAnimation(.linear) {
            cloudUserDefaults.weeklyGoal = goal
          }
        } label: {
          HStack {
            Text(goal.toString)
            
            if cloudUserDefaults.weeklyGoal == goal {
              Spacer()
              Image(systemName:  MyApp.SystemImage.checkmark)
                .foregroundColor(.purple)
            }
          }
        }
      }
    }
  }
}

struct ChangeWeeklyGoalView_Previews: PreviewProvider {
  static var previews: some View {
    ChangeWeeklyGoalView()
      .environmentObject(CloudUserDefaults.shared)
  }
}
