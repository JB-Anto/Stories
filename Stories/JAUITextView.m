//
//  JATextView.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAUITextView.h"

@implementation JAUITextView

- (void)initWithString:(NSString *)text
{
    
    [self setText:text];
    [self addLink];
    [self applyLetterSpacing];
    [self applyLineHeight];
}

- (void)initWithStringToFormat:(NSString *)text
{
    if(text.length > 0) {
        text = [[text substringToIndex:text.length-1] stringByAppendingString:[NSString stringWithUTF8String:" \u25a0"]];
    }
    
    [self initWithString:text];
    NSMutableAttributedString *attributedText = [self.attributedText mutableCopy];
    NSRange lastCharacterRange = NSMakeRange(self.text.length-1, 1);
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:14.0f]} range:lastCharacterRange];
    self.attributedText = attributedText;
}

- (void)addLink
{
    NSString *stringToProcess = self.text;

    //First remove the "/" from the string.  This will make two instances of <b> in the string
    NSString *processedString = [stringToProcess stringByReplacingOccurrencesOfString:@"/" withString:@""];
    //Chop the string into pieces using <b> as the chopping point
    NSArray *choppedString = [processedString componentsSeparatedByString:@"<link>"];
    //Remove the <link> from the string now that it's been chopped up
    processedString = [processedString stringByReplacingOccurrencesOfString:@"<link>" withString:@""];
    [self setText:processedString];

    long numberOfString = [choppedString count];
    int indexOfLinks = 0;
    
    if(numberOfString > 1) {
        
        self.linkDelegate = self;
        self.minimumPressDuration = 1.0;
        
        NSMutableAttributedString *attributedText = [self.attributedText mutableCopy];
        NSDictionary *boldAttributes = [NSDictionary dictionaryWithObjectsAndKeys:self.linkColor, NSForegroundColorAttributeName, nil];

            for(int i=1; i < numberOfString-1; i += 2) {
                int j = i;
                long lengthOfFirstComponent = 0;
                while(j!=0) {
                    j--;
                    lengthOfFirstComponent += [[choppedString objectAtIndex:j] length];
                }
                
            long lengthOfBoldComponent  = [[choppedString objectAtIndex:i] length];
        
            NSRange boldRange = NSMakeRange(lengthOfFirstComponent, lengthOfBoldComponent);
            [attributedText addAttribute:CCHLinkAttributeName value:self.links[indexOfLinks] range:boldRange];
            
            indexOfLinks++;
                
        }

        self.linkTextAttributes = boldAttributes;
        self.attributedText = attributedText;
        
    }
}

- (void)linkTextView:(CCHLinkTextView *)linkTextView didLongPressLinkWithValue:(id)value
{
    NSLog(@"%@", value);
}

- (void)applyLineHeight
{
    NSMutableAttributedString* attrString = self.attributedText.mutableCopy;
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    [style setLineHeightMultiple:self.lineHeight];
    
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, [self.text length])];
    
    self.attributedText = attrString;
    
}

-(void)applyLetterSpacing
{
    NSMutableAttributedString* attrString = self.attributedText.mutableCopy;
    [attrString addAttribute:NSKernAttributeName
                       value:@(self.letterSpacing)
                       range:NSMakeRange(0, [self.text length])];
    
    self.attributedText = attrString;
    
}

@end
