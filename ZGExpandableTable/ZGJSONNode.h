//
//  ZGJSONNode.h
//  ExpandTableView
//
//  Created by ziggear on 2024/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGJSONNode : NSObject

// empty for an array
@property (nonatomic, copy) NSString *key;

// may be string number and bool
@property (nonatomic, strong) id value;

// sub nodes
@property (nonatomic, strong) NSMutableArray <ZGJSONNode *>* children;

// expanded flag
@property (nonatomic, assign) BOOL expanded;

@end

NS_ASSUME_NONNULL_END
