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
            Image("icNotification")
                .resizable()
                .scaledToFill()
                .frame(width: 25, height: 25)
            Image("icKHQR")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
        }
//        .eraseToAnyView()
    }

//    #if DEBUG
//    @ObservedObject var iO = injectionObserver
//    #endif
}
