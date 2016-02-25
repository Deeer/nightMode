//
//  SingleDayAndNight.m
//  夜间模式Demo
//
//  Created by kylehe on 16/2/25.
//  Copyright © 2016年 Kyle He. All rights reserved.
//

#import "SingleDayAndNight.h"

@implementation SingleDayAndNight

+(SingleDayAndNight *)shareSingle
{
    static SingleDayAndNight *single = nil;
    @synchronized(self) {
        if (single  == nil) {
            single = [[SingleDayAndNight alloc] init];
        }
    }
    return single;
}

@end
