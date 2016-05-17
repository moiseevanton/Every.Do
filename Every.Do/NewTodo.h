//
//  NewTodo.h
//  Every.Do
//
//  Created by Anton Moiseev on 2016-05-17.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@protocol NewTodoDelegate <NSObject>

- (void)addTodo:(Todo *)theNewTodo;

@end

@interface NewTodo : UIViewController

@property (weak, nonatomic) id<NewTodoDelegate> delegate;

@end
