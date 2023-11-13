//
//  ContentView.swift
//  ABAClone
//
//  Created by Sao Sophea on 9/8/23.
//

import SwiftUI

private let EXPLORED_ID     = "EXPLORED_WIDGET"
private let PROMOTION_ID    = "PROMOTION_WIDGET"
private let DISCOVER_ID     = "DISCOVER_WIDGET"

struct ServiceInfo: Equatable, Hashable {
    let name: String
    let icon: String
}

struct Home: View {
    let minScrollP: CGFloat           = 20
    let maxHeaderHeight: CGFloat      = 50
    let minProfileSize: CGFloat       = 35
    let maxProfileSize: CGFloat       = 50
    let profileDefaultOffset: CGFloat = 30
    
    @State private var headerPaddingBottomAsPercentage: CGFloat = 1
    @State private var viewPositionY: CGFloat                   = 30
    @State private var headerHeight: CGFloat                    = 50
    @State private var viewProfileOpacify: Double               = 1
    @State private var welcomeTitleOpacify: Double              = 1
    @State private var profileSize: CGFloat                     = 50
    
    @State private var isEndScrolling                           = false
    
    @State private var mainServicesData = [
        ServiceInfo(name: "Account", icon: "icAccount"),
        ServiceInfo(name: "Cards", icon: "icCard"),
        ServiceInfo(name: "Payments", icon: "icPayment"),
        ServiceInfo(name: "ABA Scan", icon: "icScan"),
        ServiceInfo(name: "Favorites", icon: "icFavorite"),
        ServiceInfo(name: "Transfers", icon: "icTransfer"),
    ]
    
    @State private var subServicesData = [
        ServiceInfo(name: "E-cash", icon: "icECash"),
        ServiceInfo(name: "Services", icon: "icService"),
        ServiceInfo(name: "New Account", icon: "icNewAccount"),
    ]
    @State private var exploreServicesData = [
        ServiceInfo(name: "Unseentra", icon: "unseentra"),
        ServiceInfo(name: "Cinema Ticket", icon: "cinemaTicket"),
        ServiceInfo(name: "BookMeBus", icon: "bookMeBus"),
        ServiceInfo(name: "VET Express", icon: "vet"),
    ]
    @State private var allowServiceReordering = true
    @State private var isScrollToTop = false
    @State var draggedServiceItem: ServiceInfo?
    @State var draggedServiceItem1: ServiceInfo?
    @State private var isServiceChangedLocation: Bool = false
    @State private var isServiceWidgetMove = false
    
    @State private var widgetInfoList = [EXPLORED_ID, PROMOTION_ID, DISCOVER_ID]
    @State var draggedWidgetItem: String?
    @State private var allowWidgetReordering = true
    @State private var isWidgetChangedLocation: Bool = false
    @State private var isWidgetMove = false
    @State var isItemProviderEnd = false
    
#if DEBUG
    @ObservedObject var iO = injectionObserver
#endif
    
    func scrollAnimation(offset: CGFloat) {
        if !isScrollToTop && offset != 0 {
            let currentOffset = offset - profileDefaultOffset
            
            if currentOffset < minScrollP {
                // Scrolling up
                viewPositionY = -currentOffset
                
                if minScrollP - offset >= 0 {
                    viewProfileOpacify = max(0, (minScrollP - offset) / minScrollP)
                    welcomeTitleOpacify = max(0, (minScrollP - offset) / (minScrollP - 17))
                } else {
                    viewProfileOpacify = 0
                    welcomeTitleOpacify = 0
                }
                
                if currentOffset / 2 < minScrollP {
                    headerPaddingBottomAsPercentage = 0
                    headerHeight = maxHeaderHeight - 2 * minScrollP
                } else if currentOffset <= 0 {
                    headerPaddingBottomAsPercentage = 1
                    headerHeight = maxHeaderHeight
                }
                
                let currentProfileSize = maxProfileSize - ((offset / (minScrollP + profileDefaultOffset)) * (maxProfileSize -  minProfileSize))
                profileSize = offset > 0 ? currentProfileSize : maxProfileSize
            } else {
                // Scrolling down
                viewPositionY = -minScrollP
                welcomeTitleOpacify = 0
                viewProfileOpacify = 0
                headerPaddingBottomAsPercentage = 0
                profileSize = minProfileSize
                headerHeight = maxHeaderHeight - 2 * minScrollP
                isEndScrolling = true
                return
            }
            
            if isEndScrolling {
                isEndScrolling = false
            }
            
            if isScrollToTop {
                isScrollToTop = false
            }
        } else if offset >= 0 {
            isScrollToTop = false
        }
    }
    
