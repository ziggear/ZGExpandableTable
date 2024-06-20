//
//  ZGExpandableTableController.m
//  ExpandTableView
//
//  Created by ziggear on 2024/6/18.
//

#import "ZGExpandableTableController.h"
#import "ZGJSONNode.h"
#import "ZGJSONNodeShowModel.h"

@interface ZGExpandableTableController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZGJSONNode *jsonRoot;

@property (nonatomic, strong) NSArray <ZGJSONNodeShowModel *> *showModels;

@end

@implementation ZGExpandableTableController

- (instancetype)initWithTableViewFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super init]) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView = tableView;
    }
    return self;
}

- (BOOL)loadJSON:(NSData *)jsonData {
    NSError *err = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        return NO;
    }
    
    ZGJSONNode *root = [self parse:object key:nil];
    self.jsonRoot = root;
    
    [self reloadData];
    
    return YES;
}

#pragma mark -

- (ZGJSONNode *)parse:(id)jsonObject key:(NSString *)key {
    ZGJSONNode *node = [[ZGJSONNode alloc] init];
    node.key = key;

    if (![jsonObject isKindOfClass:[NSDictionary class]] && ![jsonObject isKindOfClass:[NSArray class]]) {
        node.value = jsonObject;
    } else {
        NSMutableArray *children = [NSMutableArray array];
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            for (NSString *key in [(NSDictionary *)jsonObject allKeys]) {
                ZGJSONNode *subNode = [self parse:[(NSDictionary *)jsonObject objectForKey:key] key:key];
                [children addObject:subNode];
            }
        } else if ([jsonObject isKindOfClass:[NSArray class]]) {
            for (id subObject in (NSArray *)jsonObject) {
                ZGJSONNode *subNode = [self parse:subObject key:nil];
                [children addObject:subNode];
            }
        }
        node.children = [children copy];
    }
    
    return node;
}

#pragma mark - reloadData

- (void)reloadData {
    NSMutableArray *showModels = [NSMutableArray array];
    [self parseShowModelRoot:self.jsonRoot showModels:showModels level:0];
    self.showModels = [showModels copy];
    [self.tableView reloadData];
}

- (void)parseShowModelRoot:(ZGJSONNode *)root showModels:(NSMutableArray *)showModels level:(NSUInteger)level {
    for (ZGJSONNode *node in root.children) {
        ZGJSONNodeShowModel *model = [[ZGJSONNodeShowModel alloc] init];
        model.node = node;
        
        NSMutableString *showString = [NSMutableString string];
        
        // create some indent
        if (level > 0) {
            [showString appendString:@" "];
            [showString appendString:[@"" stringByPaddingToLength:level withString:@"  " startingAtIndex:0]];
            [showString appendString:@" "];
        }
        
        // expandable note
        if (node.children) {
            [showString appendString: node.expanded ? @"[-] " : @"[+] "];
        }
        
        if (node.key) {
            [showString appendFormat:@"%@ :", node.key];
        }
        
        if (node.children && node.expanded == NO) {
            [showString appendFormat:@"%@", @"[...]"];
        }
        
        if (node.value) {
            [showString appendFormat:@"%@", node.value];
        }
        
        model.text = [showString copy];
        [showModels addObject:model];

        if (node.expanded) {
            [self parseShowModelRoot:node showModels:showModels level:level + 1];
        }
    }
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [(ZGJSONNodeShowModel *)self.showModels[indexPath.row] text];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZGJSONNodeShowModel *showModel = self.showModels[indexPath.row];
    ZGJSONNode *node = showModel.node;
    if (node.children) {
        node.expanded = !node.expanded;
        [self reloadData];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
