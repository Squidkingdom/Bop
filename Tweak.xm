#import "Bop.h"
#define VUP_BUTTON 102
#define VDOWN_BUTTON 103
#define POWER_BUTTON 104
#define HOME_BUTTON 101
bool inited = false;

%group tweakStuff
id sharedInstance;
bool isRunning = NO;
static void triggerButton(char button) {
  NSLog(@"[Bop] triggerButton");
  if(!isRunning){
    isRunning = YES;
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
				else if (type == VUP_BUTTON){
          NSLog(@"[Bop] %i", force);
  					triggerButton('U');
        }
				else if (type == POWER_BUTTON)
					triggerButton('L');
				else if (type == HOME_BUTTON)
					triggerButton('H');
			}
	}
	return %orig;
}

%end



%end



%ctor {
  NSLog(@"[Bop] Ctor");
  if(!inited)
  %init(tweakStuff);
  inited = true;
  sharedInstance = [[Bop alloc] init];
  [sharedInstance loadPrefs];
}
