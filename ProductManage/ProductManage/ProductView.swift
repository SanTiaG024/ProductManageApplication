//
//  ContentView.swift
//  ProductManage
//
//  Created by Administrador on 20/05/22.
//

import SwiftUI

struct ProductList: Codable  {
    let id: Int
    let name: String
    let barcode: String
    let price: String
    let amount: String
    let brand: String
    let supplier: String
    let image: String
}

struct ProductView: View {
    
    @State var productList = [ProductList]()
    
    var body: some View {
       // NavigationView {
            List(productList, id: \.id) { item in
                HStack {
                    AsyncImage(url: URL(string: item.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    .padding(5)
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                            .fontWeight(.medium)
                            .lineLimit(2)
                            // .padding(.bottom, 5)
                        Text("Amount: $"+item.price+".00")
                            // .padding(.bottom, 5)
                        Text("Qty: "+item.amount)
                    }
                }
            }.listStyle(.plain)
       // }
        .navigationBarTitle("Product List", displayMode: .inline)
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        
        guard let url = URL(string: Constants.shared.productApi) else {
            print("Your API end point is Invalid")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([ProductList].self, from: data) {
                    DispatchQueue.main.async {
                        self.productList = response
                    }
                    return
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
