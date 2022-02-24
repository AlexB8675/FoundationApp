//
//  FirstView.swift
//  App"
//
//  Created by Sara Izzo on 18/02/22.
//

import SwiftUI

struct FirstView: View {
    
    
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.clear
        UITabBar.appearance().backgroundColor = UIColor.black
        Theme.navigationBarColors(background: .clear, titleColor: .white)
    }
    
    var body: some View {
        
        NavigationView {
            
            ContentView()
                .navigationBarItems(trailing: NavigationLink (
                    destination: InfoView(),
                    label: {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 20))
                    }))
                .navigationBarItems(leading: NavigationLink (
                    destination: Avvertenze(),
                    label: {
                        Text("Suggerimenti")
                    }))
                .foregroundColor(.white)
            
        }
        .navigationBarTitle("NomeApp", displayMode: .inline)
    }
    
}



class Theme {
    static func navigationBarColors(background : UIColor?,
                                    titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        
        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}


struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
