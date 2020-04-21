//
//  AppDelegate.m
//  Encryption
//
//  Created by jianyi.chen on 2019/8/31.
//  Copyright © 2019 IN3. All rights reserved.
//

#import "AppDelegate.h"
#import "GetTimeDay.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [_txf_State setBackgroundColor:_window.backgroundColor];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}


- (IBAction)btn_OpenFile:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setDirectoryURL:[NSURL URLWithString:@"/Users/"]];
    [panel setPrompt: @"Open"];
    [panel beginSheetForDirectory: nil
                             file: nil
                            types: [NSArray arrayWithObject: @"zip"] // 文件类型
                   modalForWindow: _window
                    modalDelegate: self
                   didEndSelector: @selector(openPanelDidEnd:returnCode:contextInfo:)
                      contextInfo: nil];
}


- (void) openPanelDidEnd: (NSOpenPanel *)sheet
              returnCode: (int)returnCode
             contextInfo: (void *)context
{
    if (returnCode == NSModalResponseOK) {
        NSString *path = [sheet.URLs.firstObject path];
        _txf_Path.stringValue = path;
        NSLog(@"path:%@", self.txf_Path.stringValue );
    }
}


- (IBAction)btn_Encryption:(id)sender {
    
    NSArray *pathArray = [[NSArray alloc]init];
    if ([_txf_Path.stringValue containsString:@"/"]) {
        pathArray = [_txf_Path.stringValue componentsSeparatedByString:@"/"];
    }
    NSMutableString *mString = [[NSMutableString alloc]init];
    [mString appendString:@"cd "];
    for (int i=0; i<pathArray.count-1; i++) {
        [mString appendString:[NSString stringWithFormat:@"%@/",pathArray[i]]];
    }
    fileName = [NSString stringWithFormat:@"%@",[pathArray lastObject]];
    NSLog(@"%@",mString);
    pathString = [NSString stringWithFormat:@"%@",mString];
    
    if ([_txf_Name.stringValue isEqualToString:@""]) {
        _txf_Name.stringValue = fileName;
    }
    
    _txf_Name.stringValue = [NSString stringWithFormat:@"%@_%@",  _txf_Name.stringValue,
                             [GetTimeDay GetFileTime]];
    if ([[self cmd:[pathString stringByReplacingOccurrencesOfString:@"cd" withString:@"ls"]] containsString:[NSString stringWithFormat:@"%@.zip", _txf_Name.stringValue]]) {
        _txf_Name.stringValue = [NSString stringWithFormat:@"%@_2",_txf_Name.stringValue];
    }
    NSString *cmd = @"";
    if ([_txf_Password.stringValue isEqualToString:@""]) {
        cmd = [NSString stringWithFormat:@"%@;zip -r %@.zip %@",pathString,_txf_Name.stringValue,fileName];
    }else{
        cmd = [NSString stringWithFormat:@"%@;zip -r -P %@ %@.zip %@",pathString,_txf_Password.stringValue,_txf_Name.stringValue,fileName];
    }
    if ([[self cmd:cmd] containsString:@"adding"]) {
        [_txf_State setStringValue:@"PASS"];
        [_txf_State setBackgroundColor:[NSColor greenColor]];
        _txf_Name.stringValue = @"";
        _txf_Path.stringValue = @"";
        _txf_Password.stringValue = @"";
    }else {
        [_txf_State setStringValue:@"FIAL"];
        [_txf_State setBackgroundColor:[NSColor redColor]];
    }
}

- (NSString *)cmd:(NSString *)cmd
{
    // 初始化并设置shell路径
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    // [task setLaunchPath:@"/vault"];
    // -c 用来执行string-commands（命令字符串），也就说不管后面的字符串里是什么都会被当做shellcode来执行
    NSArray *arguments = [NSArray arrayWithObjects: @"-c", cmd, nil];
    [task setArguments: arguments];
    
    // 新建输出管道作为Task的输出
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    // 开始task
    NSFileHandle *file = [pipe fileHandleForReading];
    [task launch];
    
    // 获取运行结果
    NSData *data = [file readDataToEndOfFile];
    return [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
}

@end
