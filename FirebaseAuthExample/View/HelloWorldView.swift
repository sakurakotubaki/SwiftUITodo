import SwiftUI

struct HelloPage: View {
    var authController: AuthController
    @StateObject var viewModel = TodoViewModel()
    @State var showAddTodoView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todos, id: \.date) { todo in
                    NavigationLink(destination: EditTodoView(viewModel: viewModel, editingTodo: todo, editMode: true)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(todo.title).bold()
                                Text(todo.date.dateValue(), style: .date).foregroundStyle(.secondary)
                            }
                            .padding(.bottom,1)
                            HStack {
                                Text(todo.note)
                                    .lineLimit(1)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.bottom,1)
                            HStack {
                                Text(String(repeating:"⭐️", count: Int(todo.importance)))
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(viewModel.todos.count) Todo Items")
            .toolbar{
                ToolbarItem{
                    Button(action:{
                        showAddTodoView = true
                    }){
                        Label("Add Todo", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddTodoView, content: {
                AddTodoView()
            })
            .onAppear() {
                self.viewModel.fetchData()
            }
        }
    }
}

struct HelloWorldView_Previews: PreviewProvider {
    static var previews: some View {
        HelloPage(authController: AuthController())
    }
}