    func onScrollEnd(offset: CGFloat) {
        if (viewPositionY != -minScrollP || viewPositionY != 0) && offset > 0 && offset < 45 {
            viewPositionY = profileDefaultOffset
            viewProfileOpacify = 1
            welcomeTitleOpacify = 1
            profileSize = maxProfileSize
            headerPaddingBottomAsPercentage = viewProfileOpacify
            isEndScrolling = true
            isScrollToTop = true
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Colors.appBg.value
                .ignoresSafeArea()
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    VStack {
                        HomeHeader()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // MARK: - Profile
                    HStack(alignment: .center, spacing: 10){
                        Image("icBear")
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: abs(profileSize), height: abs(profileSize))
                            .padding(2)
                            .background(Color.white)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 5){
                            Text("Hello, So Cheat!")
                                .customFont(.WorkSansSemiBold())
                                .foregroundColor(Color.white)
                                .opacity(abs(welcomeTitleOpacify))
                            Button(action: {  }) {
                                Text("View Profile >")
                                    .customFont(.WorkSansRegular(size: 14))
                                    .foregroundColor(Colors.softText.value)
                            }
                            .opacity(abs(viewProfileOpacify))
                        }
                    }
                    .padding([.leading], 5)
                    .padding([.bottom], 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(y: viewPositionY)
                    .frame(height: 0)
                }
                .padding([.trailing, .leading], 18)
                ScrollView(.vertical, showsIndicators: false, content: {
                    ScrollViewReader { scrollViewProxy in
                        Spacer()
                            .frame(height: 70)
                            .id(1)
                        VStack(spacing: 5){
                            // MARK: - Balance Card
                            BalanceCardView()
                            
                            // MARK: - Service Widget
                            HStack {
                                Spacer().frame(width: 18)
                                VStack{
                                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), alignment: .center) {
                                        ReorderableForEach(firstDataList: $mainServicesData,
                                                           $draggedServiceItem,
                                                           allowReordering: $allowServiceReordering,
                                                           hasChangedLocation: $isServiceChangedLocation,
                                                           isUserMoveWidget: $isServiceWidgetMove) { item in
                                            Button(action: {
                                            }) {
                                                ZStack {
                                                    Color(draggedServiceItem == item ? UIColor(Color.white.opacity(0.3)) : .white)
                                                        .frame(width: 110, height: 100)
                                                    VStack {
                                                        Image(item.icon)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 40, height: 40)
                                                        
                                                        Text(item.name)
                                                            .customFont(.WorkSansMedium(size: 16))
                                                            .foregroundColor(Colors.textColor.value)
                                                    }
                                                }
                                            }
                                            .cornerRadius(15)
                                            .padding([.leading, .trailing], 1)
                                            .padding([.top, .bottom], 1)
                                            .onChange(of: isServiceChangedLocation, perform: { newValue in
                                                if !newValue && isWidgetChangedLocation {
                                                    isServiceChangedLocation = true
                                                }
                                            })
                                        }
                                    }
                                    .padding([.leading, .trailing, .top], 10)
                                    
                                    Divider()
                                        .overlay(.white)
                                        .padding([.top], 5)
                                        .padding([.leading, .trailing], 10)
                                    ScrollView(.horizontal, showsIndicators: false, content: {
                                        HStack{
                                            Spacer().frame(width: 10)
                                            ReorderableForEach(firstDataList: $subServicesData,
                                                               $draggedServiceItem1,
                                                               allowReordering: $allowServiceReordering,
                                                               hasChangedLocation: $isServiceChangedLocation,
                                                               isUserMoveWidget: $isServiceWidgetMove) { item in
                                                Button(action: {
                                                    
                                                }) {
                                                    HStack {
                                                        Image(item.icon)
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 30, height: 30)
                                                        Text(item.name)
                                                            .customFont(.WorkSansMedium(size: 16))
                                                            .foregroundColor(Colors.textColor.value)
                                                            .lineLimit(1)
                                                    }
                                                    .padding([.leading, .trailing], 30)
                                                    .padding([.top, .bottom], 5)
                                                    .frame(height: 50)
                                                    .background(draggedServiceItem == item ? Color.white.opacity(0.3) : Color.white)
                                                    .cornerRadius(15)
                                                }
                                            }
                                            Spacer().frame(width: 10)
                                        }
                                        .padding([.top], 5)
                                        .padding([.bottom],  10)
                                        .frame(maxWidth: .infinity, maxHeight: 70)
                                    })
                                }
                                .background(Colors.widgetFrameColor.value)
                                .cornerRadius(20)
                                Spacer().frame(width: 18)
                            }
                            
                            VStack(spacing: 5) {
                                ReorderableForEach(firstDataList:$widgetInfoList,
                                                   $draggedWidgetItem,
                                                   allowReordering: $allowWidgetReordering,
                                                   hasChangedLocation: $isWidgetChangedLocation,
                                                   isUserMoveWidget: $isWidgetMove) { item in
                                    switch item {
                                    case EXPLORED_ID:
                                        // MARK: - Explore Services
                                        ExploreView(exploreServicesData: exploreServicesData)
                                            .onChange(of: isWidgetChangedLocation, perform: { newValue in
                                                isServiceChangedLocation = newValue ? true : false
                                            })
                                        
                                    case PROMOTION_ID:
                                        // MARK: - Promotion
                                        PromotionView()
                                        
                                    case DISCOVER_ID:
                                        
                                        // MARK: - Discoveries
                                        DiscoverView()
                                    default:
                                        Spacer().frame(width: 1, height: 1)
                                    }
                                }
                            }
                        }
                        .background {
                            ScrollDetector { offset in
                                scrollAnimation(offset: offset)
                                
                            } onDraggingEnd: { offset, velocity in
                                onScrollEnd(offset: offset)
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .loadInjection()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .previewDevice("iPhone 11 Pro Max")
    }
}
