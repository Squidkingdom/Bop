#import "Bop.h"
#define VUP_BUTTON 102
#define VDOWN_BUTTON 103
#define POWER_BUTTON 104
#define HOME_BUTTON 101

 static NSString *pauseMusicSequence = @"";
 static NSString *skipTrackSequence = @"";
 static NSString *toggleRepeatSequence = @"";
 static NSString *f15Sequence = @"";
 static NSString *b15Sequence = @"";
 static NSTimer *bopTimer;


 static void loadPrefs();


id sharedInstance;
static BOOL tweakEnabled = YES;
static BOOL isRunning = NO;

static void triggerButton(char button) {
	if (tweakEnabled && !isRunning) {
		isRunning = YES;
		if (!sharedInstance) sharedInstance = [[Bop alloc] init];
		[sharedInstance buttonPressed_LG:button];
		isRunning = NO;
	}
}


//iOS 13.4 and up
%hook SBFluidSwitcherGestureManager
- (void)grabberTongueBeganPulling:(id)arg1 withDistance:(double)arg2 andVelocity:(double)arg3 andGesture:(id)arg4  {
	//	NSLog(@"[BOP] 13.4");
  	triggerButton('H');
		%orig;
}
%end

//iOS 13.3 and below
%hook SBFluidSwitcherGestureManager
-(void)grabberTongueBeganPulling:(id)arg1 withDistance:(double)arg2 andVelocity:(double)arg3  {
		triggerButton('H');
		//	NSLog(@"[BOP] 13.3");
		%orig;
}
%end


%hook SpringBoard
-(void)_ringerChanged:(struct __IOHIDEvent *)arg1 {
	triggerButton('S');
	%orig;
}

-(_Bool)_handlePhysicalButtonEvent:(UIPressesEvent *)arg1 {
	// type = 101 -> Home button
	// type = 104 -> Power button
	// 102 and 103 are volume buttons

	// force = 0 -> button released
	// force = 1 -> button pressed

	int type2 = 0;
	int type = arg1.allPresses.allObjects[0].type;
	int force = arg1.allPresses.allObjects[0].force;
	if ([arg1.allPresses.allObjects count] >= 2){
		 type2 = arg1.allPresses.allObjects[1].type;
		 int force2 = arg1.allPresses.allObjects[1].force;
		 if ((type == VUP_BUTTON && type2 == VDOWN_BUTTON) || ((type == VDOWN_BUTTON) && (type2 == VUP_BUTTON))){
			 if (force == 1 && force2 == 1){
				// NSLog(@"[BOP] Volume");
				 triggerButton('V');
			}
			}
		 if (type+type2 == 207 && force+force2 == 2){
			 triggerButton('P');
		}
	}else {
		if (force == 1) {
		//	NSLog(@"[BOP] Single button %i", type);
				if (type == VDOWN_BUTTON)
					triggerButton('D');
				else if (type == VUP_BUTTON)
					triggerButton('U');
				else if (type == POWER_BUTTON)
					triggerButton('L');
				else if (type == HOME_BUTTON)
					triggerButton('H');
			}
	}
	return %orig;
}

%end


@implementation Bop
NSMutableString *sequence = [@"" mutableCopy];
NSTimeInterval lastPress;

+ (id)sharedInstance{
	return sharedInstance;
}

-(id)init {
	lastPress = 0.0;
	return self;
}



-(void)buttonPressed_LG:(char)button {

	NSTimeInterval now = [[NSDate date] timeIntervalSince1970] * 1000;
	if (now - lastPress > 650.0){
		[sequence setString:@""];
	} else {
		if(bopTimer)
			[bopTimer invalidate];
	}
	if (now - lastPress < 100.0)
		[sequence deleteCharactersInRange:NSMakeRange([sequence length]-1, 1)];
	lastPress = now;

	[sequence appendFormat:@"%c", button];
	NSLog(@"[BOP] Sequence:%@ Added:%c", sequence, button);
	bopTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
    target:self
    selector:@selector(interpSeq)
    userInfo:nil
    repeats:NO];
}
-(void)interpSeq {

	if([[sequence copy] isEqualToString: pauseMusicSequence])    {[self pauseMusic];}
	if([[sequence copy] isEqualToString: skipTrackSequence])     {[self skipTrack];}
	if([[sequence copy] isEqualToString: toggleRepeatSequence])  {[self repeatMusic];}
	if([[sequence copy] isEqualToString: f15Sequence])   			   {[self f15Music];}
	if([[sequence copy] isEqualToString: b15Sequence])  			   {[self b15Music];}
}

-(void)respring_LG:(BOOL)safeMode {
	[sequence setString:@""];
	pid_t pid;
	if (safeMode) {
		const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	} else {
		const char* args[] = {"killall", "backboardd", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	}
}
-(void)pauseMusic{
	MRMediaRemoteSendCommand(kMRTogglePlayPause, 0);
}
-(void)repeatMusic{
	MRMediaRemoteSendCommand(kMRToggleRepeat, 0);
}
-(void)skipTrack{
	MRMediaRemoteSendCommand(kMRNextTrack, 0);
}
-(void)f15Music{
	MRMediaRemoteSendCommand(kMRSkipFifteenSeconds, 0);
}
-(void)b15Music{
	MRMediaRemoteSendCommand(kMRGoBackFifteenSeconds, 0);
}
-(void)loadPrefs{
	loadPrefs();
}


@end



static void loadPrefs() {
    NSDictionary *prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.squidkingdom.boppreferences.defaults"];
		pauseMusicSequence = [[prefs objectForKey:@"pauseMusicSequence"] uppercaseString];
		skipTrackSequence = [[prefs objectForKey:@"skipTrackSequence"] uppercaseString];
}

%ctor {
loadPrefs();
}
