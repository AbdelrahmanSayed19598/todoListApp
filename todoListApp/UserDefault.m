//
//  UserDefault.m
//  todoListApp
//
//  Created by AbdElrahman sayed on 06/04/2022.
//

#import "UserDefault.h"

@implementation UserDefault
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray UserDefault:(NSUserDefaults*) userDefault
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [userDefault setObject:data forKey:keyName];
    [userDefault synchronize];
}

-(NSArray*)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName UserDefault:(NSUserDefaults*) userDefault
{
    NSData *data = [userDefault objectForKey:keyName];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return myArray;
}
@end
