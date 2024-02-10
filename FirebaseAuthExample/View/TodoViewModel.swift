import Foundation
import Firebase

class TodoViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var todos = [Todo]()

    func fetchData() {
        db.collection("todos").order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.todos = documents.compactMap { queryDocumentSnapshot -> Todo? in
                return try? queryDocumentSnapshot.data(as: Todo.self)
            }
        }
    }

    func updateData(todo: Todo) {
        if let todoID = todo.id {
            do {
                try db.collection("todos").document(todoID).setData(from: todo)
            }
            catch {
                print(error)
            }
        }
    }

    func deleteData(todo: Todo) {
        if let todoID = todo.id {
            db.collection("todos").document(todoID).delete { (error) in
                if let error = error {
                    print("Error removing document: \(error)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
}
