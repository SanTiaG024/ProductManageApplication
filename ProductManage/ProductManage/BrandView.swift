//
//  BrandView.swift
//  ProductManage
//
//  Created by Administrador on 20/05/22.
//

import SwiftUI

struct BrandView: View{
    
    @State private var brandName: String = ""
    @State private var brandCode: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Enter brand name", text: $brandName)
                .textFieldStyle(CustomTextfiled())
            TextField("Enter brand code", text: $brandCode)
            .textFieldStyle(CustomTextfiled())
            Button {
                if brandName != "" && brandCode != "" {
                    self.brandRegister(brandName: brandName, brandCode: brandCode)
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
        .navigationBarTitle("Brand Registration", displayMode: .inline)
    }
}
extension BrandView {
    func brandRegister(brandName: String, brandCode: String) {
        guard let url = URL(string: Constants.shared.brandsApi) else { return }
        let param: [String: Any] = ["name": brandName, "code": brandCode]
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


struct BrandView_Previews: PreviewProvider {
    static var previews: some View {
        BrandView()
    }
}
