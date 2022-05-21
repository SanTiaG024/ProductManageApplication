//
//  ProductRegistration.swift
//  ProductManage
//
//  Created by Administrador 20/05/22.
//

import SwiftUI

struct BrandList: Codable  {
    let id: Int
    let name: String
    let code: String
}
struct ProductRegistration: View {
    
    @State private var selection: String? = nil
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var qty: String = ""
    @State var supplierValue = ""
    @State var brandValue = ""
    @State var supplierList = [SupplierList]()
    @State var brandList = [BrandList]()
    
    var productPlaceHolder = "Select product supplier"
    var productBPlaceHolder = "Select product brand"
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
       // NavigationView {
            VStack {
                TextField("Enter your name", text: $name)
                    .textFieldStyle(CustomTextfiled())
                TextField("Enter product price", text: $price)
                    .textFieldStyle(CustomTextfiled())
                TextField("Enter product qty", text: $qty)
                    .textFieldStyle(CustomTextfiled())
                
                Menu {
                    ForEach(supplierList, id: \.id) { item in
                        Button(item.name) {
                            self.supplierValue = item.name
                        }
                    }
                } label: {
                    HStack{
                        Text(supplierValue.isEmpty ? productPlaceHolder : supplierValue)
                            .frame(minWidth: 0, maxWidth: .infinity).frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .foregroundColor(supplierValue.isEmpty ? .gray : .black)
                            .padding(15)
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 20, weight: .regular))
                            .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding([.leading, .trailing, .top], 5)
                }
                
                Menu {
                    ForEach(brandList, id: \.id) { item in
                        Button(item.name) {
                            self.brandValue = item.name
                        }
                    }
                } label: {
                    HStack{
                        Text(brandValue.isEmpty ? productBPlaceHolder : brandValue)
                            .frame(minWidth: 0, maxWidth: .infinity).frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .foregroundColor(brandValue.isEmpty ? .gray : .black)
                            .padding(15)
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 20, weight: .regular))
                            .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding([.leading, .trailing, .top], 5)
                }
                Button {
                    if name != "" && price != "" && qty != "" && brandValue != "" && supplierValue != "" {
                        self.productRegister(name: self.name, price: self.price, qty: self.qty, brand: self.brandValue, supplier: self.supplierValue)
                    }
                } label: {
                    Text("Register")
                        .font(.title3)
                }
                .buttonStyle(GrowingButton())
                .padding()
                Spacer()
            }
            .padding([.leading, .trailing], 10)
        //}
        .navigationBarTitle("Product Registration", displayMode: .inline)
        .onAppear(perform: loadSupplierData)
        .onAppear(perform: loadBrandData)
    }
}
extension ProductRegistration {
    func loadSupplierData() {
        guard let url = URL(string: Constants.shared.suppliersApi) else {
            print("Your API end point is Invalid")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([SupplierList].self, from: data) {
                    DispatchQueue.main.async {
                        self.supplierList = response
                    }
                    return
                }
            }
        }.resume()
    }
    
    func loadBrandData() {
        
        guard let url = URL(string: Constants.shared.brandsApi) else {
            print("Your API end point is Invalid")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([BrandList].self, from: data) {
                    DispatchQueue.main.async {
                        self.brandList = response
                    }
                    return
                }
            }
        }.resume()
    }
}
extension ProductRegistration {
    func productRegister(name: String, price: String, qty: String, brand: String, supplier: String) {
        guard let url = URL(string: Constants.shared.productApi) else { return }
        let param: [String: Any] = [
            "name": name,
            "barcode": "101918331",
            "price": price,
            "amount": qty,
            "brand": brand,
            "supplier": supplier,
            "image": ""
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let _ = try? JSONDecoder().decode([ProductList].self, from: data) {
                    DispatchQueue.main.async {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    return
                }
            }
        }.resume()
    }
}
struct ProductRegistration_Previews: PreviewProvider {
    static var previews: some View {
        ProductRegistration()
    }
}
