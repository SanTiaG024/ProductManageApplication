//
//  SupplierView.swift
//  ProductManage
//
//  Created by Administrador on 20/05/22.
//

import SwiftUI

struct SupplierList: Codable  {
    let id: Int
    let name: String
    let code: String
}

struct SupplierView: View {
    
    @State private var supplierName: String = ""
    @State private var supplierCode: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Enter supplier name", text: $supplierName)
                .textFieldStyle(CustomTextfiled())
            TextField("Enter supplier code", text: $supplierCode)
            .textFieldStyle(CustomTextfiled())
            Button {
                if supplierName != "" && supplierCode != "" {
                    self.supplierRegister(supplierName: supplierName, supplierCode: supplierCode)
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
        .navigationBarTitle("Supplier Registration", displayMode: .inline)
    }
}
extension SupplierView {
    func supplierRegister(supplierName: String, supplierCode: String) {
        guard let url = URL(string: Constants.shared.suppliersApi) else { return }
        let param: [String: Any] = ["name": supplierName, "code": supplierCode]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let _ = try? JSONDecoder().decode([BrandList].self, from: data) {
                    DispatchQueue.main.async {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    return
                }
            }
        }.resume()
    }

}

struct SupplierView_Previews: PreviewProvider {
    static var previews: some View {
        SupplierView()
    }
}
