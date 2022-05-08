//
//  ViewController.m
//  todoListApp
//
//  Created by AbdElrahman sayed on 05/04/2022.
//

#import "ViewController.h"
#import "Task.h"
#import "AddViewController.h"
#import "EditeViewController.h"
@interface ViewController ()
@property NSUserDefaults * userDefault;
@property NSMutableArray * tasks;
@property Task * task;
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property AddViewController * addScreen;
@property EditeViewController *editeScreen;


@end

@implementation ViewController
{
    BOOL isFiltered;
    NSMutableArray *arrsearchresult ;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _userDefault = [NSUserDefaults standardUserDefaults];
    
    _tasks =[[self readArrayWithCustomObjFromUserDefaults:@"todo"] mutableCopy];
    
    [_myTable reloadData];
}
- (void)viewDidLoad {
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _tasks = [NSMutableArray new];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(isFiltered)
    {
        cell.textLabel.text = [[arrsearchresult objectAtIndex:indexPath.row] name];
        cell.imageView.image = [UIImage imageNamed:@([[_tasks objectAtIndex:indexPath.row] taskPriority]).stringValue];
        
    }else{
        cell.textLabel.text = [[_tasks objectAtIndex:indexPath.row] name];
        cell.detailTextLabel.text =[[_tasks objectAtIndex:indexPath.row] taskDescription];
        cell.imageView.image = [UIImage imageNamed:@([[_tasks objectAtIndex:indexPath.row] taskPriority]).stringValue];
    }
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isFiltered){
        return [arrsearchresult count];
    }
    return  _tasks.count;
}

- (IBAction)addScreen:(id)sender {
    _addScreen= [self.storyboard instantiateViewControllerWithIdentifier:@"add"];
    [self.navigationController pushViewController:_addScreen animated:YES];
}


-(NSArray*)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName
{
    NSData *data = [_userDefault objectForKey:keyName];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return myArray;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _editeScreen= [self.storyboard instantiateViewControllerWithIdentifier:@"edite"];
    _editeScreen.task = [_tasks objectAtIndex:indexPath.row];
    _editeScreen.taskIndex = (int)indexPath.row;
    [self.navigationController pushViewController:_editeScreen animated:YES];
}
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [_userDefault setObject:data forKey:keyName];
    [_userDefault synchronize];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tasks removeObjectAtIndex:indexPath.row];
    [self writeArrayWithCustomObjToUserDefaults:@"todo" withArray:_tasks];
    [_myTable reloadData];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    isFiltered =YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0)
    {
        isFiltered=NO;
    }
    
    else
    {
        isFiltered=YES;
        arrsearchresult=[[NSMutableArray alloc]init];
        
        for ( int i=0 ; i<_tasks.count;i++ )
        {
            NSString *str = [[_tasks objectAtIndex:i] name];
            NSRange stringRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            NSInteger index;
            if(stringRange.location != NSNotFound)
            {
                [arrsearchresult addObject:[_tasks objectAtIndex:i]];
            }
        }
    }
    [_myTable reloadData];
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_myTable resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    isFiltered=NO;
    [_myTable reloadData];}
@end
