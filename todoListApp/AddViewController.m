//
//  AddViewController.m
//  todoListApp
//
//  Created by AbdElrahman sayed on 05/04/2022.
//

#import "AddViewController.h"
#import "Task.h"
@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *periority;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@property NSMutableArray * tasks;
@property Task * task;
@property NSUserDefaults * userDefaults;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userDefaults = [NSUserDefaults standardUserDefaults];
    
    _task = [Task new];
    
    NSArray *arr =[self readArrayWithCustomObjFromUserDefaults:@"todo"];
    _tasks = [arr mutableCopy];
    if(_tasks == nil){
        _tasks = [NSMutableArray new];
    }
    // Do any additional setup after loading the view.
}
- (IBAction)add:(id)sender {
    if(![self isOneOfTextFieldtNull]){
        _task =[self setData];
        [_tasks addObject:_task];
        
        [self writeArrayWithCustomObjToUserDefaults:@"todo" withArray:_tasks];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self errorAlert];
    }
   
}

-(Task*) setData{
    Task * task =[Task new];
    task.name = _nameTF.text;
    task.taskDescription = _descriptionTF.text;
    task.taskPriority = _periority.selectedSegmentIndex;
    task.date =_datePicker.date;
    task.taskState = 0;
    return task;
}

-(BOOL) isOneOfTextFieldtNull{
    return  [_nameTF.text isEqualToString:@""] && [_descriptionTF.text isEqualToString:@""];
}

-(void) errorAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"All Fields Are Required!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:firstAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [_userDefaults setObject:data forKey:keyName];
    [_userDefaults synchronize];
}

-(NSArray*)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName
{
    NSData *data = [_userDefaults objectForKey:keyName];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return myArray;
}

@end
