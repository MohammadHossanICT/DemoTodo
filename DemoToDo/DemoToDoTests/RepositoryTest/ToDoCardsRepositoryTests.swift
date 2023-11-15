//
//  ToDoCardsRepositoryTests.swift
//  DemoToDoTests
//
//  Created by MohammadHossan on 14/11/2023.
//

import XCTest
@testable import DemoToDo

final class ToDoCardsRepositoryTests: XCTestCase {
    
    var fakeNetworkManager: FakeNetworkManager!
    var toDoCardsRepository: ToDoCardsRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fakeNetworkManager = FakeNetworkManager()
        toDoCardsRepository = ToDoRepositoryImplementation (networkManager: fakeNetworkManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        toDoCardsRepository = nil
    }
    
    // when passes ToDo list array will return with some data
    func test_when_get_ToDo_list_success() async {
        
        // GIVEN
        let lists = try? await toDoCardsRepository.getToDoList(for: URL(string:"todoSuccess")!)
        // WHEN
        guard let listItem = lists else {
            XCTFail("List is nil")
            return
        }
        //THEN
        XCTAssertTrue(listItem.todos.count > 0)
    }
    
    // when fails, todo list will be nil
    func test_when_get_ToDo_list_fails() async throws {
        
        //GIVEN
        let lists = try? await toDoCardsRepository.getToDoList(for: URL(string:"todoFaile")!)
        
        //THEN
        XCTAssertNil(lists)
    }
}
