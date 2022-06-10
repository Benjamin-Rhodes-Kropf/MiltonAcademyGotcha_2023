//
//  ProfileView.swift
//  Gotcha
//
//  Created by Blake Ankner on 5/19/22.
//

import SwiftUI
import FirebaseFirestore

struct ProfileView: View {
    
//    @EnvironmentObject private var bool: dead
    
    let backgroundGradient = LinearGradient(
        colors: [Color("lightBlue"), Color("secondBlue")],
        startPoint: .top, endPoint: .bottom)
    
    let model_passed: UserAuthModel
    
    var body: some View {
        List{
            Section(){
                VStack {
                    VStack(alignment: .leading){
                        Label("Profile", systemImage: "person.circle.fill")
                            .foregroundColor(Color("lightGrey"))
                    }
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    VStack (alignment: .center){
                        HStack{
                            AsyncImage(url: URL(string: "\(model_passed.profilePicUrl)"))
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 150, height: 150)
                        }
                        HStack{
                            Text("\(model_passed.email)")
        //                        .padding()
                                .font(.title)
                                .foregroundColor(Color("white"))
        //                        .background(Color("lightPurple"))
                                .cornerRadius(20)
                        }
                    }
//                    Spacer(minLength: 50)
                    VStack{
                        Text("🎯 YAMAN HABIP")
                            .fixedSize()
                            .multilineTextAlignment(.center)
//                            .padding()
                            .font(.title3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(Color("lightGrey"))
    //                        .background(Color("offGrey"))
                            .cornerRadius(20)
//                            .shadow(color: Color("darkRed"), radius: 4, x: 4, y: 4)
                        
                        Text("#️⃣ 5 tags")
                            .multilineTextAlignment(.center)
                            .fixedSize()
//                            .padding()
                            .font(.title3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(Color("lightGrey"))
    //                        .background(Color("offGrey"))
                            .cornerRadius(20)
//                            .shadow(color: Color("darkBlue"), radius: 4, x: 4, y: 4)
                        
        //                .shadow(color: .white, radius: 2, x: 2, y: 2)
                    }
    //
                }
//                .padding()
            }
            .padding()
//            I WANTED HEXAGON BUTTON BUT IDC ENOUGH ANYMORRE
            Section(){
                VStack{
                    VStack(alignment: .leading){
                        Label("Tag Out", systemImage: "xmark.seal.fill")
                            .foregroundColor(Color("lightGrey"))
                    }
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//                if dead
                    HalvedCircularBar()
                        .padding()
                }
            }
            .padding(.top ,15)
            .padding(.leading ,15)
        }
    }
}

struct HalvedCircularBar: View {
    
    @State private var pressing: Bool = false
    @State var progress: CGFloat = 0.0
    @State var circleProgress: CGFloat = 0.0
    
    @State private var isUnlocked = false
    @State private var isDetectingLongPress = false
//    @StateObject var dead: Bool = false
    
    var body: some View {
            VStack {  // Stack built top to bottom
                ZStack {  // Stack built back to front
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    Circle()  // Background circle
                        .foregroundColor(Color("offGrey"))
                    Circle()  // Surrounding circle trimline: moves from 0 position to 100
                        .trim(from: 0.0, to: circleProgress)
                        .stroke(Color("salmon"), lineWidth: 5)
                        .frame(width: 150-15*2, height: 150-15*2)  // Slightly larger than prev. circle
                        .rotationEffect(Angle(degrees: -90))
                             //...
                    
                    Image(systemName: isUnlocked ? "checkmark.seal.fill" : "xmark.seal.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(isDetectingLongPress ? Color("salmon") : Color("lightGrey"))
                        .rotationEffect(.degrees(isDetectingLongPress ? 360 : 0))
                        .animation(isDetectingLongPress ?
                                   Animation.easeInOut(duration: 1.5)
                                        .repeatCount(2, autoreverses: true) : nil)
                                .onLongPressGesture(minimumDuration: 3.0, maximumDistance: 100 ,pressing: { (isPressing) in
                                    self.isDetectingLongPress = isPressing
                                }, perform: {
                                    impactMed.impactOccurred()
                                    isUnlocked.toggle()
                                    self.startLoading()
                                    print("DONE")
                                })
//                    Button("Tag Out"){}  // On top of circle - lower on the ZStack
//                        ._onButtonGesture { pressing in  // Press gesture
//                                        self.pressing = pressing
//                                    } perform: {
//                                        impactMed.impactOccurred()  // Screen vibrating
////                                        pressing.toggle()
//                                        self.startLoading()  // Start progressing trimline
//                                    }
//                                    .foregroundColor(Color("offWhite"))
                    
                                    
                    }
                Text(isDetectingLongPress ? "LONG PRESS" : "REMOVED")
                Text(isUnlocked ? "Tagged Out" : "Alive")
            }
        }
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in  // Timer based - adds every 0.1sec held down
                withAnimation() {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    if self.circleProgress == 1.0{
//                        dead.toggle()
                    }
                    if pressing{
                        if self.circleProgress <= 1.0{
                            self.circleProgress += 0.02
                        }
                        if self.circleProgress >= 1.0{
                            timer.invalidate()
                        }
                        if self.circleProgress >= 0.5{
                            impactMed.impactOccurred()
                        }
                    }
                    if pressing == false{
                        if self.circleProgress > 0{
                            self.circleProgress -= 0.025
                        }
//                        if self.circleProgress < 0 {
//                            timer.invalidate()
//                        }
                    }
                }
            }
        }
}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(model_passed: UserAuthModel())
//            .preferredColorScheme(.dark)
//            .previewInterfaceOrientation(.portrait)
//    }
//}
