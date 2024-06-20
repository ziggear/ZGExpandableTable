//
//  ZGJSONNodeShowModel.h
//  ExpandTableView
//
//  Created by ziggear on 2024/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZGJSONNode;

@interface ZGJSONNodeShowModel : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, weak) ZGJSONNode *node;

@end

NS_ASSUME_NONNULL_END
