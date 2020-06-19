#include "BOPRootListController.h"

@implementation BOPRootListController


- (void) viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = false;
        self.navigationController.navigationItem.largeTitleDisplayMode =
            UINavigationItemLargeTitleDisplayModeNever;
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = false;
        self.navigationController.navigationItem.largeTitleDisplayMode =
            UINavigationItemLargeTitleDisplayModeNever;
    }
}

- (instancetype) init {
    self = [super init];
/*
appearanceSettings.tableViewCellSeparatorColor = [UIColor clearColor];
appearanceSettings.navigationBarTintColor = THEME_COLOR;
appearanceSettings.navigationBarTitleColor = THEME_COLOR;
appearanceSettings.statusBarTintColor = [UIColor whiteColor];
appearanceSettings.tintColor = THEME_COLOR;
appearanceSettings.navigationBarBackgroundColor = NAVBG_COLOR;
*/
    if (self) {
        HBAppearanceSettings * appearanceSettings =
            [[HBAppearanceSettings alloc] init];
        appearanceSettings.tableViewCellSeparatorColor = [UIColor orangeColor];
        appearanceSettings.navigationBarTintColor = [UIColor blackColor];
        appearanceSettings.navigationBarTitleColor = [UIColor redColor];//THEME_COLOR
        appearanceSettings.statusBarTintColor = [UIColor greenColor];
        appearanceSettings.tintColor = [UIColor blueColor];
        appearanceSettings.navigationBarBackgroundColor = [UIColor purpleColor];
				appearanceSettings.largeTitleStyle = HBAppearanceSettingsLargeTitleStyleAlways;
        self.hb_appearanceSettings = appearanceSettings;
    }

    return self;
}


- (NSArray *) specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }

    return _specifiers;
}
- (void) respring {
  pid_t pid;
		const char* args[] = {"killall", "-9", "SpringBoard", NULL};
    [HBRespringController respringAndReturnTo:[NSURL URLWithString:@"prefs:root=Bop"]];

		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);

}




@end



@implementation LifeguardBigTextCell

//float cellHeight = 4000.0f;

- (id)initWithSpecifier:(PSSpecifier *)specifier {

	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
	if (self) {
		_label = [[UILabel alloc] initWithFrame:CGRectMake(16, 100, self.frame.size.width - 32, 4000)];
		[_label setLineBreakMode:NSLineBreakByWordWrapping];
		[_label setNumberOfLines:7];
		[_label setText:@"H - Home Button\nL - Lock Button\nU - Volume Up Button\nD - Volume Down Button\nS - Mute Switch\nP - Volume Down\nV - Both Vol. Buttons"];
		[_label sizeToFit];
		[self addSubview:_label];

		UILabel *_label2 = [[UILabel alloc] initWithFrame:CGRectMake(16, 100, self.frame.size.width - 32, 4000)];
		[_label2 setLineBreakMode:NSLineBreakByWordWrapping];
		[_label2 setNumberOfLines:7];
		[_label2 setText:@"Write a button sequence using the coresponding characters above.\n\nPatterns are not case sensitive. To disable a sequence, leave it blank."];
		[_label2 setFont:[UIFont systemFontOfSize:10]];
		[_label2 sizeToFit];
		[self addSubview:_label2];

	//	cellHeight = _label.frame.size.height + _label2.frame.size.height + 48;

	}
	return self;
}
@end
