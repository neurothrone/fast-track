//
//  AppShortcuts.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-18.
//

import AppIntents

public struct AppShortcuts: AppShortcutsProvider {
  @AppShortcutsBuilder
  public static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: StartFastingIntent(),
      phrases: ["Start fasting"],
      shortTitle: "Start fasting",
      systemImageName: "clock.badge.checkmark"
    )
    AppShortcut(
      intent: StopFastingIntent(),
      phrases: ["Stop fasting"],
      shortTitle: "Stop fasting",
      systemImageName: "clock.badge.xmark"
    )
    AppShortcut(
      intent: ResetFastingIntent(),
      phrases: ["Reset fasting"],
      shortTitle: "Reset fasting",
      systemImageName: "clock.arrow.circlepath"
    )
  }
}
