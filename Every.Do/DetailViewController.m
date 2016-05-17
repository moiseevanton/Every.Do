//
//  DetailViewController.m
//  Every.Do
//
//  Created by Anton Moiseev on 2016-05-17.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setTodo:(id)newDetailItem {
    if (_todo != newDetailItem) {
        _todo = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.todo) {
        self.title = @"Details";
        self.theTitle.text = self.todo.title;
        self.detailDescriptionLabel.text = self.todo.details;
        self.priorityLabel.text = [NSString stringWithFormat:@"Priority: %d", self.todo.priorityNumber];
        self.completionLabel.text = [NSString stringWithFormat:@"Completed: %@", self.todo.isCompleted ? @"YES" : @"NO"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
