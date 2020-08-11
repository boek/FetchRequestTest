//
//  ContentView.swift
//  Shared
//
//  Created by Jeff Boek on 8/10/20.
//

import SwiftUI
import CoreData

struct CreatorView: View {
    @Environment(\.managedObjectContext) var context
    @State var name: String = ""
    @Binding var isVisible: Bool
    
    var body: some View {
        HStack {
            TextField("Title", text: $name)
            Button("Save", action: {
                let category = Category(context: context)
                category.id = UUID()
                category.name = name
                self.isVisible = false
            })
        }.navigationTitle("Create a category!").padding()
    }
}

struct ContentView: View {
    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
    ) var categories: FetchedResults<Category>
    @State var showCreator = false

    var body: some View {
        NavigationView {
            List {
                if (categories.isEmpty) {
                    Text("No Categories")
                } else {
                    ForEach(categories) { category in
                        NavigationLink(category.name!, destination: Text(category.name!))
                    }
                }
                NavigationLink(
                    destination: CreatorView(isVisible: $showCreator),
                    isActive: $showCreator,
                    label: { EmptyView() }
                )
            }.listStyle(SidebarListStyle())
            .toolbar(items: {
                ToolbarItem {
                    Button(action: { self.showCreator = true }, label: {
                        Image(systemName: "plus")
                    })
                }
            })
            
            Text("Hello!")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
