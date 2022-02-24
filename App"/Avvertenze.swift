//
//  Avvertenze.swift
//  App"
//
//  Created by Sara Izzo on 18/02/22.
//

import Foundation
import SwiftUI

struct Suggestion {

    let text: String
    var image: String

}



struct SuggestionView : View {

let suggestion: Suggestion;
    let backgroundGradient = LinearGradient(colors: [Color.black, Color(red: 0, green: 0.18, blue: 0.2), Color(red: 0.02, green: 0.33 , blue: 0.36)], startPoint: .top, endPoint: .bottom)

    
    var body: some View {

            ZStack {

                backgroundGradient.ignoresSafeArea()

                VStack(alignment: .center) {

                    Text(suggestion.text).padding(.bottom).foregroundColor(.white)
                    
                    Image(suggestion.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(40)
                        .edgesIgnoringSafeArea(.all)
                        .padding(.bottom, 10)
                    
                }

            }

        }

    }



struct Avvertenze : View {
    let backgroundGradient = LinearGradient(colors: [Color.black, Color(red: 0, green: 0.18, blue: 0.2), Color(red: 0.02, green: 0.33 , blue: 0.36)], startPoint: .top, endPoint: .bottom)

private let suggestions = [

        Suggestion(text: "Fino al compimento del primo anno è bene mettere a letto il piccolo, in posizione supina ovvero a pancia in su", image: "Bimbo"),

        Suggestion(text: "Coprire il bambino con coperte che rimangano ben rimboccate e che non rischino di spostarsi andando a coprire il viso e la testa", image: " "),

        Suggestion(text: "Non utilizzare cuscini soffici, o altri materiali che possano soffocare il bambino durante il sonno", image: " " ),

        Suggestion(text: "Far dormire il bambino in un ambiente a temperatura adeguata, né eccessivamente caldo né troppo freddo, e con sufficiente ricambio di ossigeno", image: " "),

        Suggestion(text: "Limitare la co-presenza del bambino nel letto con altre persone durante il sonno", image: " "),
        
        Suggestion(text: "Non farlo dormire su divani, cuscini imbottiti, trapunte e letti ad acqua", image: " "),
        
        Suggestion(text: "Allontanate gli oggetti e i giocattoli morbidi", image: " "),
        
        Suggestion(text: "Mettere a letto il bambino con una tutina che lo terrà al caldo in modo molto più sicuro di qualunque coperta o piumino", image: " "),

        Suggestion(text: "Non coprire mai la testa del piccolo con berretti o cuffiette", image: " "),

        Suggestion(text: "Offrire il ciuccio quando mettiamo a letto il piccolo per dormire riduce il rischio di morte in culla; per gli allattati al seno, offrire il ciuccio soltanto quando l'allattamento è ben avviato (in genere dopo il mese di vita). Per evitare il rischio di strangolamento, il ciuccio non va appeso al collo e neppure agli indumenti del bambino", image: " ")

]

    var body: some View {
            ZStack {

                backgroundGradient.ignoresSafeArea()

                VStack {

                    ScrollView {

                        ForEach(0 ..< suggestions.count, id: \.self) {

                            index in NavigationLink(destination: SuggestionView(suggestion: suggestions[index])) {

                                ZStack {

                                    RoundedRectangle(cornerRadius: 10)

                                        .fill(.gray)

                                        .padding(.horizontal, 36)

                                        .frame(height: 36, alignment: .center)

                                        .shadow(color: Color.black, radius: 3, x: 3, y: 3)

                                    Text("Suggerimento \(index+1)")

                                        .foregroundColor(.white)

                                }

                            }

                        }

                    }

                }

            }

        

    }

}
struct Avverteze_Previews: PreviewProvider {
    static var previews: some View {
        Avvertenze()
    }
}






//struct Avvertenze : View {
//    var body: some View {
//        ScrollView () {
//                VStack (alignment: .leading, spacing: 20){
//                    Text("1) Fino al compimento del primo anno è bene mettere a letto il piccolo, in posizione supina ovvero a pancia in su")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//
//                    Text("2) Coprire il bambino con coperte che rimangano ben rimboccate e che non rischino di spostarsi andando a coprire il viso e la testa")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//
//
//                    Text("3) Non utilizzare cuscini soffici, o altri materiali che possano soffocare il bambino durante il sonno")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//
//                    Text("4) Far dormire il bambino in un ambiente a temperatura adeguata, né eccessivamente caldo né troppo freddo, e con sufficiente ricambio di ossigeno")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//
//                    Text("5) Limitare la co-presenza del bambino nel letto con altre persone durante il sonno")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//
//                    Text("6) Non farlo dormire su divani, cuscini imbottiti, trapunte e letti ad acqua")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//
//                    Text("7) Allontanate gli oggetti e i giocattoli morbidi")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//
//                    Text("8) Mettere a letto il bambino con una tutina che lo terrà al caldo in modo molto più sicuro di qualunque coperta o piumino")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//
//                    Text("9) Non coprire mai la testa del piccolo con berretti o cuffiette")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//
//                    Text("10) Offrire il ciuccio quando mettiamo a letto il piccolo per dormire riduce il rischio di morte in culla; per gli allattati al seno, offrire il ciuccio soltanto quando l'allattamento è ben avviato (in genere dopo il mese di vita). Per evitare il rischio di strangolamento, il ciuccio non va appeso al collo e neppure agli indumenti del bambino")
//                        .font(.system(.headline,design:.rounded))
//                        .foregroundColor(.white)
//                }.padding().edgesIgnoringSafeArea(.horizontal)
//            }
//            .navigationBarTitle("Suggerimenti")
//            .background(Color.black)
//    }
//}
//
