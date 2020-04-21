//
//  AppDelegate.h
//  Encryption
//
//  Created by jianyi.chen on 2019/8/31.
//  Copyright © 2019 IN3. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSString *fileName;
    NSString *pathString;
}

@property (weak) IBOutlet NSTextField *txf_Path;
@property (weak) IBOutlet NSTextField *txf_Name;
@property (weak) IBOutlet NSTextField *txf_Password;

- (IBAction)btn_OpenFile:(id)sender;
- (IBAction)btn_Encryption:(id)sender;

@property (weak) IBOutlet NSTextField *txf_State;

@end

