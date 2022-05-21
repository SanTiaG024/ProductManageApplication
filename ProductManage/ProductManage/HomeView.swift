//
//  HomeView.swift
//  ProductManage
//
//  Created by Administrador on 20/05/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: ProductView(), tag: "A", selection: $selection) { EmptyView() }
                NavigationLink(destination: ProductRegistration(), tag: "B", selection: $selection) { EmptyView() }
                NavigationLink(destination: BrandView(), tag: "C", selection: $selection) { EmptyView() }
                NavigationLink(destination: SupplierView(), tag: "D", selection: $selection) { EmptyView() }
                Button {
                    selection = "A"
                } label: {
                    Text("Product List")
                        .font(.title3)
                }
                .buttonStyle(GrowingButton())
                .padding()
                
                Button {
                    selection = "B"
                } label: {
                    Text("Product Registration")
                        .font(.title3)
                }
                .buttonStyle(GrowingButton())
                .padding()
                
                Button {
                    selection = "C"
                } label: {
                    Text("Brand Registration")
                        .font(.title3)
                }
                .buttonStyle(GrowingButton())
                .padding()
                
                Button {
                    selection = "D"
                } label: {
                    Text("Supplier Registration")
                        .font(.title3)
                }
                .buttonStyle(GrowingButton())
                .padding()
                
                Spacer()
            }
            .navigationTitle(Text("Welcome"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
