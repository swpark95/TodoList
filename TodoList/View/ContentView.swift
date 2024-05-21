import SwiftUI

// ContentView 구조체는 SwiftUI 뷰를 정의합니다.
struct ContentView: View {
    // @StateObject는 ObservableObject를 구독하고, 이 객체가 변경될 때 뷰를 자동으로 다시 그리게 합니다.
    @StateObject private var viewModel = TodoListViewModel(todoList: TodoList.sampleData)
    
    @State private var newTaskTitle = "" // 새 할 일의 제목을 저장하는 상태 변수
    
    var body: some View {
        // 내비게이션 뷰로 감싸서 상단에 타이틀과 편집 버튼을 추가할 수 있게 함
        NavigationView {
            VStack { // 세로로 정렬된 컨테이너
                List { // Todo 항목들을 표시하는 리스트 뷰
                    // ForEach는 컬렉션의 각 항목을 반복하여 뷰를 생성합니다.
                    // $viewModel.todoList.items는 바인딩된 상태로 각 항목에 접근합니다.
                    ForEach($viewModel.todoList.items) { $item in
                        HStack { // 가로로 정렬된 컨테이너
                            Button(action: {
                                // 항목의 완료 상태를 토글
                                viewModel.toggleCompletion(for: item.id)
                            }, label: {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .gray) // item.isCompleted에 따라 아이콘 색상 변경
                            })
                            .buttonStyle(BorderlessButtonStyle()) // 버튼 스타일 설정
                            
                            Text(item.title)
                            // 할 일 제목 표시
                                .strikethrough(item.isCompleted, color: .black)
                            // 완료된 항목은 취소선 적용
                                .foregroundColor(item.isCompleted ? .gray : .black) // 완료된 항목은 회색으로 표시
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let itemID = viewModel.todoList.items[index].id
                            viewModel.removeItem(itemID)
                        }
                    }
                    
                }// 새로운 할 일을 추가하는 입력 필드와 버튼
                HStack {
                    TextField("New Task", text: $newTaskTitle) // 새 할 일 제목을 입력받는 텍스트 필드
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        viewModel.addItem(TodoItem(title: newTaskTitle)) // 새 할 일을 추가
                        newTaskTitle = "" // 텍스트 필드를 초기화
                    }, label: {
                        Text("Add")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8) // clipShape(8) 대신 cornerRadius(8) 사용
                    })
                    .padding(.trailing)
                }
                .navigationTitle("Todo List") // 내비게이션 타이틀 설정
                .navigationBarItems(trailing: EditButton()) // 편집 버튼 추가
            }
        }
        
    }
}

#Preview{
    ContentView()
}
