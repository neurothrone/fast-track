import SwiftUI
import WatchConnectivity

final class WatchConnector: NSObject, ObservableObject {
  @AppStorage(
    MyApp.AppStorage.weeklyFastingHoursGoal,
    store: UserDefaults(suiteName: MyApp.CKConfig.sharedAppGroup)
  )
  private(set) var weeklyGoal: WeeklyFastingHoursGoal = .easy {
    willSet {
      DispatchQueue.main.async {
        self.objectWillChange.send()
      }
    }
  }
  
  static let shared = WatchConnector()
  
  override private init() {
    super.init()
    
#if !os(watchOS)
    guard WCSession.isSupported() else {
      return
    }
#endif
    
    WCSession.default.delegate = self
    WCSession.default.activate()
  }
  
  func changeWeeklyGoal(_ goal: WeeklyFastingHoursGoal) {
    weeklyGoal = goal
    let userInfo = ["weeklyGoal": weeklyGoal.rawValue]
    send(userInfo: userInfo)
  }
  
  public func send(userInfo: [String : Any]) {
    guard WCSession.default.activationState == .activated else {
      return
    }
    
#if os(watchOS)
    guard WCSession.default.isCompanionAppInstalled else {
      return
    }
#else
    guard WCSession.default.isWatchAppInstalled else {
      return
    }
#endif
    
    WCSession.default.transferUserInfo(userInfo)
  }
  
  func session(
    _ session: WCSession,
    didReceiveUserInfo userInfo: [String: Any] = [:]
  ) {
    guard let weeklyGoal = userInfo["weeklyGoal"] as? String else { return }
    
    self.weeklyGoal = WeeklyFastingHoursGoal(rawValue: weeklyGoal) ?? .easy
  }
}

extension WatchConnector: WCSessionDelegate {
  func session(
    _ session: WCSession,
    activationDidCompleteWith activationState: WCSessionActivationState,
    error: Error?) {}
  
#if os(iOS)
  func sessionDidBecomeInactive(_ session: WCSession) {
    // If the person has more than one watch and they switch,
    // reactivate their session on the new device.
    WCSession.default.activate()
  }
  func sessionDidDeactivate(_ session: WCSession) {}
#endif
}
