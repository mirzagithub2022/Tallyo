import Foundation
import Combine

/// Owns Tallyo's state and business logic. Contains no UI code.
@MainActor
final class TallyoViewModel: ObservableObject {

    // MARK: - State
    @Published private(set) var count: Int = 0

    @Published var limit: TallyoLimit = .thirty {
        didSet {
            // If the new limit is lower than the current count, clamp it.
            if count > limit.rawValue {
                count = limit.rawValue
            }
        }
    }

    // MARK: - Derived values
    var isAtLimit: Bool { count >= limit.rawValue }

    var progress: Double {
        guard limit.rawValue > 0 else { return 0 }
        return Double(count) / Double(limit.rawValue)
    }

    // MARK: - Intents
    /// Increments the count. Returns `true` if the count actually increased.
    @discardableResult
    func increment() -> Bool {
        guard !isAtLimit else { return false }
        count += 1
        return true
    }

    func reset() {
        count = 0
    }
}
