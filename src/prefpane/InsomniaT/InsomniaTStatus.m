//
//  InsomniaTStatus.m
//  InsomniaT
//
//  Created by Archimedes Trajano on 2010-06-08.
//  Copyright 2010 trajano.net. All rights reserved.
//

#import "InsomniaTStatus.h"


@implementation InsomniaTStatus

- (bool) insomniaTEnabled {
		// By design this is replicated because we want to make sure we
		// always get the currently running driver rather than somethin
		// that may have been gone from a KExt restart or reinstall.
	io_service_t    service;
	service = IOServiceGetMatchingService(kIOMasterPortDefault,IOServiceMatching("net_trajano_driver_InsomniaT"));
	if (service == IO_OBJECT_NULL) {
        return false;
    }
	
	io_connect_t connect;
	kern_return_t kernResult = IOServiceOpen(service, mach_task_self(), 0, &connect);
	if (kernResult == KERN_SUCCESS) {
		
		uint64_t output[1];
		uint32_t count = 1;
		IOConnectCallScalarMethod(connect, 3, NULL, 0, output, &count);
		IOServiceClose(connect);
		return output[0] == 1;
	} else {
		return false;
	}
}

- (void) enableInsomniaT {
	io_service_t    service;
	service = IOServiceGetMatchingService(kIOMasterPortDefault,IOServiceMatching("net_trajano_driver_InsomniaT"));
	if (service == IO_OBJECT_NULL) {
        return;
    }
	
	io_connect_t connect;
	kern_return_t kernResult = IOServiceOpen(service, mach_task_self(), 0, &connect);
	if (kernResult == KERN_SUCCESS) {
		
		uint64_t output[1];
		uint32_t count = 1;
		IOConnectCallScalarMethod(connect, 1, NULL, 0, output, &count);
		IOServiceClose(connect);
			//		[controller updateStatus];
	} else {
		return;
	}
}
- (void) disableInsomniaT {
	io_service_t    service;
	service = IOServiceGetMatchingService(kIOMasterPortDefault,IOServiceMatching("net_trajano_driver_InsomniaT"));
	if (service == IO_OBJECT_NULL) {
        return;
    }
	
	io_connect_t connect;
	kern_return_t kernResult = IOServiceOpen(service, mach_task_self(), 0, &connect);
	if (kernResult == KERN_SUCCESS) {
		
		uint64_t output[1];
		uint32_t count = 1;
		IOConnectCallScalarMethod(connect, 2, NULL, 0, output, &count);
		IOServiceClose(connect);
	} else {
		return;
	}
}

- (void)setNilValueForKey:(NSString *)theKey {
	if ([theKey isEqualToString:@"hidden"]) {
        [self setValue:[NSNumber numberWithBool:YES] forKey:@"insomniaTEnabled"];
    } else {
        [super setNilValueForKey:theKey];
	}
}
@end