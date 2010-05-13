#import <Foundation/Foundation.h>
#import "Possession.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];


    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 0; i < 10; i++){
        [items addObject:[Possession randomPossession]];
    }
    
    for(Possession *item in items){
        
        NSLog(@"The item is %@",item);
    }
    
    [items release];
    items = nil;
    [pool drain];
    return 0;
}
