//
//  InfoView.swift
//  App"
//
//  Created by Sara Izzo on 18/02/22.
//

import Foundation
import SwiftUI

struct InfoView : View {
    let backgroundGradient = LinearGradient(colors: [Color.black, Color(red: 0, green: 0.18, blue: 0.2), Color(red: 0.02, green: 0.33 , blue: 0.36)], startPoint: .top, endPoint: .bottom)
    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()
            ScrollView (.vertical){
                VStack {
                    Text("Informazioni utilizzo")
                        .foregroundColor(.white)
                    
                    Divider()
                        .foregroundColor(.white)
                    
                    Text("Informazioni utilizzo")
                        .foregroundColor(.white)
                }
                
            }
        }
    }
    
}
