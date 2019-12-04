//
//  ThemeManager.m
//  TrackProject
//
//  Created by Денис Дубовиков on 02/12/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

#import "ThemeManager.h"
#import "TrackProject-Swift.h"

@interface ThemeManager()

@property (nonatomic, readwrite) NSString *readerName;
@property (nonatomic, readwrite) int value;

@end

@implementation ThemeManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self performSetup];
    }
    return self;
}

- (void)performSetup {
    NSLog(@"This is objc class");
    self.readerName = @"Reader name";
    self.value = 113;
    
    if (@available(iOS 13.0, *)) {
        self.isDarkModeAvailable = TRUE;
    } else {
        self.isDarkModeAvailable = FALSE;
    }
    
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.isDarkModeOn = YES;
        } else {
            self.isDarkModeOn = NO;
        }
    } else {
        self.isDarkModeOn = FALSE;
    }
    
    if (self.isDarkModeOn) {
        self.textColor = UIColor.whiteColor;
    } else {
        self.textColor = UIColor.blackColor;
    }
    
    if (self.isDarkModeOn) {
        self.buttonAccountImageName = @"Account_v4_darkMode";
    } else {
        self.buttonAccountImageName = @"Account_v4";
    }
    
    if (self.isDarkModeOn) {
        self.menuButtonImageName = @"Menu_darkMode";
    } else {
        self.menuButtonImageName = @"Menu";
    }
    
    if (self.isDarkModeOn) {
        self.cameraButtonImageName = @"Camera_v3_darkMode";
    } else {
        self.cameraButtonImageName = @"Camera_v3";
    }
    
    
    
    __auto_type manager = [[DDThemeManager alloc] init];
    [manager makeColors];
}

@end
