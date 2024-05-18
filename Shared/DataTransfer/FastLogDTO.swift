import Foundation

struct FastLogDTO: Codable {
  let startDate: Date
  let endDate: Date?
  let logType: String
}

extension FastLogDTO {
  static func from(logs: [FastLog]) -> [FastLogDTO] {
    logs.map { log in
        .init(
          startDate: log.startedDate,
          endDate: log.stoppedDate,
          logType: "fasting"
        )
    }
  }
}
