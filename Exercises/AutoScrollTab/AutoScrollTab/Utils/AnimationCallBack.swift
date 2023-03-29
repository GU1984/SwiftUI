//
//  AnimationCallBack.swift
//  AutoScrollTab
//
//  Created by Георгий Усынин on 29.03.2023.
//

import SwiftUI

struct AnimationState {
    var progress: CFloat = 0
    var status: Bool = false
    
    mutating func startAnimation() {
        progress = 1.0
        status = true
    }
    
    mutating func reset() {
        progress = .zero
        status = false
    }
    
}
struct AnimationEndCallback<Value: VectorArithmetic>: Animatable, ViewModifier {
    var animatableData: Value {
        didSet {
            checkIfAniationFinished()
        }
    }
    
    var endValue: Value
    var onEnd: () -> ()
    
    init(endValue: Value, onEnd: @escaping() -> ()) {
        self.endValue = endValue
        self.animatableData = endValue
        self.onEnd = onEnd
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    func checkIfAniationFinished()  {
        if animatableData == endValue {
            DispatchQueue.main.async {
                onEnd()
            }
        }
    }
}
