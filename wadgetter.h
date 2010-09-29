//
//  wadgetter.h
//  FreeTheWad GUI
//
//  Created by Ivan Mikhailov on 4/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface wadgetter : NSView {

	IBOutlet NSTextField *status;
	bool highlight;
    NSTask *freethewad;
	IBOutlet NSWindow *mainwindow;
		
}

-(void)freeWadArray:(NSArray *)arr;



@end
