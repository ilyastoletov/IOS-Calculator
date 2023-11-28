//
//  ContentView.swift
//  Calculator
//
//  Created by Ilya Stoletov on 28.11.2023.
//

import SwiftUI
import Foundation

struct MainCalculatorView: View {
    
    @State private var expression: String = ""
    
    private let linesDict: [Int: [String]] = [
        1: ["7", "8", "9", "*"],
        2: ["4", "5", "6", "+"],
        3: ["1", "2", "3", "-"],
        4: ["0", "C", "/", "="]
    ]
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(expression)
                .font(.system(size: 55))
            ForEach(1..<5) { i in
                HStack {
                    ForEach(0..<linesDict[i]!.count) { j in
                        NumPad(
                            expression: $expression,
                            num: linesDict[i]![j]
                        )
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    

}

struct NumPad: View {
    
    @Binding var expression: String
    var num: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .frame(width: 80, height: 80)
            
            Text(num)
                .foregroundColor(.white)
                .font(.system(size: 30))
        }.onTapGesture {
            switch num {
            case "C":
                expression = ""
            case "=":
                let evaluatedExpression = evalExpression(expression: expression)
                expression = evaluatedExpression != nil ? evaluatedExpression! : "Error"
            default:
                expression += num
            }
        }
    }
    
    private func evalExpression(expression: String) -> String? {
        let formattedExpression = NSExpression(format: expression)
        
        if let result = formattedExpression.expressionValue(with: nil, context: nil) as? NSNumber {
            return "\(result.intValue)"
        } else {
            return nil
        }
    }

    
}

#Preview {
    MainCalculatorView()
}
