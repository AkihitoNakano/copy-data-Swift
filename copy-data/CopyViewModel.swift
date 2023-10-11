//
//  CopyViewModel.swift
//  copy-data
//
//  Created by resonant on 2023/10/11.
//

import Foundation

class CopyViewModel: ObservableObject {
  @Published var isSelectedCopy: String?
  @Published var copyData: BlockStatus?
  
  func canSelected (block: String) -> Bool{
    return isSelectedCopy == block
  }
  
  func copy() {
    
  }
  
}
