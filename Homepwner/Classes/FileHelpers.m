/*
 *  FileHelpers.c
 *  Homepwner
 *
 *  Created by Gautam Dey on 9/11/10.
 *  Copyright 2010 Gautam Dey. All rights reserved.
 *
 */

#include "FileHelpers.h"

NSString *pathInDocumentDirectory(NSString *filename)
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] 
            stringByAppendingPathComponent:filename];
}