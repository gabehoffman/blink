//
//  ViewController.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/5/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let blink = BlinkModel()
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var answerSlider: UISlider!
    
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        // Save Current Values
        blink.answers[blink.currentQuestionIndex] = Int(answerSlider.value)
        
        // Set next question/answer values
        nextQuestionLabel.text = blink.nextQuestion
        answerLabel.text = "\(blink.nextAnswer)"
        let nextValue: Float = Float(blink.nextAnswer)
        answerSlider.setValue(nextValue, animated: true)
        
        // Go to next question/answer
        blink.next()
        animateLabelTransitions()
    }
    
    @IBAction func swipeNextQuestion(sender: AnyObject) {
        showNextQuestion(sender)
    }
    
    @IBAction func swipePreviousQuestion(sender: AnyObject) {
        // Save Current Value
        blink.answers[blink.currentQuestionIndex] = Int(answerSlider.value)
        
        // Set previous question/answer values
        nextQuestionLabel.text = blink.previousQuestion
        answerLabel.text = "\(blink.previousAnswer)"
        let previousValue: Float = Float(blink.previousAnswer)
        answerSlider.setValue(previousValue, animated: true)
        
        // Go to previous question/answer
        blink.previous()
        animateLabelTransitions()
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        answerLabel.text = "\(Int(answerSlider.value))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestionLabel.text = blink.questions[0]
        answerLabel.text = "\(blink.currentAnswer)"
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenwidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenwidth
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the label's initial alpha
        nextQuestionLabel.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded()
        
        // Animate the alpha and the center X contraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.5,
            options: [.CurveLinear],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                
                self.updateOffScreenLabel()
        })
    }
}

