//
//  ZGExpandableTableController.h
//  ExpandTableView
//
//  Created by ziggear on 2024/6/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGExpandableTableController : NSObject

/// the tableview, added to your view or view controller
@property (nonatomic, strong) UITableView *tableView;

/**
 create a controller with tableview style
 */
- (instancetype)initWithTableViewFrame:(CGRect)frame style:(UITableViewStyle)style;

/**
 load JSON to tableview
 */
- (BOOL)loadJSON:(NSData *)jsonData;

@end

NS_ASSUME_NONNULL_END
