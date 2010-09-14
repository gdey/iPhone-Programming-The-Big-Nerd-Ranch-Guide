//
//  Line.h
//  TouchTracker
//
//  Created by Gautam Dey on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Line : NSObject {

    CGPoint begin;
    CGPoint end;
}

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;

@end
