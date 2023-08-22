//
//  ContentView.swift
//  ABAClone
//
//  Created by Sao Sophea on 9/8/23.
//

import SwiftUI

struct Home: View {
    let minScrollP: CGFloat = 20
    let maxHeaderHeight: CGFloat = 50
    let minProfileSize: CGFloat = 35
    let maxProfileSize: CGFloat = 50
    let profileDefualtOffset: CGFloat = 30
    @State private var headerPaddingBottonAsPercentage: CGFloat = 1
    @State private var viewPositionY: CGFloat = 30
    @State private var headerHeight: CGFloat = 50
    @State private var isEndScrolling = false
    @State private var viewProfileOpacify: Double = 1
    @State private var welcomeTitleOpacify: Double = 1
    @State private var prifileSize: CGFloat = 50
    @State private var mainServices = ["Apple", "Orange", "Banana", "Lemon", "Tangerine", "Mango", "Apple😁", "Orange😁", "Banana😁", "Lemon😁", "Tangerine😁", "Mango😁"]
    @State private var mainServices1 = ["Apple😁", "Orange😁", "Banana😁", "Lemon😁", "Tangerine😁", "Mango😁"]
    @State private var allowReordering = true
    @State private var isScrollToTop = false
    
    @State var draggedItem: String?
    @State private var hasChangedLocation: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            Colors.appBg.value
                .ignoresSafeArea()
            VStack(alignment: .leading){
//                VStack(alignment: .leading){
//                    VStack {
//                        HomeHeader()
//                            .frame(maxWidth: .infinity, alignment: .trailing)
//                    }
//                    // MARK: - Profile
//                    HStack(alignment: .center, spacing: 10){
//                        Image("icBear")
//                            .resizable()
//                            .clipShape(Circle())
//                            .scaledToFill()
//                            .frame(width: abs(prifileSize), height: abs(prifileSize))
//                            .padding(2)
//                            .background(Color.white)
//                            .clipShape(Circle())
//                            .animation(.linear(duration: isEndScrolling ? 0.2 : 0), value: prifileSize)
//                        VStack(alignment: .leading, spacing: 5){
//                            Text("Hello, Ly Ly!")
//                                .customFont(.WorkSansSemiBold())
//                                .foregroundColor(Color.white)
//                                .opacity(abs(welcomeTitleOpacify))
//                                .animation(.linear(duration: isEndScrolling ? 0.1 : 0), value: welcomeTitleOpacify)
//                            Button(action: {  }) {
//                                Text("View Profile >")
//                                    .customFont(.WorkSansRegular(size: 14))
//                                    .foregroundColor(Colors.softText.value)
//                            }
//                            .opacity(abs(viewProfileOpacify))
//                            .animation(.linear(duration: isEndScrolling ? 0.1 : 0), value: viewProfileOpacify)
//                        }
//                    }
//                    .padding([.leading], 5)
//                    .padding([.bottom], 10)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .offset(y: viewPositionY)
//                    .frame(height: 0)
//                    .animation(.linear(duration: viewPositionY < 30 ? 0.1 : 0), value: viewPositionY)
//                }
//                .padding([.trailing, .leading], 18)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    ScrollViewReader { scrollViewProxy in
                        Spacer()
                            .frame(height: 70)
                            .id(1)
                        VStack(spacing: 10){
                            // MARK: - Balance Card
//                            ZStack(alignment: .top){
//                                Color.white
//                                    .frame(maxWidth: .infinity)
//                                    .frame(height: 150)
//                                    .cornerRadius(15)
//                                    .padding(10)
//                                    .background(Colors.widgetFrameColor.value)
//                                    .cornerRadius(20)
//                                VStack(alignment: .leading, spacing: 10){
//                                    HStack{
//                                        Text("$23882.92")
//                                            .customFont(.WorkSansMedium(size: 25))
//                                            .foregroundColor(Colors.textColor.value)
//                                            .lineLimit(1)
//                                        Image("icBear")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 17, height: 17)
//                                            .padding(5)
//                                            .background(Colors.eyeBg.value)
//                                            .cornerRadius(8)
//                                    }
//
//                                    HStack{
//                                        ZStack{
//                                            Colors.blueLight.value
//                                            Text("Default")
//                                                .customFont(.WorkSansRegular(size: 10))
//                                                .foregroundColor(.white)
//                                                .padding(5)
//                                        }
//                                        .frame(width: 50, height: 20)
//                                        .cornerRadius(5)
//                                        Text("Savings")
//                                            .customFont(.WorkSansRegular(size: 12))
//                                            .foregroundColor(Colors.grayText.value)
//                                    }
//
//                                    HStack {
//                                        Image("icBear")
//                                            .resizable()
//                                            .clipShape(Circle())
//                                            .scaledToFill()
//                                            .frame(width: 25, height: 25)
//                                        Text("Receive Money")
//                                            .customFont(.WorkSansMedium(size: 16))
//                                            .foregroundColor(Colors.textColor.value)
//                                        Spacer()
//                                        Image("icBear")
//                                            .resizable()
//                                            .clipShape(Circle())
//                                            .scaledToFill()
//                                            .frame(width: 25, height: 25)
//                                        Text("Send Money")
//                                            .customFont(.WorkSansMedium(size: 16))
//                                            .foregroundColor(Colors.textColor.value)
//                                    }
//                                    .padding([.top], 15)
//                                }
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .padding(30)
//                            }
                            
                            // MARK: - Service Widget
                            VStack{
                                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), alignment: .center) {
                                    ReorderableForEach($mainServices, $draggedItem, allowReordering: $allowReordering, hasChangedLocation: $hasChangedLocation) { item in
                                        Button(action: {
                                            
                                        }) {
                                            ZStack {
                                                Color(draggedItem == item ? UIColor(Color.white.opacity(0.3)) : .white)
                                                    .frame(width: 110, height: 100)
                                                VStack {
                                                    Image("icBear")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 40, height: 40)
                                                    Text(item)
                                                        .customFont(.WorkSansMedium(size: 16))
                                                        .foregroundColor(Colors.textColor.value)
                                                }
                                            }
                                        }
                                        .cornerRadius(15)
                                        .padding([.leading, .trailing], 1)
                                        .padding([.top, .bottom], 1)
                                    }
                                }
                                
