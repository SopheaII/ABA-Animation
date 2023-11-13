//
//  BalanceCardView.swift
//  ABAClone
//
//  Created by Sao Sophea on 13/11/23.
//

import SwiftUI

struct BalanceCardView: View {
    var body: some View {
        HStack {
            Spacer().frame(width: 18)
            ZStack(alignment: .top){
                Color.white
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .cornerRadius(15)
                    .padding(10)
                    .background(Colors.widgetFrameColor.value)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Text("$1,230,024.92")
                            .customFont(.WorkSansMedium(size: 25))
                            .foregroundColor(Colors.textColor.value)
                            .lineLimit(1)
                        Image("icShow")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                            .padding(5)
                            .background(Colors.eyeBg.value)
                            .cornerRadius(8)
                    }
                    
                    HStack{
                        ZStack{
                            Colors.blueLight.value
                            Text("Default")
                                .customFont(.WorkSansRegular(size: 10))
                                .foregroundColor(.white)
                                .padding(5)
                        }
                        .frame(width: 50, height: 20)
                        .cornerRadius(5)
                        Text("Savings")
                            .customFont(.WorkSansRegular(size: 12))
                            .foregroundColor(Colors.grayText.value)
                    }
                    
                    HStack {
                        Image("icReceive")
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                        Text("Receive Money")
                            .customFont(.WorkSansMedium(size: 16))
                            .foregroundColor(Colors.textColor.value)
                        Spacer()
                        Image("icSend")
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                        Text("Send Money")
                            .customFont(.WorkSansMedium(size: 16))
                            .foregroundColor(Colors.textColor.value)
                    }
                    .padding([.top], 15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(30)
            }
            Spacer().frame(width: 18)
        }
    }
}
