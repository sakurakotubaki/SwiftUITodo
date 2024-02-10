import Foundation
import FirebaseFirestore

// Firestoreのtodosコレクションと同じ構造のTodoモデルを定義
struct Todo: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var note: String
    var importance: Double
    var date: Timestamp // Firestoreでは日付はTimestamp型で管理します
    // FirestoreのデータをSwiftのモデルに変換するために必要なコード
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case note
        case importance
        case date
    }
}
