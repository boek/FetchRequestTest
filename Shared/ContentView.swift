//
//  ContentView.swift
//  Shared
//
//  Created by Jeff Boek on 8/10/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State var name: String = ""

    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
    ) var categories: FetchedResults<Category>

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New Category", text: $name)
                    Button(action: createCategory, label: {
                        Image(systemName: "plus")
                    })
                }.padding()
                List {

                    if (categories.isEmpty) {
                        Text("No Categories")
                    } else {
                        ForEach(categories) { category in
                            NavigationLink(category.name!, destination: Text(category.name!))
                        }
                    }
                }.listStyle(SidebarListStyle())
            }
        }
    }
    
    private func createCategory() {
        let category = Category(context: context)
        category.id = UUID()
        category.name = name
        name = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
