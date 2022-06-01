//
//  ProfileView.swift
//  Gotcha
//
//  Created by Blake Ankner on 5/19/22.
//

import SwiftUI
import FirebaseFirestore

struct ProfileView: View {
    
    let backgroundGradient = LinearGradient(
        colors: [Color("lightBlue"), Color("secondBlue")],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack {
            Spacer(minLength: 35)
            VStack (alignment: .center){
                HStack{
                    Image("blakeProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                }
                HStack{
                    Text("Blake")
//                        .padding()
                        .font(.title)
                        .foregroundColor(Color("white"))
//                        .background(Color("lightPurple"))
                        .cornerRadius(20)
                }
            }
            Spacer(minLength: 50)
//            VStack(alignment: .center){
            List{
                Section(header: Text("Stats").font(.headline)){
                    Text("Your Target:\n YAMAN HABIP")
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(.title2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("white"))
                        .background(Color("darkGrey"))
                        .cornerRadius(20)
                        .shadow(color: Color("darkRed"), radius: 4, x: 4, y: 4)
                        
                    Text("Number of Tags: \n5")
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(.title2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("white"))
                        .background(Color("darkGrey"))
                        .cornerRadius(20)
                        .shadow(color: Color("darkBlue"), radius: 4, x: 4, y: 4)
                }
                .shadow(color: .white, radius: 2, x: 2, y: 2)
                .padding(10)
                .cornerRadius(20)
                .listRowBackground(Color("darkGrey"))
            }
            .onAppear {
                // Set the default to clear
                UITableView.appearance().backgroundColor = .clear
            }
//            }x
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color("darkGrey"))
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
