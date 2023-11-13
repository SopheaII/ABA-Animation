//
//  PromotionView.swift
//  ABAClone
//
//  Created by Sao Sophea on 13/11/23.
//

import SwiftUI

struct PromotionView: View {
    var body: some View {
        HStack {
            Spacer().frame(width: 18)
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 25)
                HStack(alignment: .top){
                    Text("New & Promotion")
                        .customFont(.WorkSansSemiBold())
                        .foregroundColor(.white)
                }
                Image("promotion")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 140)
                    .cornerRadius(10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame(width: 18)
        }
    }
}
