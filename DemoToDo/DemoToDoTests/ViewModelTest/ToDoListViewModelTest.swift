//
//  ToDoListViewModelTest.swift
//  DemoToDoTests
//
//  Created by MohammadHossan on 14/11/2023.
//

import XCTest
@testable import DemoToDo

final class ToDoListViewModelTest: XCTestCase {
    
    var fakeToDoCardsRepository: FakeToDoCardsRepository!
    var  toDoListViewModel: ToDoListViewModel!

    @MainActor override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fakeToDoCardsRepository = FakeToDoCardsRepository()
        toDoListViewModel = ToDoListViewModel(repository: fakeToDoCardsRepository)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        fakeToDoCardsRepository = nil
        toDoListViewModel = nil
    }
    
    // when url is correct, should have some data in ToDo List
    func test_getToDoList_when_url_is_correct() async {
        
        // GIVEN
        await toDoListViewModel.getToDoList(urlStr: "todoSuccess")
        
        // WHEN
        let todoList =  await toDoListViewModel.todoLists
        
        // THEN
        // checking records count and todo note on success
        XCTAssertEqual(todoList.count, 30)
        XCTAssertEqual(todoList.first?.todo, "Do something nice for someone I care about")

        // Error will be nil when api is success
        let error =  await toDoListViewModel.customError
        XCTAssertNil(error)
    }
    
    // when url is incorrect , it will return immediatly , No data in todo array.
    func test_getToDoList_When_URL_isEmpty() async {

        // GIVEN
        await toDoListViewModel.getToDoList(urlStr: "")
        
        // WHEN
        let todoList = await toDoListViewModel.todoLists
        
        // THEN
        // when url is empty , it will fail and there will be zero records
        XCTAssertEqual(todoList.count, 0)
        
        // invalid url error
        let error = await toDoListViewModel.customError
        XCTAssertEqual(error, .invalidURL)
        XCTAssertNotNil(error)
    }
    
    // When Api fails , it will throw dataNotFound error
    func testGetToDoList_When_APIFailure() async{

        // GIVEN
        XCTAssertNotNil(toDoListViewModel)
        await toDoListViewModel.getToDoList(urlStr: "todoFaile")
        
        // WHEN
        let todoList = await toDoListViewModel.todoLists
        
        // THEN
        // number of records will be zero
        XCTAssertEqual(todoList.count, 0)
        
        let error = await toDoListViewModel.customError
        XCTAssertNotNil(error)
        XCTAssertEqual(error, NetworkError.dataNotFound)
    }
    
    // when url is not empty but incorrect format
    func testGetToDoList_When_URL_is_Incorrect() async {
       
        // GIVEN
        XCTAssertNotNil(toDoListViewModel)
        await toDoListViewModel.getToDoList(urlStr: "todoSuccessWrongURl")
        
        // WHEN
        let todoList = await toDoListViewModel.todoLists
        
        // THEN
        // Empty records
        XCTAssertEqual(todoList.count, 0)
        let error = await toDoListViewModel.customError
        XCTAssertNotNil(error)
        XCTAssertEqual(error, NetworkError.dataNotFound)
    }
    
    func test_addToDo_success() async {
       let note =  try? await toDoListViewModel.addToDoList(todo:"new note", isCompleted: true, userID: 1)
        XCTAssertNotNil(note)
    }
}

