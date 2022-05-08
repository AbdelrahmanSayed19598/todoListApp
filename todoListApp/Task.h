//
//  Task.h
//  todoListApp
//
//  Created by AbdElrahman sayed on 05/04/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
@property NSString * name;
@property NSString * taskDescription;
@property int taskPriority;
@property int taskState;
@property NSDate *date;


@end

NS_ASSUME_NONNULL_END
