//
//  EmojiHelper.m
//  EmojiFun
//
//  Created by Sabatino Masala on 01/10/15.
//  Copyright © 2015 Sabatino Masala. All rights reserved.
//

#import "EmojiHelper.h"
#import "MyEmojiCategory.h"
#import "MyEmoji.h"

@implementation EmojiHelper

+ (NSArray<MyEmojiCategory *> *)getEmoji {
  
  // Let's get a reference to Apple's UIKeyboardEmojiCategory class
  Class UIKeyboardEmojiCategory = NSClassFromString(@"UIKeyboardEmojiCategory");
  
  // Loop over all categories & save them in an array
  NSMutableArray *categories = [NSMutableArray array];
  
  if ([UIKeyboardEmojiCategory respondsToSelector:@selector(numberOfCategories)]) {
    NSInteger numberOfCategories = [UIKeyboardEmojiCategory numberOfCategories];
    
    for (NSUInteger i = 0; i < numberOfCategories; i++) {
      [categories addObject:[UIKeyboardEmojiCategory categoryForType:i]];
    }
  }
  
  NSMutableArray *returnValue = [NSMutableArray array];
  
  // Loop over all categories
  for (id category in categories) {
    
    // Let's get thte category name
    NSString *categoryName = [category performSelector:@selector(name)];
    
    // Ignore the 'recent' category, so we only get unique Emoji
    if ([categoryName hasSuffix:@"Recent"]) {
      continue;
    }
    
    // Get the display name for the current category
    NSString *displayName = [UIKeyboardEmojiCategory displayName:(int)[categories indexOfObject:category]];
    
    // Instanciate our own category container
    MyEmojiCategory *myEmojiCategory = [MyEmojiCategory new];
    myEmojiCategory.name = displayName;
    
    // The flags category is a bit special, we have to compute the flags and populate the array ourselves
    if ([displayName isEqualToString:@"Flags"]) {
      
      // flagEmoji contains the emoji itself
      NSArray *flagEmoji = [UIKeyboardEmojiCategory computeEmojiFlagsSortedByLanguage];
      NSMutableArray *arrFlagEmoji = [NSMutableArray new];
      
      // Loop over every flag & wrap them in a dict so it conforms to the other categories
      for (NSString *flag in flagEmoji) {
        [arrFlagEmoji addObject:@{
                                  @"emojiString": flag,
                                  @"variantMask": @0
                                  }];
      }
      
      // Set all the emoji on the flag category
      [category setEmoji:arrFlagEmoji];
    }
    
    // Let's create an array of Emoji for this category
    NSMutableArray *categoryEmoji = [NSMutableArray array];
    NSMutableArray *emojiArray = [category valueForKey:@"emoji"];
    
    for (id emoji in emojiArray) {
      
      // Emoji! 🎉
      NSString *emojiString = [emoji valueForKey:@"emojiString"];
      
      // Create our own emoji container
      MyEmoji *myEmoji = [MyEmoji new];
      myEmoji.emojiString = emojiString;
      
      // Let's create the variations container
      NSMutableArray<NSString *> *emojiVariations = [NSMutableArray new];
      [emojiVariations addObject:emojiString];
      
      // Variant mask indicates whether or not there are variations for a given emoji
      int vmask = [[emoji valueForKey:@"variantMask"] intValue];
      
      // Fritzpatrick scale https://en.wikipedia.org/wiki/Fitzpatrick_scale
      // Diversity http://www.unicode.org/reports/tr51/index.html#Diversity
      if (vmask == 2 || vmask == 3) {
        // These codes are specified on the unicode consortium website
        [emojiVariations addObject:[NSString stringWithFormat:@"%@\U0001F3FB", emojiString]]; // 1-2
        [emojiVariations addObject:[NSString stringWithFormat:@"%@\U0001F3FC", emojiString]]; // 3
        [emojiVariations addObject:[NSString stringWithFormat:@"%@\U0001F3FD", emojiString]]; // 4
        [emojiVariations addObject:[NSString stringWithFormat:@"%@\U0001F3FE", emojiString]]; // 5
        [emojiVariations addObject:[NSString stringWithFormat:@"%@\U0001F3FF", emojiString]]; // 6
      }
      
      // Set the variations
      myEmoji.variations = emojiVariations;
      
      // Add the emoji to the category
      [categoryEmoji addObject:myEmoji];
      
    }
    
    // Set all the emoji on the category
    myEmojiCategory.emoji = categoryEmoji;
    
    // Add the category to the return array
    [returnValue addObject:myEmojiCategory];
  }
  
  return returnValue;
}

@end