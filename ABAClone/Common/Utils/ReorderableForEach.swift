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
    @Binding var draggedItem: Data?
    @Binding var allowReordering: Bool
    @Binding var hasChangedLocation: Bool
    @Binding var isUserMoveWidget: Bool
    private let content: (Data) -> Content
    
    @State var isItemProviderEnd = false
    
    public init(firstDataList data: Binding<[Data]>,
                _ draggedItem: Binding<Data?>,
                allowReordering: Binding<Bool>,
                hasChangedLocation: Binding<Bool>,
                isUserMoveWidget: Binding<Bool>,
                @ViewBuilder content: @escaping (Data) -> Content) {
        _data = data
        _allowReordering = allowReordering
        _draggedItem = draggedItem
        _hasChangedLocation = hasChangedLocation
        _isUserMoveWidget = isUserMoveWidget
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            if !isUserMoveWidget && provider != nil {
                                provider = nil
                                draggedItem = nil
                                hasChangedLocation = false
                                isItemProviderEnd = true
                            }
                        })
                        provider?.didEnd = {
                            DispatchQueue.main.async {
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
        @Binding var draggedItem: Data?
        @Binding var hasChangedLocation: Bool
        @Binding var isItemProviderEnd: Bool
        @Binding var isUserMoveWidget: Bool
        
        func dropEntered(info: DropInfo) {
            guard let current = draggedItem else { return }
            let from = data.firstIndex(of: current)
            let to = data.firstIndex(of: item)
            isUserMoveWidget = true
            
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
            hasChangedLocation = false
            draggedItem = nil
            isItemProviderEnd = true
            return true
        }
        
        func dropExited(info: DropInfo) {
        }
    }
}

class MYItemProvider: NSItemProvider {
    var didEnd: (() -> Void)?
    
    deinit {
        didEnd?()
    }
}
