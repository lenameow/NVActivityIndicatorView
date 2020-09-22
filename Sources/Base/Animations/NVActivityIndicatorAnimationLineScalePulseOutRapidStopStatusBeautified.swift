//
//  NVActivityIndicatorAnimationLineScalePulseOutRapidStopStatusBeautified.swift
//  NVActivityIndicatorView
//
//  Created by Lena on 22/9/20.

// The MIT License (MIT)

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#if canImport(UIKit)
import UIKit

class NVActivityIndicatorAnimationLineScalePulseOutRapidStopStatusBeautified: NVActivityIndicatorAnimationDelegate {

    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let lineSize = size.width / 9
        let lineHeights = [CGFloat(1),
                           CGFloat(0.3),
                           CGFloat(1),
                           CGFloat(0.3),
                           CGFloat(1)]
        let x = (layer.bounds.size.width - size.width) / 2
        let frameY = (layer.bounds.size.height - size.height) / 2
        var y: CGFloat = 0
        let duration: CFTimeInterval = 0.9
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.5, 0.25, 0, 0.25, 0.5]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.11, 0.49, 0.38, 0.78)

        // Animation
        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")

        animation.keyTimes = [0, 0.8, 0.9]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.beginTime = beginTime
//        animation.values = [1, 0.3, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        // Draw lines
        for i in 0 ..< 5 {
            animation.values = [1 / lineHeights[i], 0.3 / lineHeights[i], 1 / lineHeights[i]]
                y = (layer.bounds.size.height - lineHeights[i] * size.height) / 2
            let line = NVActivityIndicatorShape.centeredLine.layerWith(
                x: 0,
                y: size.height * (1 - lineHeights[i]) / 2,
                size: CGSize(
                    width: lineSize,
                    height: size.height * lineHeights[i]),
                color: color
            )
            let frame = CGRect(x: x + lineSize * 2 * CGFloat(i),
//                               y: y + (1 - lineHeights[i]) / 2 * size.height,
                               y: frameY,
                               width: lineSize,
                               height: size.height)

            animation.beginTime = beginTime + beginTimes[i]
            line.frame = frame
            line.add(animation, forKey: "animation")
            layer.addSublayer(line)
        }
    }
}
#endif
