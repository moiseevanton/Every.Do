//
//  todo.h
//  Every.Do
//
//  Created by Anton Moiseev on 2016-05-17.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *theDescription;

@property (nonatomic) int priorityNumber;

@property (nonatomic) BOOL isCompleted;

@property (strong, nonatomic) NSString *details;

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description priority:(int)priorityNumber details:(NSString *)details;

@end
