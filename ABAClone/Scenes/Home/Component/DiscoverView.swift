//
//  DiscoverView.swift
//  ABAClone
//
//  Created by Sao Sophea on 13/11/23.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        HStack {
            Spacer().frame(width: 18)
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 25)
                HStack(alignment: .top){
                    Text("Discoveries")
                        .customFont(.WorkSansSemiBold())
                        .foregroundColor(.white)
                }
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 7){
                        ForEach((0...8), id: \.self) { _ in
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Colors.discoveryFrame.value, lineWidth: 5)
                                    .frame(width: 98, height: 133)
                                    .cornerRadius(15)
                                Image("icBear")
                                    .resizable()
                                    .cornerRadius(12)
                                    .padding(3)
                                    .frame(width: 95, height: 130)
                                    .opacity(0.8)
                                Text("Services")
                                    .customFont(.WorkSansMedium(size: 16))
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .padding([.bottom, .leading, .trailing], 10)
                            }
                            .frame(width: 100)
                        }
                    }
                })
            }
            Spacer().frame(width: 18)
        }
    }
}
