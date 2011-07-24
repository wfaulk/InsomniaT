//
//  InsomniaTPref.m
//  InsomniaT
//
//  Created by Archimedes Trajano on 2010-06-07.
//  Copyright (c) 2010 trajano.net. All rights reserved.
//

#import "InsomniaTPref.h"


@implementation InsomniaTPref

- (void) willSelect {
	service = IOServiceGetMatchingService(kIOMasterPortDefault,IOServiceMatching("net_trajano_driver_InsomniaT"));
	if (service == IO_OBJECT_NULL) {
        [statusLevel setIntValue: 2];
        [statusLevelText setTitleWithMnemonic: @"InsomniaT: Unknown"];
        [statusLevelBlurb setTitleWithMnemonic: @"InsomniaT kernel module is not installed"];
        [startStopButton setTitle: @"Start"];
        [startStopButtonBlurb setTitleWithMnemonic: @"Unable to start as InsomniaT kernel extension is not installed."];
        [startStopButton setEnabled: false];
		[uninstallButtonBlurb setTitleWithMnemonic: @"InsomniaT is already uninstalled, please remove the preference pane"];
		return;
	}
	
	kern_return_t kernResult = IOServiceOpen(service, mach_task_self(), 0, &connect);
	if (kernResult == KERN_SUCCESS) {
		
		uint64_t output[1];
		uint32_t count = 1;
		IOConnectCallScalarMethod(connect, 3, NULL, 0, output, &count);
		IOServiceClose(connect);

		if (output[0] == 0) {
			[statusLevel setIntValue: 1];
			[statusLevelText setTitleWithMnemonic: @"InsomniaT: On"];
			[statusLevelBlurb setTitleWithMnemonic: @"The MacBook will not suspend when the lid closed."];
			[startStopButton setTitle: @"Stop"];
			[startStopButtonBlurb setTitleWithMnemonic: @"Click Stop to turn InsominaT off"];
			[startStopButton setEnabled: true];
        } else if (output[0] == 1) {
            [statusLevel setIntValue: 0];
            [statusLevelText setTitleWithMnemonic: @"InsomniaT: Off"];
            [statusLevelBlurb setTitleWithMnemonic: @"The MacBook will suspend when the lid closed."];
            [startStopButton setTitle: @"Start"];
            [startStopButtonBlurb setTitleWithMnemonic: @"Click Start to turn InsominaT on"];
            [startStopButton setEnabled: true];
        } else {
            [statusLevel setIntValue: 2];
            [statusLevelText setTitleWithMnemonic: @"InsomniaT: Unknown"];
            [statusLevelBlurb setTitleWithMnemonic: @"InsomniaT kernel module is not installed"];
            [startStopButton setTitle: @"Start"];
            [startStopButtonBlurb setTitleWithMnemonic: @"Unable to start as InsomniaT kernel extension is not installed."];
            [startStopButton setEnabled: false];
            [uninstallButtonBlurb setTitleWithMnemonic: @"InsomniaT is already uninstalled, please remove the preference pane"];
        }
		
	} else {
        [statusLevel setIntValue: 2];
        [statusLevelText setTitleWithMnemonic: @"InsomniaT: Unknown"];
        [statusLevelBlurb setTitleWithMnemonic: @"InsomniaT kernel module is not installed"];
        [startStopButton setTitle: @"Start"];
        [startStopButtonBlurb setTitleWithMnemonic: @"Unable to start as InsomniaT kernel extension is not installed."];
        [startStopButton setEnabled: false];
		[uninstallButtonBlurb setTitleWithMnemonic: @"InsomniaT is already uninstalled, please remove the preference pane"];
		return;
	}
	
}

- (void) didUnselect {
}

@end
