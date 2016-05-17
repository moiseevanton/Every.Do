//
//  DetailViewController.h
//  Every.Do
//
//  Created by Anton Moiseev on 2016-05-17.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

