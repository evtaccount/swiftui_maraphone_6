//
//  ContentView.swift
//  Maraphon_6
//
//  Created by Evgeny Evtushenko on 14/12/2023.
//

import SwiftUI

struct ContentView: View {
  @State var isPressed: Bool = false
  let numberOfRectangles: Int = 7
  
  var body: some View {
    let rootStack = isPressed ? AnyLayout(VStackLayout(spacing: 0)) : AnyLayout(HStackLayout())
    let childStack = !isPressed ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout(spacing: 0))
    
    GeometryReader { proxy in
      rootStack {
        ForEach(0..<numberOfRectangles) { index in
          childStack {
            let rectWidth = proxy.size.height / CGFloat(numberOfRectangles)
            let horizontalGap = CGFloat(index) * (proxy.size.width - rectWidth) / CGFloat(numberOfRectangles - 1)
            let leftInset = proxy.size.width - horizontalGap - rectWidth
            let rightInset = horizontalGap
            
            Spacer()
              .frame(width: isPressed ? leftInset : 0)
            
            RoundedRectangle(cornerRadius: 12)
              .aspectRatio(contentMode: .fit)
              .foregroundStyle(.blue)
            
            Color.clear
              .frame(width: isPressed ? rightInset : 0)
          }
          .environment(\.layoutDirection, .leftToRight)
        }
        .onTapGesture {
          withAnimation {
            isPressed.toggle()
          }
        }
      }
      .environment(\.layoutDirection, .rightToLeft)
    }
  }
}

#Preview {
  ContentView()
}
