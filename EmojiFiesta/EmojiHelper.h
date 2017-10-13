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

+ (NSArray *)categories;
+ (NSInteger)numberOfCategories;
+ (id)categoryForType:(NSInteger)type;
+ (id)computeEmojiFlagsSortedByLanguage;
+ (NSString *)displayName:(long long)arg;

@end

@interface EmojiHelper : NSObject

+ (NSArray<NSString *> *)getAllEmojis;
+ (NSArray<MyEmojiCategory *> *)getAllEmojisInCategories;

@end
