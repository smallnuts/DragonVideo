//
//  CoreDataManager.h
//  数据持久化 CoreData
//
//  Created by dllo on 16/3/30.
//  Copyright © 2016年 wyl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+ (instancetype)shareCoreDataManager;

// 数据管理器类
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
// 数据模型器类
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
// 数据连接器类
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// 保存数据
- (void)saveContext;

// 沙盒路径
- (NSURL *)applicationDocumentsDirectory;



@end
