//
//  todo.m
//  Every.Do
//
//  Created by Anton Moiseev on 2016-05-17.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)init {
    
    return [self initWithTitle:@"" description:@"" priority:0 details:@""];
    
}

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description priority:(int)priorityNumber details:(NSString *)details {
    
    self = [super init];
    
    if (self) {
        
        _title = title;
        _theDescription = description;
        _priorityNumber = priorityNumber;
        _details = details;
        _isCompleted = NO;
        
    }
    return self;
}

@end
