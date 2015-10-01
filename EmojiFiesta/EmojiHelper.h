//
//  EmojiHelper.h
//  EmojiFun
//
//  Created by Sabatino Masala on 01/10/15.
//  Copyright © 2015 Sabatino Masala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyEmojiCategory.h"

@interface NSObject (UIKeyboardEmojiCategory)

+ (NSInteger)numberOfCategories;
+ (id)categoryForType:(NSInteger)type;
+ (id)displayName:(int)arg1;
- (void)setEmoji:(id)arg1;
+ (id)computeEmojiFlagsSortedByLanguage;

@end

@interface EmojiHelper : NSObject

+ (NSArray<MyEmojiCategory *> *)getEmoji;

@end
