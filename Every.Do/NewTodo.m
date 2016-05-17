//
//  NewTodo.m
//  Every.Do
//
//  Created by Anton Moiseev on 2016-05-17.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "NewTodo.h"

@interface NewTodo () <UITextFieldDelegate>

@property Todo *theTodo;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;

@property (weak, nonatomic) IBOutlet UITextField *detailsTextField;

@property (weak, nonatomic) IBOutlet UIButton *createNewTodo;

@end

@implementation NewTodo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.createNewTodo addTarget:self action:@selector(makeNewTodo) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeNewTodo {
    
    self.theTodo = [[Todo alloc] initWithTitle:self.titleTextField.text description:self.descriptionTextField.text priority:[self.priorityTextField.text intValue] details:self.detailsTextField.text];
    
    [self.delegate addTodo:self.theTodo];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