                                Divider()
                                    .overlay(.white)
                                ScrollView(.horizontal, showsIndicators: false, content: {
                                    HStack{
                                        ReorderableForEach($mainServices, $draggedItem, startIndex: 6, allowReordering: $allowReordering,  hasChangedLocation: $hasChangedLocation) { item in
                                            Button(action: {

                                            }) {
                                                ZStack {
                                                    Color(draggedItem == item ? UIColor(Color.white.opacity(0.3)) : .white)
                                                        .cornerRadius(15)
                                                        .frame(width: 150, height: 50)
                                                        .padding([.leading, .trailing], 1)
                                                        .padding([.top, .bottom], 1)

                                                    HStack {
                                                        Image("icBear")
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 20, height: 20)
                                                        Text(item)
                                                            .customFont(.WorkSansMedium(size: 16))
                                                            .foregroundColor(Colors.textColor.value)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                })
                            }
                            .padding(10)
                            .background(Colors.widgetFrameColor.value)
                            .cornerRadius(20)
                            
                            // MARK: - Explore Services
//                            VStack {
//                                Spacer()
//                                    .frame(height: 25)
//                                HStack(alignment: .top){
//                                    Text("Explore Sservices")
//                                        .customFont(.WorkSansSemiBold())
//                                        .foregroundColor(.white)
//                                    Spacer()
//                                    Text("View All >")
//                                        .customFont(.WorkSansSemiBold())
//                                        .foregroundColor(.white)
//                                }
//                                ScrollView(.horizontal, showsIndicators: false, content: {
//                                    HStack(spacing: 20){
//                                        ForEach((0...8), id: \.self) { _ in
//                                            VStack {
//                                                Image("icBear")
//                                                    .resizable()
//                                                    .scaledToFill()
//                                                    .frame(width: 60, height: 60)
//                                                    .cornerRadius(10)
//                                                Text("Services")
//                                                    .customFont(.WorkSansMedium(size: 16))
//                                                    .foregroundColor(.white)
//                                                    .frame(minWidth: 20, maxWidth: 80)
//                                                    .lineLimit(1)
//                                                    .truncationMode(.tail)
//                                            }
//                                        }
//                                    }
//                                    .frame(maxWidth: .infinity, maxHeight: 60)
//                                    .padding(25)
//                                })
//                                .background(Colors.widgetFrameColor.value)
//                                .cornerRadius(20)
//                            }
                        }
                        .background {
                            ScrollDetector { offset in
                                if !isScrollToTop && offset != 0 {
                                    let currentOffset = offset - profileDefualtOffset
                                    if currentOffset < minScrollP {
                                        viewPositionY = -currentOffset
                                        if minScrollP - offset >= 0 {
                                            viewProfileOpacify = offset > 0.0 ? (minScrollP - offset) / minScrollP: 1
                                            
                                            welcomeTitleOpacify = offset > 15 ? (minScrollP - offset) / (minScrollP - 17): 1
                                        }else if minScrollP - offset < 0 {
                                            viewProfileOpacify = 0
                                            welcomeTitleOpacify = 0
                                        }
                                        
                                        if currentOffset/2 < minScrollP {
                                            headerPaddingBottonAsPercentage = 0
                                            headerHeight = maxHeaderHeight - 2*minScrollP
                                        } else if currentOffset <= 0 {
                                            headerPaddingBottonAsPercentage = 1
                                            headerHeight = maxHeaderHeight
                                        }
                                        let currentProfileSize = maxProfileSize - ((offset / (minScrollP + profileDefualtOffset)) * (maxProfileSize -  minProfileSize))
                                        prifileSize = offset > 0 ? currentProfileSize : maxProfileSize
                                    }
                                    if currentOffset >= minScrollP {
                                        viewPositionY = -minScrollP
                                        welcomeTitleOpacify = 0
                                        viewProfileOpacify = 0
                                        headerPaddingBottonAsPercentage = 0
                                        prifileSize = minProfileSize
                                        headerHeight = maxHeaderHeight - 2*minScrollP
                                        isEndScrolling = true
                                        return
                                    }
                                    if isEndScrolling {
                                        isEndScrolling = false
                                    }
                                    if isScrollToTop {
                                        isScrollToTop = false
                                    }
                                }else if offset >= 0 {
                                    isScrollToTop = false
                                }
                                
                            } onDraggingEnd: { offset, velocity in
                                if (viewPositionY != -minScrollP || viewPositionY != 0) && offset > 0 && offset < 45 {
                                    viewPositionY = profileDefualtOffset
                                    viewProfileOpacify = 1
                                    welcomeTitleOpacify = 1
                                    prifileSize = maxProfileSize
                                    headerPaddingBottonAsPercentage = viewProfileOpacify
                                    isEndScrolling = true
                                    isScrollToTop = true
                                }
                            }
                        }
                        .onChange(of: isScrollToTop) { newValue in
                            if isScrollToTop {
                                scrollViewProxy.scrollTo(1)
                            }
                        }
                        .id(2)
                    }
                })
                .padding([.trailing, .leading], 18)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .previewDevice("iPhone 11 Pro Max")
    }
}
