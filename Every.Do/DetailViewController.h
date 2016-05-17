//
//  DetailViewController.h
//  Every.Do
//
//  Created by Anton Moiseev on 2016-05-17.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Todo *todo;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *theTitle;

@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;

@property (weak, nonatomic) IBOutlet UILabel *completionLabel;

@end

