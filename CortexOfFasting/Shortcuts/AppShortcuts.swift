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
      phrases: ["Create log"]
//      phrases: ["\(.applicationName) start"]
    )
  }
}
