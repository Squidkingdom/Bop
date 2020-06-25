#import <Foundation/Foundation.h>
#import <spawn.h>
#import "MediaRemote.h"


@interface Bop : NSObject{
}
+ (id)sharedInstance;
-(void)buttonPressed_LG:(char) button;
-(void)respring_LG:(BOOL)safeMode;
-(void)pauseMusic;
//-(void)repeatMusic;
-(void)skipTrack;
-(void)f15Music;
-(void)prevTrack;
-(void)b15Music;
-(void)loadPrefs;
@end
