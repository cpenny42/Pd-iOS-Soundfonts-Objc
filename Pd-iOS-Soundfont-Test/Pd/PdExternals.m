//
//  pdExternals.m
//  NoteLet
//
//  Created by Chris Penny on 3/4/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PdExternals.h"

extern void soundfonts_setup(void);

@interface PdExternals ()

@end

@implementation PdExternals : NSObject


+(void)setup {
    
    soundfonts_setup();
}


@end
