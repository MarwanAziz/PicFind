//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation
import SwiftData

public class AppStorage: Storage {
  public static let shared = AppStorage()
  private var localModelContainer: ModelContainer
  private var localContext: ModelContext

  internal var context: ModelContext {
    localContext
  }

  public var modelContainer: ModelContainer {
    localModelContainer
  }

  public func updateModelContainer(container: ModelContainer) {
    localModelContainer = container
    localContext = ModelContext(container)
  }

  private init() {
    let _modelContainer: ModelContainer = {
      let schema = Schema([
        ImageData.self, SearchData.self
      ])
      let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

      do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
      } catch {
        fatalError("Could not create ModelContainer: \(error)")
      }
    }()
    localModelContainer = _modelContainer
    localContext = ModelContext(_modelContainer)
  }
}
