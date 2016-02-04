//
//  TaskTests.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/20/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit
import XCTest
import MovingHelper

class TaskTests: XCTestCase {
  
  //MARK: - Test Lifecycle
  
  override func setUp() {
    super.setUp()
    
    UserDefaultKey.resetAll()
    TaskSaver.nukeTaskFile(FileName.SavedTasks)
  }
  
  //MARK: - Private Helper Functions
  
  private func checkDeserializationForTaskProperties(title: String,
    dueDate: TaskDueDate,
    taskID: Int,
    notes: String?,
    done: Bool) {
      
      let testTaskDict = [
        TaskJSONKey.Done.rawValue: NSNumber(bool: done),
        TaskJSONKey.Title.rawValue: title,
        TaskJSONKey.TaskID.rawValue: taskID,
        TaskJSONKey.Notes.rawValue: notes ?? NSNull(),
        TaskJSONKey.DueDate.rawValue: dueDate.rawValue
      ] //as NSDictionary
      
      let taskFromJSON = Task(fromJSON: testTaskDict)
      
      XCTAssertEqual(taskFromJSON.title, title, "Title didn't deserialize!")
      XCTAssertEqual(taskFromJSON.dueDate, dueDate, "Due date didn't deserialize!")
      XCTAssertEqual(taskFromJSON.taskID, taskID, "ID didn't deserialize!")
      if let passedInNotes = notes {
        if let jsonNotes = taskFromJSON.notes {
          XCTAssertEqual(passedInNotes, jsonNotes, "Notes didn't deserialize!")
        } else {
          XCTFail("JSON did not have notes when there was a passed in notes value!")
        }
      } else {
        if let jsonNotes = taskFromJSON.notes {
          XCTFail("JSON had notes when task did not!")
        }
      }
      
      XCTAssertEqual(taskFromJSON.done, done, "Done didn't deserialize!")
  }
  
  //MARK: Actual Tests!
  
  func testTaskJSONDeserialization() {
    checkDeserializationForTaskProperties("A test task",
      dueDate: TaskDueDate.OneWeekAfter,
      taskID: 34,
      notes: "some notes",
      done: true)
    
    checkDeserializationForTaskProperties("Another test task",
      dueDate: TaskDueDate.OneDayBefore,
      taskID: 3,
      notes: nil,
      done: false)
  }
  
  func testTaskJSONSerialization() {
    XCTFail("Task ID did not serialize!")
    
    let title = "Another test task"
    let dueDate = TaskDueDate.OneMonthAfter
    let testTask = Task(aTitle: title, aDueDate: dueDate)
    testTask.done = true
    
    //Grab this since it's generated by the initializer
    let taskID = testTask.taskID
    
    let jsonDict = testTask.asJson()
    
    //NOTE: Not using the NSDictionary extension so this code
    //      is tested independently of that functionality.
    if let retrievedTitle = jsonDict[TaskJSONKey.Title.rawValue] as? String {
      XCTAssertEqual(retrievedTitle, title, "Title value incorrect!")
    } else {
      XCTFail("Title did not serialize!")
    }
    
    if let retrievedDueDate = jsonDict[TaskJSONKey.DueDate.rawValue] as? String {
      XCTAssertEqual(retrievedDueDate, dueDate.rawValue, "Due date value incorrect!")
    } else {
      XCTFail("Due date did not serialize!")
    }
    
    if let retrievedNotes: AnyObject = jsonDict[TaskJSONKey.Notes.rawValue] {
      XCTFail("Unexpected value for unstored notes!")
    }
    
    if let retrievedTaskID = jsonDict[TaskJSONKey.TaskID.rawValue] as? NSNumber {
      XCTAssertEqual(retrievedTaskID.integerValue, taskID, "Task ID value incorrect!")
    } else {
      XCTFail("Task ID did not serialize!")
    }
    
    if let retrievedDone = jsonDict[TaskJSONKey.Done.rawValue] as? NSNumber {
      XCTAssertEqual(retrievedDone.boolValue, true, "Task done value incorrect!")
    } else {
      XCTFail("Task done did not serialize!")
    }
  }
}