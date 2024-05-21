//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by Park Sang Wook on 5/21/24.
//

import SwiftUI

//맞습니다. ViewModel 없이도 SwiftUI에서 간단한 Todo List 기능을 구현할 수 있습니다. 그러나 ViewModel을 사용하는 경우 몇 가지 이점이 있습니다:

//코드 분리: 데이터 로직과 UI 로직을 분리하여 코드를 더 읽기 쉽게 하고 유지 보수를 용이하게 합니다.
//상태 관리: 여러 뷰에서 공통 상태를 관리할 때 유용합니다.
// 재사용성: ViewModel을 사용하면 데이터 처리 로직을 재사용할 수 있습니다.
//ViewModel 없이 작성된 코드에서는 상태와 로직이 뷰 안에 혼합되어 있어 간단한 경우에는 문제가 없지만, 복잡한 애플리케이션에서는 관리가 어려울 수 있습니다.

//개념 :MVVM (Model-View-ViewModel) 패턴은 Model View, View, Model의 약자로 프로그램의 비지니스 로직과, 프레젠테이션 로직을 UI로 명확하게 분리하는 패턴입니다.
//https://velog.io/@kyeun95/디자인-패턴-MVVM-패턴이란



// TodoListViewModel 클래스는 ObservableObject 프로토콜을 채택합니다.
// 이 클래스는 뷰와 데이터 모델 간의 중재자 역할을 하며, 데이터 변경을 퍼블리싱합니다.
class TodoListViewModel: ObservableObject {
    // @Published 속성 래퍼는 todoList 속성이 변경될 때마다 자동으로 변화를 퍼블리싱합니다.
    @Published var todoList: TodoList
    
    // 생성자는 TodoList 객체를 받아서 초기화합니다.
    init(todoList: TodoList) {
        self.todoList = todoList
    }
    
    // addItem 메서드는 TodoItem 객체를 todoList에 추가합니다.
    // _를 사용하면 함수나 메서드를 호출할 때 해당 매개변수의 레이블을 생략할 수 있습니다.
    func addItem(_ item: TodoItem) {
        todoList.addItem(item)
    }
    
    // removeItem 메서드는 주어진 itemID에 해당하는 항목을 todoList에서 제거합니다.
    func removeItem(_ itemID: TodoItem.ID) {
        todoList.removeItem(itemID)
    }
    
    // toggleCompletion 메서드는 주어진 itemID에 해당하는 항목의 완료 상태를 토글합니다.
    func toggleCompletion(for itemID: TodoItem.ID) {
        todoList.toggleCompletion(for: itemID)
    }
}


