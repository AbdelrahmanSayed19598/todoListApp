//
//  InProgressViewController.m
//  todoListApp
//
//  Created by AbdElrahman sayed on 05/04/2022.
//

#import "InProgressViewController.h"
#import "Task.h"
#import "UserDefault.h"
#import "ProgressTableViewCell.h"
#import "EditeViewController.h"
@interface InProgressViewController ()
@property (weak, nonatomic) IBOutlet UITableView *progresTbale;
@property UserDefault * userDefault;

@property NSUserDefaults * nsUserDefault;
@property NSMutableArray * tasks;
@property Task * task;
@property EditeViewController *editeScreen;
@end

@implementation InProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nsUserDefault = [NSUserDefaults standardUserDefaults];
    _progresTbale.delegate = self;
    _progresTbale.dataSource = self;
    _tasks = [NSMutableArray new];
    _userDefault = [UserDefault new];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
    
    _tasks =[[_userDefault readArrayWithCustomObjFromUserDefaults:@"prog" UserDefault:_nsUserDefault] mutableCopy];
    
    
    [_progresTbale reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.name.text = [[_tasks objectAtIndex:indexPath.row] name];
    cell.desc.text =[[_tasks objectAtIndex:indexPath.row] taskDescription];
    cell.image.image = [UIImage imageNamed:@([[_tasks objectAtIndex:indexPath.row] taskPriority]).stringValue];
    cell.done.tag = indexPath.row;
    [cell.done addTarget:self action:@selector(makeDone:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void) makeDone:(id)sender{
    
    
    
    NSMutableArray * doneTasks =[[_userDefault readArrayWithCustomObjFromUserDefaults:@"done" UserDefault:_nsUserDefault] mutableCopy];
    [doneTasks addObject:[_tasks objectAtIndex:[sender tag]]];
    [_userDefault writeArrayWithCustomObjToUserDefaults:@"done" withArray:doneTasks UserDefault:_nsUserDefault] ;
    
    [_tasks removeObjectAtIndex:[sender tag]] ;
    [_userDefault writeArrayWithCustomObjToUserDefaults:@"prog" withArray:_tasks UserDefault:_nsUserDefault] ;
    [_progresTbale reloadData];
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _tasks.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tasks removeObjectAtIndex:indexPath.row];
    [_userDefault writeArrayWithCustomObjToUserDefaults:@"prog" withArray:_tasks UserDefault:_nsUserDefault] ;
    [_progresTbale reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _editeScreen= [self.storyboard instantiateViewControllerWithIdentifier:@"edite"];
    _editeScreen.task = [_tasks objectAtIndex:indexPath.row];
    _editeScreen.taskIndex = (int)indexPath.row;
    [self.navigationController pushViewController:_editeScreen animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
@end
