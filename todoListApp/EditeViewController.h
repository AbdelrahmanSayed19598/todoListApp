//
//  EditeViewController.h
//  todoListApp
//
//  Created by AbdElrahman sayed on 05/04/2022.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditeViewController : UIViewController
@property Task * task;
@property int taskIndex;
@end

NS_ASSUME_NONNULL_END
