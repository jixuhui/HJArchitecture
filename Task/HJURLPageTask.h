//
//  HJURLPageTask.h
//  HJArchitecture
//
//  Created by jixuhui on 15/8/24.
//  Copyright (c) 2015年 private. All rights reserved.
//

#import "HJURLTask.h"

@protocol IHJURLPageTask <IHJURLTask>
@property(nonatomic,assign) int pageIndex;
@property(nonatomic,assign) int pageSize;
@property(nonatomic,assign) int firstPageIndex;
@property(nonatomic,assign) BOOL hasMoreData;
@property(nonatomic,strong) NSString *pageIndexKey;
@property(nonatomic,strong) NSString *pageSizeKey;
@end

@interface HJURLPageTask : HJURLTask <IHJURLPageTask>

@end
