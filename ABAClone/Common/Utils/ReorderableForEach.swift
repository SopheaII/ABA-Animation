//
//  ReorderableForEach.swift
//  ABAClone
//
//  Created by Sao Sophea on 14/8/23.
//

import SwiftUI
import UniformTypeIdentifiers

public struct ReorderableForEach<Data, Content>: View
where Data : Hashable, Content : View {
    @Binding var data: [Data]
    @Binding var secondDataList: [Data]
    @Binding var draggedItem: Data?
    @Binding var allowReordering: Bool
    @Binding var hasChangedLocation: Bool
    @Binding var isUserMoveWidget: Bool
    private let content: (Data) -> Content
    
    var startIndex: Int
    var endIndex: Int
    @State var isItemProviderEnd = false
    
    public init(firstDataList data: Binding<[Data]>,
                secondDataList: Binding<[Data]>,
                _ draggedItem: Binding<Data?>,
                startIndex: Int = 0,
                allowReordering: Binding<Bool>,
                hasChangedLocation: Binding<Bool>,
                isUserMoveWidget: Binding<Bool>,
                @ViewBuilder content: @escaping (Data) -> Content) {
        _data = data
        _secondDataList = secondDataList
        _allowReordering = allowReordering
        _draggedItem = draggedItem
        _hasChangedLocation = hasChangedLocation
        _isUserMoveWidget = isUserMoveWidget
        
        self.startIndex = startIndex
        self.endIndex = startIndex == 0 ? 6 : data.count
        self.content = content
    }
    
    public var body: some View {
        ForEach(data, id: \.self) { item in
            if allowReordering {
                content(item)
                    .onDrag {
                        draggedItem = item
                        var provider = MYItemProvider(contentsOf:  URL(string: "\(item.hashValue)")!)
                        isItemProviderEnd = !hasChangedLocation
                        hasChangedLocation = true
                        isUserMoveWidget = false
                        print("debugtest ----- onDrag")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            if !isUserMoveWidget && provider != nil {
                                print("debugtest ----- didEnd asyncAfter \(startIndex)")
                                provider = nil
                                draggedItem = nil
                                hasChangedLocation = false
                                isItemProviderEnd = true
                            }
                        })
                        provider?.didEnd = {
                            print("debugtest ----- \(isItemProviderEnd), \(hasChangedLocation)")
                            DispatchQueue.main.async {
                                print("debugtest ----- didEnd \(startIndex)")
                                draggedItem = nil
                                hasChangedLocation = false
                                isItemProviderEnd = true
                            }
                        }

                        return provider ?? NSItemProvider(object: "\(item.hashValue)" as NSString)
                    }
                    .onDrop(of: [UTType.plainText], delegate: DragRelocateDelegate(
                        item: item,
                        data: $data,
                        secondData: $secondDataList,
                        draggedItem: $draggedItem,
                        hasChangedLocation: $hasChangedLocation,
                        isItemProviderEnd: $isItemProviderEnd,
                        isUserMoveWidget: $isUserMoveWidget))
                    .wiggling(isWiggling: $hasChangedLocation, rotationAmount: 3, bounceAmount: 0.3)
            } else {
                content(item)
            }
        }
    }
    
    struct DragRelocateDelegate<Data>: DropDelegate
    where Data : Equatable {
        let item: Data
        @Binding var data: [Data]
        @Binding var secondData: [Data]
        @Binding var draggedItem: Data?
        @Binding var hasChangedLocation: Bool
        @Binding var isItemProviderEnd: Bool
        @Binding var isUserMoveWidget: Bool
        
        func dropEntered(info: DropInfo) {
            guard let current = draggedItem else { return }
            var from = data.firstIndex(of: current)
            let to = data.firstIndex(of: item)
            if item == draggedItem || from == nil || to == nil{
//                if (from == nil) {
//                    from  = secondData.firstIndex(of: current)
//                    withAnimation {
//                        data[to!] = current
//                        secondData[from!] = item
//                    }
//                }
                
                print("debugtest ----- dropEntered return")
                isUserMoveWidget = true
                return
            }
            isUserMoveWidget = true
            print("debugtest ----- dropEntered")
            
            if data[to!] != current {
                withAnimation {
                    data.move(fromOffsets: IndexSet(integer: from!),
                              toOffset: (to! > from!) ? to! + 1 : to!)
                }
            }
        }
        
        func dropUpdated(info: DropInfo) -> DropProposal? {
            return DropProposal(operation: .move)
        }
        
        func performDrop(info: DropInfo) -> Bool {
            print("debugtest ----- performDrop")
            hasChangedLocation = false
            draggedItem = nil
            isItemProviderEnd = true
            return true
        }
        
        func dropExited(info: DropInfo) {
            print("debugtest ----- dropExited")
        }
    }
}

class MYItemProvider: NSItemProvider {
    var didEnd: (() -> Void)?
    
    deinit {
        didEnd?()
    }
}
