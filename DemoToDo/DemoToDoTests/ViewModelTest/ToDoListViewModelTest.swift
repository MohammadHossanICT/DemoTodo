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

    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fakeToDoCardsRepository = FakeToDoCardsRepository()
        toDoListViewModel = ToDoListViewModel(repository: fakeToDoCardsRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        fakeToDoCardsRepository = nil
        toDoListViewModel = nil
    }
    
    // when url is correct, should have some data in ToDo List
    func test_getToDoList_when_url_is_correct() async {
        await toDoListViewModel.getToDoList(urlStr: "todoSuccess")
        let todoList =  await toDoListViewModel.todoLists
        XCTAssertEqual(todoList.count, 30)
        
        let localError =  await toDoListViewModel.customError
        XCTAssertNil(localError)
    }
    
    // when url is incorrect , it will return immediatly , No data in todo array.
    func test_getToDoList_When_URL_isNotGiven() async{

        await toDoListViewModel.getToDoList(urlStr: "")
        let todoList = await toDoListViewModel.todoLists
        XCTAssertEqual(todoList.count, 0)
        let localError = await toDoListViewModel.customError
        XCTAssertEqual(localError, .invalidURL)
        XCTAssertNotNil(localError)
    }
    
    func testGetToDoList_When_APIFailure() async{

        XCTAssertNotNil(toDoListViewModel)
        await toDoListViewModel.getToDoList(urlStr: "todoFaile")
        let todoList = await toDoListViewModel.todoLists
        XCTAssertEqual(todoList.count, 0)
        let localError = await toDoListViewModel.customError
        XCTAssertNotNil(localError)
        XCTAssertEqual(localError, NetworkError.dataNotFound)

    }
    
    func testGetToDoList_When_URL_is_Incorrect() async {
       
        XCTAssertNotNil(toDoListViewModel)
        await toDoListViewModel.getToDoList(urlStr: "todoSuccessWrongURl")
        let todoList = await toDoListViewModel.todoLists
        XCTAssertEqual(todoList.count, 0)
        let localError = await toDoListViewModel.customError
        XCTAssertNotNil(localError)
        XCTAssertEqual(localError, NetworkError.dataNotFound)
    }

}
