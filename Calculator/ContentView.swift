//
//  ContentView.swift
//  Calculator
//
//  Created by 二渡和輝 on 2020/03/02.
//  Copyright © 2020 二渡和輝. All rights reserved.
//

import SwiftUI
import Darwin

extension Color {
    
    static let offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
    
    static let darkStart = Color(red: 50/255, green: 60/255, blue: 65/255)
    
    static let darkEnd = Color(red: 25/255, green: 25/255, blue: 30/255)
    
    static let orangeStart = Color(red: 255/255, green: 209/255, blue: 42/255)
    
    static let orangeEnd = Color(red: 220/255, green: 130/255, blue: 0/255)
    
    static let grayStart = Color(red: 150/255, green: 150/255, blue: 150/255)
    
    static let grayEnd = Color(red: 50/255, green: 50/255, blue: 50/255)
    
}

extension LinearGradient {
    
    init(_ colors: Color...)  {
        
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
        
    }
}

struct SimpleButtonStyle: ButtonStyle {
    
    var backgroundColor1: LinearGradient
    var backgroundColor2: LinearGradient
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed{
                        Circle().fill(backgroundColor2)
                            .overlay(
                                
                                Circle()
                                    .stroke(backgroundColor1, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(
                                        
                                        Circle()
                                            .fill(backgroundColor1)
                                        
                                    )
                        ).overlay(
                            
                            Circle()
                                .stroke(backgroundColor2, lineWidth: 8)
                                .blur(radius: 4)
                                .offset(x: -2, y: -2)
                                .mask(
                                    
                                    Circle()
                                        .fill(backgroundColor1)
                                    
                                )
                        )
                    } else {
                        Circle().fill(backgroundColor1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.clear.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
        )
    }
}



enum CalculatorButton: String {
    
    case zero, zeroZero, one, two, three, four, five, six, seven, eight, nine, decimal
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent
    
    var title: String {
        
        switch self {
        case .zero: return "0"
        case .zeroZero: return "00"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .decimal: return "."
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        default:
            return "AC"
        }
    }
    
    var backgroundColor1: LinearGradient {
        switch self {
        case .zero, .zeroZero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return LinearGradient(Color.darkStart, Color.darkEnd)
        case .ac, .plusMinus, .percent:
            return LinearGradient(Color.grayStart, Color.grayEnd)
        default:
            return LinearGradient(Color.orangeStart, Color.orangeEnd)
        }
    }
    
    var backgroundColor2: LinearGradient {
        switch self {
        case .zero, .zeroZero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return LinearGradient(Color.darkEnd, Color.darkStart)
        case .ac, .plusMinus, .percent:
            return LinearGradient(Color.grayEnd, Color.grayStart)
        default:
            return LinearGradient(Color.orangeEnd, Color.orangeStart)
        }
    }
}

//Environment Object
class GlobalEnvironment: ObservableObject{
    
    @Published var display = "0"
    var inputNumber = ""
    var addNumber = ""
    var minusNumber = ""
    var multiplyNumber = ""
    var divideNumber = ""
    var percentNumber = ""
    var lastInput = ""
    
