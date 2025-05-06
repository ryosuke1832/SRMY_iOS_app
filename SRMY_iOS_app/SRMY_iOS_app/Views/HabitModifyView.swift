//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

struct HabitModifyView: View {
    
    @State private var selection = "daily"
        let cadences = ["daily", "weekly", "fortnightly", "monthly", "quarterly"]
    // Change above to binding or other variable
    
    @State private var goal1 = "run for 30 minutes"
    @State private var goal2 = "skip for 10 minutes"
    @State private var goal3 = "plank for 2 minutes"
    
    var body: some View {
        VStack {
            Text("set your goals")
                .font(.title)
            
            Spacer()

            Text("write a list of daily goals you want to achieve")
                .font(.title2)
            
            
            HStack {
                TextField("run for 30 minutes", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                                    .shadow(radius: 2)
                    )
                
                Image("edit-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Image("delete-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
            }
                 
            HStack {
                TextField("drink 8 glasses of water", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                                    .shadow(radius: 2)
                    )
                
                Image("edit-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Image("delete-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
            }
            
            HStack {
                TextField("eat 3 serves of fruit", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                                    .shadow(radius: 2)
                    )
                
                Image("edit-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Image("delete-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
            }
            
            Spacer()
            
            Button("add a goal +") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                
            }
            .foregroundColor(.black)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(radius: 2)
            )

            
            Spacer()

            Text("when do you want to check in to your goals?")
                .font(.title2)

            Menu {
                ForEach(cadences, id: \.self) { cadence in
                    Button(cadence) {
                        selection = cadence
                    }
                }
            } label: {
                HStack {
                    Text(selection.capitalized)
                    Image("arrow-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                }
                .padding()
                .foregroundColor(.black)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
            }
            
            Spacer()

            HStack{
                Button("Back") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    
                }
                .foregroundColor(.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))

                Button("Next") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .foregroundColor(.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))

            }
            
        }
        .padding()
        
    }
    
    
}

#Preview {
    HabitModifyView()
}



