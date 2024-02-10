import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AddTodoView: View {
    @Environment(\.dismiss) var dismiss
    private var db = Firestore.firestore()

    @State var title: String = ""
    @State var note: String = ""
    @State var importance: Double = 1
    @State var date: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                Text(String(repeating:"⭐️", count: Int(importance)))
                Slider(value: $importance, in: 1...5, step:1)
                TextEditor(text: $note)
            }
            .navigationTitle("New Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        var newTodo = Todo(title: title, note: note, importance: importance, date: Timestamp(date: date))
                        do {
                            let _ = try db.collection("todos").addDocument(from: newTodo) { err in
                                if let err = err {
                                    print("Error adding document: \(err)")
                                } else {
                                    print("Document added with ID: \(newTodo.id ?? "")")
                                    dismiss()
                                }
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
