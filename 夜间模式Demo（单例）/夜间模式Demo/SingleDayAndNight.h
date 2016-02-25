//
//  SingleDayAndNight.h
//  夜间模式Demo
//
//  Created by kylehe on 16/2/25.
//  Copyright © 2016年 Kyle He. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleDayAndNight : NSObject
@property(nonatomic, assign) BOOL  isNightMode;

+(SingleDayAndNight *)shareSingle;

@end
