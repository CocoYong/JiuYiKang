//
//  MessageCenterModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/6.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageCenterModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *offset;
@property(nonatomic,copy)NSString *per_page;
@property(nonatomic,copy)NSString *msg_count;
@property(nonatomic,strong)NSArray *messageListArray;
@end


@interface MessageListModel : NSObject
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *messageID;
@property(nonatomic,copy)NSString *msg_content;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *update_time;
@end
