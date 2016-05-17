//
//  MasterViewController.m
//  Every.Do
//
//  Created by Anton Moiseev on 2016-05-17.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TodoCell.h"
#import "NewTodo.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource, NewTodoDelegate>

@property NSMutableArray *objects;

@property Todo *doneTodo;

- (void)back;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.tableView.rowHeight = 70;
    
    // creating an empty array
    
    self.objects = [NSMutableArray new];
    
    // instantiating todos
    
    Todo *todo1 = [[Todo alloc] initWithTitle:@"Buy milk" description:@"Go to the market to buy milk" priority:3 details:@"Do it after work!"];
    Todo *todo2 = [[Todo alloc] initWithTitle:@"Running" description:@"Go for a run at Queen's Park" priority:2 details:@"Distance: 6 km"];
    Todo *todo3 = [[Todo alloc] initWithTitle:@"Lunch" description:@"Go for lunch with Nanfa" priority:1 details:@"Time: 2pm"];
    
    NSArray *myTodos = @[todo1, todo2, todo3];
    
    [self.objects addObjectsFromArray:myTodos];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    
    [self performSegueWithIdentifier:@"enterTodo" sender:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *ourTodo = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setTodo:ourTodo];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    if ([segue.identifier isEqualToString:@"enterTodo"]) {
        
        NewTodo *todo = (NewTodo *)segue.destinationViewController;
        
        todo.delegate = self;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OurCell" forIndexPath:indexPath];

    Todo *ourTodo = self.objects[indexPath.row];
    cell.title.text = ourTodo.title;
    cell.theDescription.text = ourTodo.theDescription;
    cell.priority.text = [NSString stringWithFormat:@"Priority: %d", ourTodo.priorityNumber];
    
    if (ourTodo.isCompleted) {
        
        NSMutableAttributedString *newTitle = [[NSMutableAttributedString alloc] initWithString:ourTodo.title];
        [newTitle addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [newTitle length])];
        cell.title.attributedText = newTitle;
        
        NSMutableAttributedString *newDescription = [[NSMutableAttributedString alloc] initWithString:ourTodo.theDescription];
        [newDescription addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [newDescription length])];
        cell.theDescription.attributedText = newDescription;
        
        NSMutableAttributedString *newPriority = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Priority: %d", ourTodo.priorityNumber]];
        [newPriority addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [ [NSString stringWithFormat:@"Priority: %d", ourTodo.priorityNumber] length])];
        cell.priority.attributedText = newPriority;
        
    }
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiping:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [cell addGestureRecognizer:swipe];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)addTodo:(Todo *)theNewTodo{
    
    [self.objects insertObject:theNewTodo atIndex:0];
    [self.tableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected section: %ld, row: %ld", indexPath.section, indexPath.row);
}

- (void)swiping:(UISwipeGestureRecognizer *)sender {
    
    Todo *completedTodo = [Todo new];
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        UITableViewCell *cell = (UITableViewCell *)sender.view;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if (self.objects[indexPath.row] != nil) {
            
            completedTodo = self.objects[indexPath.row];
            completedTodo.isCompleted = YES;
            self.doneTodo = completedTodo;
            
        }
        
    }
    [self.tableView reloadData];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(back) userInfo:nil repeats:NO];
}

- (void)back {
    
    [self.objects removeObject:self.doneTodo];
    [self.objects addObject:self.doneTodo];
    [self.tableView reloadData];
}
@end
