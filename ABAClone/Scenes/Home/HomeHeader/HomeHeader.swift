//
//  HomeHeader.swift
//  ABAClone
//
//  Created by Sao Sophea on 10/8/23.
//

import SwiftUI

struct HomeHeader: View {
    
    var body: some View {
        HStack(spacing: 15){
            Image("icBear")
                .resizable()
                .clipShape(Circle())
                .scaledToFill()
                .frame(width: 30, height: 30)
            Image("icBear")
                .resizable()
                .clipShape(Circle())
                .scaledToFill()
                .frame(width: 30, height: 30)
        }
    }
}
