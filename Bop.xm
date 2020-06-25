#import "Bop.h"
static NSString *pauseMusicSequence = @"V";
static NSString *skipTrackSequence = @"VUD";
static NSString *f15Sequence = @"";
static NSString *b15Sequence = @"";
static NSString *prevTrackSequence = @"VDU";
static NSTimer *BopTimer;
static id sharedInstance;

@implementation Bop
NSMutableString *sequence = [@"" mutableCopy];
NSTimeInterval lastPress;

+ (id)sharedInstance{
	NSLog(@"[Bop] get sharedInstance");
	return sharedInstance;
}

-(id)init {
	NSLog(@"[Bop] init");
	lastPress = 0.0;
  sharedInstance = self;
	return self;
}



-(void)buttonPressed_LG:(char)button {
	NSLog(@"[Bop] Button pressed");
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970] * 1000;
	if (now - lastPress > 650.0){
		[sequence setString:@""];
	} else {
		if(BopTimer)
		NSLog(@"[Bop] Bop Timer");
			[BopTimer invalidate];
	}
	if (now - lastPress < 100.0)
		[sequence deleteCharactersInRange:NSMakeRange([sequence length]-1, 1)];
	lastPress = now;

	[sequence appendFormat:@"%c", button];
	NSLog(@"[Bop] Start Timer");
	BopTimer = [NSTimer scheduledTimerWithTimeInterval:0.65
    target:self
    selector:@selector(interpSeq)
    userInfo:nil
    repeats:NO];
}
-(void)interpSeq {
NSLog(@"[Bop] interpSeq");
	[self loadPrefs];
	if([[sequence copy] isEqualToString: pauseMusicSequence])    {[self pauseMusic];}
	if([[sequence copy] isEqualToString: skipTrackSequence])     {[self skipTrack];}
//if([[sequence copy] isEqualToString: toggleRepeatSequence])  {[self repeatMusic];}
	if([[sequence copy] isEqualToString: f15Sequence])   			   {[self f15Music];}
	if([[sequence copy] isEqualToString: b15Sequence])  			   {[self b15Music];}
	if([[sequence copy] isEqualToString: prevTrackSequence])     {[self prevTrack];}
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
	  NSLog(@"[Bop] %d TogglePause", (int)MRMediaRemoteSendCommand(kMRTogglePlayPause, 0));

}
 -(void)prevTrack{
	 MRMediaRemoteSendCommand(kMRPreviousTrack, 0);
  }
-(void)skipTrack{
	MRMediaRemoteSendCommand(kMRNextTrack, 0);

  NSLog(@"[Bop] skipTrack");
}
-(void)f15Music{
	MRMediaRemoteSendCommand(kMRSkipFifteenSeconds, 0);

  NSLog(@"[Bop] Hit f15");
}
-(void)b15Music{

  NSLog(@"[Bop] %d Hit b15", (int)MRMediaRemoteSendCommand(kMRGoBackFifteenSeconds, 0));
}

-(void)loadPrefs{
  NSLog(@"[Bop] loadPrefs");
  NSDictionary *prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.squidkingdom.boppreferences.defaults"];

  pauseMusicSequence = [[prefs objectForKey:@"pauseMusicSequence"] uppercaseString];
  skipTrackSequence = [[prefs objectForKey:@"skipTrackSequence"] uppercaseString];
  f15Sequence = [[prefs objectForKey:@"f15Sequence"] uppercaseString];
  b15Sequence = [[prefs objectForKey:@"b15Sequence"] uppercaseString];
	prevTrackSequence = [[prefs objectForKey:@"prevTrackSequence"] uppercaseString];
  NSLog(@"[Bop] Pause: %@\nSkip: %@\n Forward: %@\n Back: %@\n", [pauseMusicSequence copy], skipTrackSequence, f15Sequence, b15Sequence);
}
@end
