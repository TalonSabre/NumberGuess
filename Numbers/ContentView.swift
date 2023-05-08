//
//  ContentView.swift
//  Numbers
//
//  Created by CPW on 10/18/22.
//

import SwiftUI
import Combine
import Lottie

struct ContentView: View
{
    @State var answer = Int.random(in: 0...1000)
    @State var guessI: Int = 500
    @State var remaining = 10
    @State var guessS = ""
    @State var isHotCold = "Guess a number and press GO."
    @State var btnTxt = "GO"
    @State var boldOrNo: Font.Weight = .bold
    @State var clr = Color.indigo
    
    var body: some View
    {
        ZStack
        {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            LottieView(filename: "starsBG")
            
            RoundedRectangle(cornerRadius: 32)
                .foregroundColor(clr)
                .opacity(0.55)
                .overlay(RoundedRectangle(cornerRadius: 32).stroke(lineWidth: 4).foregroundColor(clr))
                .padding()
                .padding(.vertical, 160)
            
            VStack
            {
                Spacer()
                Spacer()
                Spacer()
                HStack
                {
                    Spacer()
                    TextField("Guess a number between 0 and 1000", text: $guessS)
                        .multilineTextAlignment(.center)
                        .background(Color("Bar"))
                        .cornerRadius(8)
                        .onReceive(Just(guessS))
                            { newVal in
                                let nums = "0123456789"
                                let filter = newVal.filter { nums.contains($0) }
                                if filter != newVal
                                {
                                    self.guessS = filter
                                }
                            }
                        .padding(.horizontal, 16)
                    Spacer()
                }
                
                Button(action:
                        {
                    if btnTxt == "GO"
                    {
                        if remaining > 1
                        {
                            btnTxt = "GO"
                            
                            if !guessS.isEmpty
                            {
                                guessI = Int(guessS)!
                                
                                if guessI > 1000 || guessI < 0
                                {
                                    isHotCold = "Guess a number between\n0 and 1000."
                                    boldOrNo = .heavy
                                }
                                else
                                {
                                    boldOrNo = .bold
                                    remaining -= 1
                                    
                                    if guessI == answer
                                    {
                                        guessS = ""
                                        btnTxt = "Play Again"
                                        isHotCold = "Congratulations, you are correct!\nThe number was \(answer)."
                                        answer = Int.random(in: 0...1000)
                                        remaining = 10
                                        clr = Color.green
                                    }
                                    else if ((guessI > answer + 300) || (guessI < answer - 300))
                                    {
                                        isHotCold = "Very Cold!\n\(remaining) guesses left."
                                    }
                                    else if ((guessI > answer + 150) || (guessI < answer - 150))
                                    {
                                        isHotCold = "A Bit Chilly!\n\(remaining) guesses left."
                                    }
                                    else if ((guessI > answer + 75) || (guessI < answer - 75))
                                    {
                                        isHotCold = "Getting Warm!\n\(remaining) guesses left."
                                    }
                                    else if ((guessI > answer + 20) || (guessI < answer - 20))
                                    {
                                        isHotCold = "Hot! Hot!\n\(remaining) guesses left."
                                    }
                                    else
                                    {
                                        if guessI > answer
                                        {
                                            isHotCold = "Burning Up! Lower!\n\(remaining) guesses left."
                                        }
                                        else
                                        {
                                            isHotCold = "Burning Up! Higher!\n\(remaining) guesses left."
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            guessS = ""
                            btnTxt = "Play Again"
                            isHotCold = "The number was \(answer)."
                            answer = Int.random(in: 0...1000)
                            remaining = 10
                            clr = Color.red
                        }
                    }
                    else
                    {
                        btnTxt = "GO"
                        isHotCold = "Guess a number and press GO."
                        clr = Color.indigo
                    }
                        },
                       label:
                        {
                    Text(btnTxt)
                        .font(.title2)
                        .fontWeight(.bold)
                        })
                .padding(12)
                .foregroundColor(Color.white)
                .background(Color.mint)
                .cornerRadius(16)
                Spacer()
                Text(isHotCold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .fontWeight(boldOrNo)
                Spacer()
                Spacer()
            }
        .padding()
        }
    }
}

struct LottieView: UIViewRepresentable
{
    typealias UIViewType = UIView
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView
    {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {  }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
