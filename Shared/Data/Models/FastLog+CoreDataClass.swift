import CoreData
import Foundation

@objc(FastLog)
public class FastLog: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<FastLog> {
    return NSFetchRequest<FastLog>(entityName: String(describing: FastLog.self))
  }
  
  @objc var yearAndWeek: String {
    startedDate.formatted(Date.FormatStyle().year().week())
  }
  
  @NSManaged public var id: String
  @NSManaged public var startedDate: Date
  @NSManaged public var stoppedDate: Date?
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    
    id = UUID().uuidString
    startedDate = .now
  }
}

extension FastLog : Identifiable {}
