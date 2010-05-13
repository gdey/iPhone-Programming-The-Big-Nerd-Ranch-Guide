#import <Foundation/Foundation.h>

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];


    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:@"Zero", @"One", @"Two", @"Three", nil];
    
    for(NSString *item in items){
        
        NSLog(@"The item is %@",item);
    }
    
    [items release];
    [pool drain];
    return 0;
}
