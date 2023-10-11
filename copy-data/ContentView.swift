//
//  ContentView.swift
//  copy-data
//
//  Created by resonant on 2023/10/11.
//

import SwiftUI


struct CopyBlockView: View {
  
  @ObservedObject var cpVM: CopyViewModel
  var blockName: String
  
  @State private var status: BlockStatus = BlockStatus(text: "", color: Color.gray)
  
  var bgColor: Color {
    self.cpVM.canSelected(block: self.blockName) ? Color.red : Color.gray
  }
  
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(bgColor)
      Rectangle()
        .stroke(style: .init(lineWidth: 10))
        .fill(status.color)
      Text(status.text)
        .foregroundColor(Color.black)
    }
    .frame(width: 100, height: 100)
    .onTapGesture {
      cpVM.isSelectedCopy = self.blockName
    }
    .onChange(of: cpVM.didCompleteCopy) { didCopy in
      if didCopy && cpVM.isSelectedCopy == self.blockName, let unwrappedStatus = cpVM.copyData {
        self.status = unwrappedStatus
        cpVM.didCompleteCopy = false
        cpVM.isSelectedCopy = nil
      }
    }
  }
}

struct BlockView: View {
  
  let cpVM: CopyViewModel
  var status: BlockStatus
  
  init(cpVM: CopyViewModel,status: BlockStatus) {
    self.cpVM = cpVM
    self.status = status
  }
  
  var body: some View {
    ZStack {
      Rectangle()
        .stroke(style: .init(lineWidth: 10))
        .fill(status.color)
      Text(status.text)
        .foregroundColor(Color.black)
    }
    .frame(width: 100, height: 100)
    .onTapGesture {
      if let _ = cpVM.isSelectedCopy {
        cpVM.copy(blockStatus: self.status)
      }
    }
  }
  
}

struct ContentView: View {
  var cpVM = CopyViewModel()
  
  var body: some View {
    VStack {
      HStack {
        CopyBlockView(cpVM: cpVM, blockName: "copy1")
        CopyBlockView(cpVM: cpVM, blockName: "copy2")
      }
      HStack {
        BlockView(cpVM: cpVM ,status: BlockStatus(text: "A", color: Color.green))
        BlockView(cpVM: cpVM , status: BlockStatus(text: "B", color: Color.blue))
      }
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
