#import <Foundation/Foundation.h>
#import <spawn.h>
#import <MediaRemote.h>


@interface Bop: NSObject
-(id)init;
-(void)buttonPressed_LG:(char) button;
-(void)respring_LG:(BOOL)safeMode;
@end
