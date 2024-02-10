import SwiftUI
import FirebaseFirestore

struct EditTodoView: View {
   @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TodoViewModel
    @State var editingTodo: Todo
    @State var editMode: Bool


    @State var editingDate: Date = Date()

    var body: some View {
        if editMode {
            Form{
                TextField("Title", text: $editingTodo.title)
                DatePicker("Date", selection: $editingDate, displayedComponents: .date)
                Text(String(repeating:"⭐️", count: Int(editingTodo.importance)))
                Slider(value: $editingTodo.importance, in: 1...5, step:1)
                TextEditor(text: $editingTodo.note)
                    .frame(minHeight: 200)
            }
            .navigationTitle("Edit Mode")
            .toolbar{
                Button("Delete") {
                    viewModel.deleteData(todo: editingTodo)
                    dismiss()
                }
                .foregroundColor(.red)
                Button("Done") {
                    editingTodo.date = Timestamp(date: editingDate)
                    viewModel.updateData(todo: editingTodo)
                    editMode = false
                }
            }
        } else {

        }
    }
}
