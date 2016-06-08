//
//  DragonVideo+CoreDataProperties.h
//  DragonVideo
//
//  Created by dllo on 16/4/7.
//  Copyright © 2016年 MJ. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DragonVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DragonVideo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *dataId;
@property (nullable, nonatomic, retain) NSString *feed;
@property (nullable, nonatomic, retain) NSString *highUrl;
@property (nullable, nonatomic, retain) NSString *markUrl;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *playUrl;

@end

NS_ASSUME_NONNULL_END
