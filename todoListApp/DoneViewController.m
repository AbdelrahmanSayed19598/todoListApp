//
//  DoneViewController.m
//  todoListApp
//
//  Created by AbdElrahman sayed on 05/04/2022.
//

#import "DoneViewController.h"
#import "Task.h"
#import "UserDefault.h"
#import "EditeViewController.h"
@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *doneTable;

@property NSUserDefaults * nsUserDefault;
@property NSMutableArray * tasks;
@property Task * task;
@property UserDefault * userDefault;
@property EditeViewController *editeScreen;
@property NSMutableArray *high;
@property NSMutableArray *meduim;
@property NSMutableArray *low;
@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _low = [NSMutableArray new];
    _meduim = [NSMutableArray new];
    _high = [NSMutableArray new];
    _userDefault = [UserDefault new];
    _nsUserDefault = [NSUserDefaults standardUserDefaults];
    _doneTable.delegate = self;
    _doneTable.dataSource = self;
    _tasks = [NSMutableArray new];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [_meduim removeAllObjects];
    [_low removeAllObjects];
    [_high removeAllObjects];
    _tasks =[[_userDefault readArrayWithCustomObjFromUserDefaults:@"done" UserDefault:_nsUserDefault] mutableCopy];
    for(int i=0 ;i<_tasks.count;i++){
        if([[_tasks objectAtIndex:i] taskPriority] == 0){
            [_low addObject:[_tasks objectAtIndex:i]];
        }else if([[_tasks objectAtIndex:i] taskPriority] == 1){
            [_meduim addObject:[_tasks objectAtIndex:i]];
        }else if([[_tasks objectAtIndex:i] taskPriority] == 2){
            [_high addObject:[_tasks objectAtIndex:i]];
        }
    }
    [_doneTable reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch ([[_tasks objectAtIndex:indexPath.row] taskPriority]) {
        case 0:
            cell.textLabel.text = [[_low objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text =[[_low objectAtIndex:indexPath.row] taskDescription];
            cell.imageView.image = [UIImage imageNamed:@([[_low objectAtIndex:indexPath.row] taskPriority]).stringValue];
            break;
        case 1:
            cell.textLabel.text = [[_meduim objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text =[[_meduim objectAtIndex:indexPath.row] taskDescription];
            cell.imageView.image = [UIImage imageNamed:@([[_meduim objectAtIndex:indexPath.row] taskPriority]).stringValue];
            break;
        case 2:
            cell.textLabel.text = [[_high objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text =[[_high objectAtIndex:indexPath.row] taskDescription];
            cell.imageView.image = [UIImage imageNamed:@([[_high objectAtIndex:indexPath.row] taskPriority]).stringValue];
            break;
            
        default:
            break;
    }

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return _low.count;
            break;
        case 1:
            return _meduim.count;
            break;
        case 2:
            return _high.count;
            break;
        default:
            return 0;
            break;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tasks removeObjectAtIndex:indexPath.row];
    [_userDefault writeArrayWithCustomObjToUserDefaults:@"done" withArray:_tasks UserDefault:_nsUserDefault];
    [_doneTable reloadData];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _editeScreen= [self.storyboard instantiateViewControllerWithIdentifier:@"edite"];
    _editeScreen.task = [_tasks objectAtIndex:indexPath.row];
    _editeScreen.taskIndex = (int)indexPath.row;
    [self.navigationController pushViewController:_editeScreen animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *tit = @"";
    switch (section) {
        case 0:
            tit= @"low";
            break;
        case 1:
            tit= @"meduim";
            break;
        case 2:
            tit= @"high";
            break;
        default:
            
            break;
    }
    return  tit;
}
@end
