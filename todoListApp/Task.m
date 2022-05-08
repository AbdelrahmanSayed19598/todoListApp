//
//  Task.m
//  todoListApp
//
//  Created by AbdElrahman sayed on 05/04/2022.
//

#import "Task.h"

@implementation Task
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_taskDescription forKey:@"desc"];
    [coder encodeObject:_date forKey:@"date"];
    [coder encodeInt:_taskPriority forKey:@"priority"];
    [coder encodeInt:_taskState forKey:@"state"];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{   self = [super init];
    if (self != nil) {
        _name = [coder decodeObjectForKey:@"name"];
        _date = [coder decodeObjectForKey:@"date"];
        _taskPriority = [coder decodeIntForKey:@"priority"];
        _taskDescription = [coder decodeObjectForKey:@"desc"];
        _taskState = [coder decodeIntForKey:@"state"];
    }
    return self;
}
@end