    func receiveInput(calculatorButton: CalculatorButton) {
        
        self.inputNumber = calculatorButton.title
        
        if inputNumber == "AC" {
            self.display = "0"
            self.lastInput = ""
        }else if inputNumber == "="{
            if lastInput == "+" {
                self.display = String(round((atof(addNumber) + atof(display))*100000)/100000)
            }else if lastInput == "-" {
                self.display = String(round((atof(minusNumber) - atof(display))*100000)/100000)
            }else if lastInput == "×" {
                self.display = String(round((atof(multiplyNumber) * atof(display))*100000)/100000)
            }else if lastInput == "÷" {
                self.display = String(round((atof(divideNumber) / atof(display))*100000)/100000)
            }else if lastInput == "%" {
                self.display = String(round(atof(percentNumber) * (atof(display)/100)*100000)/100000)
            }
        }else if inputNumber == "+" {
            if lastInput == "+" {
                self.display = String(round((atof(addNumber) + atof(display))*100000)/100000)
            }else if lastInput == "-" {
                self.display = String(round((atof(minusNumber) - atof(display))*100000)/100000)
            }else if lastInput == "×" {
                self.display = String(round((atof(multiplyNumber) * atof(display))*100000)/100000)
            }else if lastInput == "÷" {
                self.display = String(round((atof(divideNumber) / atof(display))*100000)/100000)
            }else if lastInput == "%" {
                self.display = String(round(atof(percentNumber) * (atof(display)/100)*100000)/100000)
            }
            self.addNumber = display
            self.lastInput = inputNumber
        }else if inputNumber == "-" {
            if display == "0" {
                self.display = "-"
            }else if lastInput == "+" {
                self.display = String(round((atof(addNumber) + atof(display))*100000)/100000)
            }else if lastInput == "-" {
                self.display = String(round((atof(minusNumber) - atof(display))*100000)/100000)
            }else if lastInput == "×" {
                self.display = String(round((atof(multiplyNumber) * atof(display))*100000)/100000)
            }else if lastInput == "÷" {
                self.display = String(round((atof(divideNumber) / atof(display))*100000)/100000)
            }else if lastInput == "%" {
                self.display = String(round(atof(percentNumber) * (atof(display)/100)*100000)/100000)
            }
            self.minusNumber = display
            self.lastInput = inputNumber
        }else if inputNumber == "×" {
            if lastInput == "+" {
                self.display = String(round((atof(addNumber) + atof(display))*100000)/100000)
            }else if lastInput == "-" {
                self.display = String(round((atof(minusNumber) - atof(display))*100000)/100000)
            }else if lastInput == "×" {
                self.display = String(round((atof(multiplyNumber) * atof(display))*100000)/100000)
            }else if lastInput == "÷" {
                self.display = String(round((atof(divideNumber) / atof(display))*100000)/100000)
            }else if lastInput == "%" {
                self.display = String(round(atof(percentNumber) * (atof(display)/100)*100000)/100000)
            }
            self.multiplyNumber = display
            self.lastInput = inputNumber
        }else if inputNumber == "÷" {
            if lastInput == "+" {
                self.display = String(round((atof(addNumber) + atof(display))*100000)/100000)
            }else if lastInput == "-" {
                self.display = String(round((atof(minusNumber) - atof(display))*100000)/100000)
            }else if lastInput == "×" {
                self.display = String(round((atof(multiplyNumber) * atof(display))*100000)/100000)
            }else if lastInput == "÷" {
                self.display = String(round((atof(divideNumber) / atof(display))*100000)/100000)
            }else if lastInput == "%" {
                self.display = String(round(atof(percentNumber) * (atof(display)/100)*100000)/100000)
            }
            self.divideNumber = display
            self.lastInput = inputNumber
        }else if inputNumber == "%" {
            if lastInput == "+" {
                self.display = String(round((atof(addNumber) + atof(display))*100000)/100000)
            }else if lastInput == "-" {
                self.display = String(round((atof(minusNumber) - atof(display))*100000)/100000)
            }else if lastInput == "×" {
                self.display = String(round((atof(multiplyNumber) * atof(display))*100000)/100000)
            }else if lastInput == "÷" {
                self.display = String(round((atof(divideNumber) / atof(display))*100000)/100000)
            }else if lastInput == "%" {
                self.display = String(round(atof(percentNumber) * (atof(display)/100)*100000)/100000)
            }
            self.percentNumber = display
            self.lastInput = inputNumber
        }else if inputNumber == "+/-" {
            self.display = String(atof(display) * -1)
            self.lastInput = ""
        }else if inputNumber == "00" {
            if display == "0" {
                display = "0"
            } else {
                self.display += inputNumber
            }
//        }else if inputNumber == "." {
//            self.display += inputNumber
        }else if display == "0" {
            if inputNumber == "." {
                self.display += inputNumber
            } else {
                self.display = inputNumber
            }
        }else if addNumber == display {
            self.display = inputNumber
        }else if minusNumber == display {
            self.display = inputNumber
        }else if multiplyNumber == display {
            self.display = inputNumber
        }else if divideNumber == display {
            self.display = inputNumber
        }else if percentNumber == display {
            self.display = inputNumber
        
        }else{
            self.display += inputNumber
        }
        
    }
}


struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let button: [[CalculatorButton]] = [
        
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .zeroZero, .decimal, .equals]
        
    ]
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            
            LinearGradient(Color.darkStart, Color.darkEnd).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12){
                
                HStack {
                    
                    Spacer()
                    
                    Text(env.display)
                        .foregroundColor(Color.white)
                        .font(.system(size: 64))
                    
                }.padding()
                
                ForEach(button, id: \.self) { row in
                    
                    HStack (spacing: 12) {
                        
                        ForEach(row, id: \.self) { button in
                            
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button(action: {
            
            self.env.receiveInput(calculatorButton: self.button)
            
        }) {
            
            Text(button.title)
                .font(.system(size: 32))
                .fontWeight(.semibold)
                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5*12) / 4)
                .foregroundColor(Color.white)
                .cornerRadius(self.buttonWidth(button: button))
            
        }.buttonStyle(SimpleButtonStyle(backgroundColor1: button.backgroundColor1, backgroundColor2: button.backgroundColor2))
    }
    
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        
        return (UIScreen.main.bounds.width - 5*12) / 4
        
    }
}
