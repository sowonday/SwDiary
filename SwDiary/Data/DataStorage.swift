//
//  File.swift
//  SwDiary
//
//  Created by 김소원 on 2021/02/22.
//

import Foundation
import CoreData

class DataStorage{
    static let shared = DataStorage()
    private init(){
        
    } // 싱글톤으로 모든 곳에서 사용가능하게 구현(공유 인스턴스 저장)
    
    var mainContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }// coredata에서 실행하는 대부분의 객체는 contenxt에서 실행한다.
    
    //메모 데이터베이스에서 읽어오는 코드
    var diaryList = [Diary]()
    
    func fetchDiary(){
        let request: NSFetchRequest<Diary> = Diary.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "datecontent", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do{
            diaryList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func addnewdiary(_ diary: String?){
        let add = Diary(context: mainContext)
        add.content = diary
        add.datecontent = Date()
        
        saveContext()
    }
    
//    var diaryList = [Diary]() //빈배열로 초기화
//
//    func fetchDiary(){
//        let request: NSFetchRequest<Diary> = Diary.fetchRequest()
//
//        let sortByDateDesc = NSSortDescriptor(key: "datecontent", ascending: false)
//        request.sortDescriptors = [sortByDateDesc]
//
//        do {
//            diaryList = try mainContext.fetch(request)
//        } catch {
//            print(error)
//        }
//
//    }
    
//    func addnewdiary(_ diary: String?) {
//        let add = Diary(context: mainContext)
//        add.content = diary
//        add.datecontent = Date()
//        
//        saveContext()
//        
//    }
    
    
    
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SwDiary")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                 
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}