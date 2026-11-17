import Foundation

/// The counting limits a user can choose in Tallyo.
enum TallyoLimit: Int, CaseIterable, Identifiable {
    case thirty = 30
    case sixty = 60
    case ninety = 90
    case hundred = 100

    var id: Int { rawValue }
    var title: String { String(rawValue) }
}
