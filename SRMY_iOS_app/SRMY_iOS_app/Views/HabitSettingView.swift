//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

struct HabitSettingView: View {
    
    @State private var selection = "daily"
        let colours = ["daily", "weekly", "fortnightly", "monthly", "quarterly"]
    
    var body: some View {
        VStack {
            Text("set your goals")
                .font(.title)
            
            Spacer()

            Text("write a list of daily goals you want to achieve")
                .font(.title2)
            
            TextField("run for 30 minutes", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.accentColor)
                )
            TextField("run for 30 minutes", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.accentColor)
                )
            TextField("run for 30 minutes", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.accentColor)
                )
            
            Spacer()

            Text("when do you want to check in to your goals?")
                .font(.title2)

            Menu(selection) {
                ForEach(colours, id: \.self) { colours in
                    Button (colours, action: {
                        selection = colours
                    })
                }
            }
            .pickerStyle(.menu)
            .padding(.all, 16)
            .foregroundStyle(Color.white)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
            
            Spacer()

            HStack{
                Button("Back") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))

                Button("Next") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))

            }
            
        }
        .padding()
        
    }
    
    
}

#Preview {
    HabitSettingView()
}
