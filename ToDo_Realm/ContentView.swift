//
//  ContentView.swift
//  ToDo_Realm
//
//  Created by Kevin Vo on 11/3/20.
//

import SwiftUI
import RealmSwift
import Combine
import Foundation


struct ContentView: View {
    @EnvironmentObject var toDoViewModel: ToDoViewModel
    @State var content: String
    let todo: ToDoModel

    
    var body: some View {
        VStack{
            List{
                TextField("", text: $content, onCommit:{
                    saveTask()
                })
                ForEach(toDoViewModel.todos){ todo in
                    HStack{
                    
                        Text(todo.content)
                        Spacer()
                        Button(action: {
                            deleteTask(id: todo.id)
                        }){
                            Image(systemName: "trash")
                        }
                        .padding()
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(content: "", todo: ToDoModel(toDoModelRealm: ToDoModelRealm()))
            .environmentObject(ToDoViewModel())
    }
}

extension ContentView{
    func saveTask(){
        toDoViewModel.createTask(content: content)
    }
    
    func deleteTask(id: String){
        toDoViewModel.deleteTask(id: todo.id)
    }
}

//ToDo Model Struct
struct ToDoModel: Identifiable{
    var id: String
    var content: String
}
extension ToDoModel{
    init(toDoModelRealm: ToDoModelRealm){
        id = toDoModelRealm.id
        content = toDoModelRealm.content
    }
}

//Todo Form
class ToDoForm: ObservableObject{
    @Published var content = ""
    
    init() {}
    
    init(_ todo: ToDoModel){
        content = todo.content
    }
}

//Realm Model
class ToDoModelRealm: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var content = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//ToDoViewModel handle CRUD function
class ToDoViewModel: ObservableObject{
    private var ToDoResults: Results<ToDoModelRealm>
    
    let realm = try! Realm()
    
    init(){
        ToDoResults = realm.objects(ToDoModelRealm.self)
    }
    
    var todos: [ToDoModel]{
        ToDoResults.map(ToDoModel.init)
    }
    
    func createTask(content: String){
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            let todo = ToDoModelRealm()
            todo.id = UUID().uuidString
            todo.content = content
            
            try realm.write {
                realm.add(todo)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteTask(id: String){
        objectWillChange.send()
        do{
            let realm = try Realm()
            let task = realm.objects(ToDoModelRealm.self)
            print(task)
            /*
            try! realm.write{
                if let obj = task{
                    realm.delete(obj)
                }
            }
            */
        } catch let error{
            print(error.localizedDescription)
        }
    }
}

func deleteAll(){
    do {
        let realm = try Realm()
        try! realm.write {
            realm.deleteAll()
        }
    } catch let error {
        print(error.localizedDescription)
    }
}
