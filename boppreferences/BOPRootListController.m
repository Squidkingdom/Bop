#include "BOPRootListController.h"

@implementation BOPRootListController


- (void) viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = false;
        self.navigationController.navigationItem.largeTitleDisplayMode =
            UINavigationItemLargeTitleDisplayModeNever;
            [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Apply"
                                                                                      style:UIBarButtonItemStylePlain
                                                                                     target:self
                                                                                     action:@selector(respring)]];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = false;
        self.navigationController.navigationItem.largeTitleDisplayMode =
            UINavigationItemLargeTitleDisplayModeNever;

        [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Apply"
                                                                                      style:UIBarButtonItemStylePlain
                                                                                     target:self
                                                                                     action:@selector(respring)]];
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
        appearanceSettings.tableViewCellSeparatorColor = [UIColor OUTLINE];
        if(@available(iOS 13, *)){
          appearanceSettings.navigationBarTintColor = [UIColor labelColor];

        }else{
          appearanceSettings.navigationBarTintColor = [UIColor blackColor];

        }
        appearanceSettings.navigationBarTitleColor = [UIColor clearColor];
        appearanceSettings.statusBarTintColor = [UIColor clearColor];
        appearanceSettings.tintColor = [UIColor colorWithRed:0.373 green:0.753 blue:0.914 alpha:1];
        appearanceSettings.navigationBarBackgroundColor = [UIColor colorWithRed:0.37 green:0.89 blue:0.87 alpha:1];
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

[[Bop sharedInstance] loadPrefs];
  // pid_t pid;
	// 	const char* args[] = {"killall", "-9", "SpringBoard", NULL};
  //   [HBRespringController respringAndReturnTo:[NSURL URLWithString:@"prefs:root=Bop"]];
  //
	// 	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);

}




@end



@implementation LifeguardBigTextCell

//float cellHeight = 4000.0f;

 - (UIColor *)coverUp {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traits) {
            return traits.userInterfaceStyle == UIUserInterfaceStyleDark ?
                [UIColor systemBackgroundColor] :
                [UIColor systemGray6Color];
        }];
    } else {
        return [UIColor TABLE_BG];
    }
}

- (id)initWithSpecifier:(PSSpecifier *)specifier {

	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
	if (self) {
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 14, 420, 245)];
    [background setBackgroundColor:[self coverUp]];
    background.alpha = 1;
    [self addSubview:background];
		_label = [[UILabel alloc] initWithFrame:CGRectMake(16, 25, self.frame.size.width - 32, 100)];
		[_label setLineBreakMode:NSLineBreakByWordWrapping];
		[_label setNumberOfLines:7];
		[_label setText:@"H - Home Button\nL - Lock Button\nU - Volume Up Button\nD - Volume Down Button\nS - Mute Switch\nP - Volume Down\nV - Both Vol. Buttons"];
		[_label sizeToFit];
		[self addSubview:_label];

		UILabel *_label2 = [[UILabel alloc] initWithFrame:CGRectMake(16, 182, self.frame.size.width - 32, 50)];
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
