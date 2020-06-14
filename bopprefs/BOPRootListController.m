#include "BOPRootListController.h"

@implementation BOPRootListController
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)returnPrefs:(id)sender{
	NSLog(@"[BOP] damn");
	NSString *pauseMusicSequence = @"V";
	NSDictionary *prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.squidkingdom.bop.defaults"];
	pauseMusicSequence = [[prefs objectForKey:@"pauseMusicSequence"] uppercaseString];
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
	                               message:pauseMusicSequence
	                               preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
	   handler:^(UIAlertAction * action) {}];

	[alert addAction:defaultAction];
	[self presentViewController:alert animated:YES completion:nil];
}

@end
