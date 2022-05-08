//
//  ProgressTableViewCell.h
//  todoListApp
//
//  Created by AbdElrahman sayed on 06/04/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *done;

@end

NS_ASSUME_NONNULL_END
