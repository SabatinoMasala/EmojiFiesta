//
//  MyTableViewController.m
//  EmojiFun
//
//  Created by Sabatino Masala on 01/10/15.
//  Copyright © 2015 Sabatino Masala. All rights reserved.
//

#import "MyTableViewController.h"
#import "EmojiHelper.h"
#import "MyEmojiCategory.h"

@interface MyTableViewController ()

@property (strong, nonatomic) NSArray<MyEmojiCategory *> *emojiCategories;

@end

@implementation MyTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Emoji fiesta! 🎉";
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"emojiCell"];
  
  self.emojiCategories = [EmojiHelper getAllEmojisInCategories];
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.emojiCategories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  MyEmojiCategory *category = [self.emojiCategories objectAtIndex:section];

  return [category.emoji count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emojiCell" forIndexPath:indexPath];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"emojiCell"];
  }
  
  cell.textLabel.text = [self getEmojiStringAtIndexPath:indexPath];
  
  return cell;
}

- (NSString *)getEmojiStringAtIndexPath:(NSIndexPath *)indexPath {
  
  MyEmojiCategory *emojiCategory = [self.emojiCategories objectAtIndex:indexPath.section];
  MyEmoji *emoji = [emojiCategory.emoji objectAtIndex:indexPath.row];
  
  return [emoji.variations componentsJoinedByString:@" "];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  MyEmojiCategory *emojiCategory = [self.emojiCategories objectAtIndex:section];
  
  return emojiCategory.name;
}

@end
