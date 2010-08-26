/*
 *  FileHelpers.m
 *  Homepwner
 *
 *  Created by bhardy on 7/30/09.
 *  Copyright 2009 Big Nerd Ranch. All rights reserved.
 *
 */

#include "FileHelpers.h"

NSString *pathInDocumentDirectory(NSString *fileName)
{
	// Get list of document directories in sandbox
	NSArray *documentDirectories = 
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	// Get one and only document directory from that list
	NSString *documentDirectory = [documentDirectories objectAtIndex:0];
	
	// Append passed in file name to that directory, return it
	return [documentDirectory stringByAppendingPathComponent:fileName];
}
