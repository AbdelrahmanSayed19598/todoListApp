//
//  UserDefault.h
//  todoListApp
//
//  Created by AbdElrahman sayed on 06/04/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefault : NSObject
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray UserDefault:(NSUserDefaults*) userDefault;
-(NSArray*)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName UserDefault:(NSUserDefaults*) userDefault;

@end

NS_ASSUME_NONNULL_END
