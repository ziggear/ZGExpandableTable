//
//  ViewController.m
//  ExpandTableView
//
//  Created by ziggzhang on 2024/6/18.
//

#import "ViewController.h"
#import "ZGExpandableTableController.h"

@interface ViewController ()

@property (nonatomic, strong) ZGExpandableTableController *tableControler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *examplePath = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"json"];
    NSData *exampleJSON = [NSData dataWithContentsOfFile:examplePath];
    
    ZGExpandableTableController *tableControler = [[ZGExpandableTableController alloc] initWithTableViewFrame:self.view.bounds style:UITableViewStylePlain];
    UITableView *tableView = tableControler.tableView;
    [self.view addSubview:tableView];
    
    [tableControler loadJSON:exampleJSON];
    
    self.tableControler = tableControler;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}


@end
