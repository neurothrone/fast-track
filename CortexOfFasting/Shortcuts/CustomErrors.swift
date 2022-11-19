//
//  CustomErrors.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-18.
//

import Foundation

enum Error: Swift.Error, CustomLocalizedStringResourceConvertible {
  case notFound,
       coreDataSave,
       unknownId(id: String),
       unknownError(message: String),
       deletionFailed,
       addFailed(title: String)
  
  var localizedStringResource: LocalizedStringResource {
    switch self {
    case .addFailed: return "An error occurred trying to add log"
    case .deletionFailed: return "An error occurred trying to delete the log"
    case .unknownError(let message): return "An unknown error occurred: \(message)"
    case .unknownId(let id): return "No logs with an ID matching: \(id)"
    case .notFound: return "Log not found"
    case .coreDataSave: return "Couldn't save to CoreData"
    }
  }
}
