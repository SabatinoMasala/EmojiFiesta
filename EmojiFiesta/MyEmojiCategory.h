//
//  MyEmojiCategory.h
//  EmojiFun
//
//  Created by Sabatino Masala on 01/10/15.
//  Copyright © 2015 Sabatino Masala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyEmoji.h"

@interface MyEmojiCategory : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray<MyEmoji *> *emoji;

@end