import SwiftUI
import UniformTypeIdentifiers

struct JSONDocument: FileDocument {
  static var readableContentTypes: [UTType] { [.json] }
  
  var data: [FastLogDTO]
  
  init(data: [FastLogDTO]) {
    self.data = data
  }
  
  init(configuration: ReadConfiguration) throws {
    let decoder = JSONDecoder()
    self.data = try decoder.decode([FastLogDTO].self, from: configuration.file.regularFileContents!)
  }
  
  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let data = try encoder.encode(data)
    return FileWrapper(regularFileWithContents: data)
  }
}
