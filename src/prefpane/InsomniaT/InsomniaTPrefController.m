	//
	//  InsomniaTPrefController.m
	//  InsomniaT
	//
	//  Created by Archimedes Trajano on 2010-06-09.
	//  Copyright 2010 trajano.net. All rights reserved.
	//

#import "InsomniaTPrefController.h"


@implementation InsomniaTPrefController

/**
 * Initializes the controller.  It should create an instance of the
 * model (ideally the model should be passed into here as a parameter
 * but I don't know the life cycle well enough yet to do that).
 *
 * It should also register itself as an observer to the model using the
 * KVO pattern.
 */
- (id) init {
	if ( self = [super init] ) {
			// By design automatic garbage collection is
			// not used.  Not necessarily for efficiency,
			// but for learning purposes.
		insomniaTstatus = [[InsomniaTStatus alloc]init];
		[insomniaTstatus addObserver: self
						  forKeyPath: @"insomniaTEnabled"
							 options:(NSKeyValueObservingOptionNew |
									  NSKeyValueObservingOptionOld)
							 context:NULL];
		[self updateStatus];
	}
	return self;
} 

- (void) dealloc {
	[insomniaTstatus removeObserver: self
						 forKeyPath: @"insomniaTEnabled"];
	[insomniaTstatus release];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"insomniaTEnabled"]) {
			//	bool insomniaTEnabled = [change objectForKey: NSKeyValueChangeNewKey];
		[self updateStatus];
		
    }
	
		// be sure to call the super implementation	
		// if the superclass implements it
	
    [super observeValueForKeyPath:keyPath
						 ofObject:object
						   change:change
						  context:context];
	
	
}
- (void) updateStatus {
	if ([[insomniaTstatus insomniaTEnabled] unsignedIntValue] == 0) {
		[statusLevel setIntValue: 1];
		[statusLevelText setTitleWithMnemonic: @"InsomniaT: On"];
		[statusLevelBlurb setTitleWithMnemonic: @"The MacBook will not suspend when the lid closed."];
		[startStopButton setTitle: @"Stop"];
		[startStopButtonBlurb setTitleWithMnemonic: @"Click Stop to turn InsominaT off"];
		[startStopButton setEnabled: true];
	} else {
		[statusLevel setIntValue: 0];
		[statusLevelText setTitleWithMnemonic: @"InsomniaT: Off"];
		[statusLevelBlurb setTitleWithMnemonic: @"The MacBook will suspend when the lid closed."];
		[startStopButton setTitle: @"Start"];
		[startStopButtonBlurb setTitleWithMnemonic: @"Click Start to turn InsominaT on"];
		[startStopButton setEnabled: true];
	}
}
- (IBAction)startStop:(id)sender {
	if ([[insomniaTstatus insomniaTEnabled] boolValue]) {
		[startStopButton setTitle: @"Stopping..."];
		[startStopButtonBlurb setTitleWithMnemonic: @"Please wait, trying to stop InsomniaT ..."];
		[startStopButton setEnabled: false];
		[insomniaTstatus disableInsomniaT];
	} else {
		[startStopButton setTitle: @"Starting..."];
		[startStopButtonBlurb setTitleWithMnemonic: @"Please wait, trying to start InsomniaT ..."];
		[startStopButton setEnabled: false];
		[insomniaTstatus enableInsomniaT];
	}
}
@end
