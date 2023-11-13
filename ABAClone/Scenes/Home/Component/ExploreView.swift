//
//  ExploreView.swift
//  ABAClone
//
//  Created by Sao Sophea on 13/11/23.
//

import SwiftUI

struct ExploreView: View {
    var exploreServicesData: [ServiceInfo]
    
    var body: some View {
        HStack {
            Spacer().frame(width: 18)
            VStack {
                Spacer()
                    .frame(height: 25)
                HStack(alignment: .top){
                    Text("Explore Sservices")
                        .customFont(.WorkSansSemiBold())
                        .foregroundColor(.white)
                    Spacer()
                    Text("View All >")
                        .customFont(.WorkSansSemiBold())
                        .foregroundColor(.white)
                }
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 20){
                        ForEach(exploreServicesData, id: \.self) { item in
                            VStack {
                                Image(item.icon)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
                                
                                Text(item.name)
                                    .customFont(.WorkSansMedium(size: 16))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .mask{
                                        LinearGradient(colors: [.clear, .black, .black, .clear],
                                                       startPoint: UnitPoint(x: 1, y: 0), endPoint: UnitPoint(x: -1, y: 0))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                
                            }
                            .frame(width: 80)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .padding([.top, .bottom], 25)
                    .padding([.leading, .trailing], 10)
                })
                .padding([.top, .bottom], 5)
                .background(Colors.widgetFrameColor.value)
                .cornerRadius(20)
            }
            Spacer().frame(width: 18)
        }
    }
}
