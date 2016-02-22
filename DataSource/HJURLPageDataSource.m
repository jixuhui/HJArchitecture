//
//  HJURLPageDataSource.m
//  SinaNews
//
//  Created by jixuhui on 15/8/31.
//  Copyright (c) 2015年 sina. All rights reserved.
//

#import "HJURLPageDataSource.h"

@implementation HJURLPageDataSource
{
    Class _originalClass;
}

@synthesize pageIndex = _pageIndex;
@synthesize pageSize = _pageSize;
@synthesize firstPageIndex = _firstPageIndex;
@synthesize hasMoreData = _hasMoreData;
@synthesize pageIndexKey = _pageIndexKey;
@synthesize pageSizeKey = _pageSizeKey;
@synthesize otherParameters = _otherParameters;
@synthesize responseDataType = _responseDataType;

Class object_getClass(id object);

-(id) init{
    
    if((self = [super init])){
        
        self.pageSize = 10;
        self.firstPageIndex = 0;
        self.pageIndex = self.firstPageIndex;
        self.pageIndexKey = @"page";
        self.pageSizeKey = @"pagesize";
        
    }
    
    return self;
    
}

- (void)setDelegate:(id)delegate
{
    
    [super setDelegate:delegate];
    
    _originalClass = object_getClass(delegate);
    
}

-(void) reloadData{
    
    [super reloadData];
    
    self.pageIndex = self.firstPageIndex;
    
    [[HJURLService shareService] cancelTask:self];
    
    [self.otherParameters setValue:[NSString stringWithFormat:@"%d",self.pageIndex] forKey:self.pageIndexKey];
    
    [self.otherParameters setValue:[NSString stringWithFormat:@"%d",self.pageSize] forKey:self.pageSizeKey];
    
    [self handleTask];
    
}

-(void) loadMoreData{
    
    self.pageIndex ++;
    self.loading = YES;
    
    if([self.delegate respondsToSelector:@selector(HJDataSourceWillLoading:)]){
        [self.delegate HJDataSourceWillLoading:self];
    }
    
    [self.otherParameters setValue:[NSString stringWithFormat:@"%d",self.pageIndex] forKey:self.pageIndexKey];
    
    [self.otherParameters setValue:[NSString stringWithFormat:@"%d",self.pageSize] forKey:self.pageSizeKey];
    
    [self handleTask];
    
}

-(void) loadResultsData:(id)resultsData{
    
    NSUInteger c = [self count];
    
    [super loadResultsData:resultsData];
    
    self.hasMoreData = [self count] != c;
    
}

-(void)cancel
{
    
    [super cancel];
    
    [[HJURLService shareService] cancelTask:self];
    
}

- (void)handleTask
{
    [[HJURLService shareService] handleTask:self success:[self getSuccessBlock] failure:[self getFailBlock]];
}

- (id)getSuccessBlock
{
    return NULL;
}

- (id)getFailBlock
{
    return NULL;
}

- (void)handleSuccessWithResponse:(id)responseObject
{
    self.loading = NO;
    
    if(_pageIndex == self.firstPageIndex){
        [[self dataObjects] removeAllObjects];
    }
    
    [self loadResultsData:responseObject];
    
    Class currentClass = object_getClass(self.delegate);
    if (currentClass == _originalClass) {
        if(self.delegate&&[self.delegate respondsToSelector:@selector(HJDataSourceDidLoaded:)]){
            [self.delegate HJDataSourceDidLoaded:self];
        }
    }else{
        self.delegate = self;
    }
    
    self.loaded = YES;
}

- (void)handleFailureWithError:(NSError *)error
{
    self.loading = NO;
    if([self.delegate respondsToSelector:@selector(HJDataSource:didFitalError:)]){
        [self.delegate HJDataSource:self didFitalError:error];
    }
    if([[self dataObjects] count]){
        self.loaded = YES;
    }
}

@end
