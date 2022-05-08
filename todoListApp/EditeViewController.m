//
//  EditeViewController.m
//  todoListApp
//
//  Created by AbdElrahman sayed on 05/04/2022.
//

#import "EditeViewController.h"
#import "UserDefault.h"
@interface EditeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *descTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *periority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *state;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateTF;
@property NSMutableArray * tasks;
@property NSUserDefaults * userDefaults;
@end

@implementation EditeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    _userDefaults = [NSUserDefaults standardUserDefaults];
    switch (_task.taskState) {
        case 0:
            _tasks  =[[self readArrayWithCustomObjFromUserDefaults:@"todo"] mutableCopy];
            break;
        case 1:
            _tasks  =[[self readArrayWithCustomObjFromUserDefaults:@"prog"] mutableCopy];
            break;
        case 2:
            _tasks  =[[self readArrayWithCustomObjFromUserDefaults:@"done"] mutableCopy];
            break;
        default:
            break;
    }
  
    
    if(_tasks == nil){
        _tasks = [NSMutableArray new];
    }

    // Do any additional setup after loading the view.
   
}

- (IBAction)edite:(id)sender {
    
    [self confirmEdite];
}

-(void) getData{
    _nameTF.text = _task.name;
    _dateTF.date = _task.date;
    _descTF.text = _task.taskDescription;
    _periority.selectedSegmentIndex = _task.taskPriority;
    _state.selectedSegmentIndex = _task.taskState;
    
}
-(void) setData{
    if(![self isOneOfTextFieldtNull]){
        _task.name = _nameTF.text ;
        _task.date = _dateTF.date ;
        _task.taskDescription = _descTF.text ;
        _task.taskPriority = _periority.selectedSegmentIndex ;
        _task.taskState = _state.selectedSegmentIndex;
       // [_tasks addObject:_task];
        
        switch (_task.taskState) {
            case 0:
                [_tasks addObject:_task];
                [self writeArrayWithCustomObjToUserDefaults:@"todo" withArray:_tasks];
                break;
            case 1:
                
                [_tasks addObject:_task];
                [self writeArrayWithCustomObjToUserDefaults:@"prog" withArray:_tasks];
                
                break;
            case 2:
                [_tasks addObject:_task];
                [self writeArrayWithCustomObjToUserDefaults:@"done" withArray:_tasks];
                
                break;
            default:
                break;
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self  errorAlert];
    }
   
    
}

-(BOOL) isOneOfTextFieldtNull{
    return  [_nameTF.text isEqualToString:@""] && [_descTF.text isEqualToString:@""];
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


-(void) confirmEdite{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Edite"
                                                                   message:@"Are you sure to edite task ?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"YES"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self->_tasks removeObjectAtIndex:self->_taskIndex];
        
        switch (self->_task.taskState) {
            case 0:
                [self writeArrayWithCustomObjToUserDefaults:@"todo" withArray:self->_tasks];
                break;
            case 1:
                [self writeArrayWithCustomObjToUserDefaults:@"prog" withArray:self->_tasks];
                break;
            case 2:
                [self writeArrayWithCustomObjToUserDefaults:@"done" withArray:self->_tasks];
                break;
            default:
                break;
        }
        
        [self setData];
       
    }];
    
    [alert addAction:firstAction];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
