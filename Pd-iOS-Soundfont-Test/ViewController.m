//
//  ViewController.m
//  Pd-iOS-Soundfont-Test
//
//  Created by Chris Penny on 4/5/17.
//  Copyright © 2017 Point Motion. All rights reserved.
//

#import "ViewController.h"
#import "PdAudioController.h"
#import "PdDispatcher.h"
#import "PdExternals.h"

@interface ViewController ()

@end

@implementation ViewController


// This function makes it easy to send messages to the Pd Patch
//
//  The default PdBase function for it is a bit wonky. This lets you just send any
//  string like you would in Pd itself.
//
- (void)sendString:(NSString *)message toReceiver:(NSString *)receiver {
    
    NSMutableArray* finalMessage = [NSMutableArray new];
    NSArray* items = [message componentsSeparatedByString:@" "];
    
    for (int i = 0; i < [items count]; i++) {
        
        NSString* item = [items objectAtIndex:i];
        NSNumber* number = [NSNumber numberWithFloat:[item floatValue]];
        
        if ([[NSNumberFormatter new] numberFromString:[items objectAtIndex:i]] != nil) {
            [finalMessage addObject:number];
        }
        else {
            [finalMessage addObject:item];
        }
    }
    
    [PdBase sendList:finalMessage toReceiver:@"input"];
}

// !!!!!!!!!!!!!!! VERY IMPORTANT - SOUNDFONT NAMES CANNOT HAVE SPACES!!!!!!!!!!!!!!!


/*
    Adds our bundle to Pd's internal search path for patches (so it sees the patches in our bundle.
 
    Then registers the external patches (soundfonts is the only one for now)
 
    Then opens the main patch we're using (soundfont-controller.pd)
 
    Then sends a command to the patch to load a soundfont
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [PdBase addToSearchPath:[[NSBundle mainBundle] resourcePath]];
    [PdExternals setup];
    [PdBase openFile:@"soundfont-controller.pd" path:[[NSBundle mainBundle] resourcePath]];
    
    NSString* path = [[NSBundle mainBundle] resourcePath];
    NSString* soundfont = @"AwesomeGrandPiano.sf2";
    
    NSString* command = [NSString stringWithFormat:@"set %@/%@", path, soundfont];
    
    [self sendString:command toReceiver:@"input"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
    To play a note with the soundfonts patch, just send a note, velocity pair.
    Always send note-offs eventually - if you don't there will be a memory leak
 */

- (IBAction)noteOneOn:(id)sender {
    [self sendString:@"66 123" toReceiver:@"input"];
}
- (IBAction)noteOneOff:(id)sender {
    [self sendString:@"66 0" toReceiver:@"input"];
}

- (IBAction)noteTwoOn:(id)sender {
    [self sendString:@"40 90" toReceiver:@"input"];
}
- (IBAction)noteTwoOff:(id)sender {
    [self sendString:@"40 0" toReceiver:@"input"];
}

- (IBAction)noteThreeOn:(id)sender {
    [self sendString:@"80 100" toReceiver:@"input"];
}
- (IBAction)noteThreeOff:(id)sender {
    [self sendString:@"80 0" toReceiver:@"input"];
}

- (IBAction)noteFourOn:(id)sender {
    [self sendString:@"82 115" toReceiver:@"input"];
}
- (IBAction)noteFourOff:(id)sender {
    [self sendString:@"82 0" toReceiver:@"input"];
}


@end
