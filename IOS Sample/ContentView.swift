//
//  ContentView.swift
//  IOS Sample
//
//  Created by Emmanuel BORGES on 09/07/2021.
//

import SwiftUI
import WebKit

class StoreSettings: ObservableObject {
    @Published var hash_id = ""
}

struct ContentView: View {
    @StateObject var settings = StoreSettings()
    @State var hashid: String = ""
    @State var isModal: Bool = false

    
    var body: some View {
        VStack {
            Spacer()
            Image("logo-kimple-header").resizable().scaledToFit().frame(width: 250.0, height: 250.0)

            Text("Set your Kimple HashId here :")
            Text("(for example WXm0ivM)")
            Spacer()
            TextField("YOUR-HASH-ID", text: $hashid).frame(width: 150, alignment: .center)
            Spacer()
            Button("Go") {
                self.isModal = true
                settings.hash_id = self.hashid
            }.fullScreenCover(isPresented: $isModal) {
            } content: {
                WebviewView(self.hashid)
            }

            Spacer()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WebView : UIViewRepresentable {
    let request: URLRequest
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

struct WebviewView: View {
    @StateObject var settings = StoreSettings()
    var uri: String = ""
    init(_ hashid: String) {
        uri="https://kx1.co/contest-"+hashid
    }
    
    var body: some View {
        VStack {
            WebView(request: URLRequest(url: URL(string: uri)!))
        }
    }
}
