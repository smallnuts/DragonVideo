//
//  DragonEverydayEat+CoreDataProperties.h
//  DragonVideo
//
//  Created by MJ on 16/4/8.
//  Copyright © 2016年 MJ. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DragonEverydayEat.h"

NS_ASSUME_NONNULL_BEGIN

@interface DragonEverydayEat (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *course_image;
@property (nullable, nonatomic, retain) NSString *course_name;
@property (nullable, nonatomic, retain) NSString *course_subject;
@property (nullable, nonatomic, retain) NSString *course_video;
@property (nullable, nonatomic, retain) NSNumber *video_watchcount;

@end

NS_ASSUME_NONNULL_END
