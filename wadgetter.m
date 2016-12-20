//
//  wadgetter.m
//  FreeTheWad GUI
//
//  Created by Ivan Mikhailov on 9/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "wadgetter.h"


@implementation wadgetter


- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication
					hasVisibleWindows:(BOOL)flag
{
	if( !flag )
		[mainwindow makeKeyAndOrderFront:nil];
	
	return YES;
}

-(void)freeWadArray:(NSArray *)arr
{
	for (int i=0;i<[arr count];i++)
	{
		if ([[[arr objectAtIndex:i] pathExtension] caseInsensitiveCompare:@"wad"] == NSOrderedSame )
		{
			freethewad = [[NSTask alloc] init];
			[freethewad setLaunchPath: [[NSBundle mainBundle] pathForResource:@"freethewad" ofType:@""]];
			[freethewad setArguments:[NSArray arrayWithObjects:[arr objectAtIndex:i],nil]];
			[freethewad launch];
		}
	}
	
	NSBeginAlertSheet(
					  @"For Freedom!",
					  // sheet message
					  @"OK",              // default button label
					  nil,                // no third button
					  nil,                // other button label
					  mainwindow,         // window sheet is attached to
					  self,               // we’ll be our own delegate
					  nil,
					  // did-end selector
					  NULL,               // no need for did-dismiss selector
					  (__bridge void *)(mainwindow),         // context info
					  @"WADs are free now.");
	
	
}

- (BOOL)application:(NSApplication *)sender openFiles:(NSArray *)path
{
	[self freeWadArray:path];
	return YES;
}


- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	
	NSArray *draggedFilenames = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
    
	
	if ([[[draggedFilenames objectAtIndex:0] pathExtension] caseInsensitiveCompare:@"wad"] == NSOrderedSame )
	{
		[self freeWadArray:draggedFilenames];
	}
	
	
	[status setTextColor:[NSColor colorWithCalibratedRed:(205.0/255.0) 
												   green:(205.0/255.0) 
													blue:(205.0/255.0) 
												   alpha:1]];
	
	return YES;
	
}


- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
	[self registerForDraggedTypes:[NSArray arrayWithObjects:NSTIFFPboardType, 
								   NSFilenamesPboardType, nil]];
    if (self) {
		
			
	}
    return self;
}


- (void)drawRect:(NSRect)bounds {
     bounds = [self bounds];
	
    NSBezierPath*    clipShape = [NSBezierPath bezierPath];
	[clipShape appendBezierPathWithRect:bounds];

	
	
    NSGradient* aGradient = [[NSGradient alloc]
							  initWithColorsAndLocations:[NSColor whiteColor], (CGFloat)0.0,
							  [NSColor colorWithCalibratedRed:224 green:224 blue:224 alpha:0], (CGFloat)1,
							  nil];
	
    [aGradient drawInBezierPath:clipShape angle:-90.0];
}


- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
		== NSDragOperationGeneric)
    {
   		
		NSArray *draggedFilenames = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
		if ([[[draggedFilenames objectAtIndex:0] pathExtension] isEqual:@"wad"]){
			[[NSCursor dragCopyCursor] set];
			[status setTextColor:[NSColor colorWithCalibratedRed:(115.0/255.0) 
													   green:(130.0/255.0) 
														blue:(150.0/255.0) 
													   alpha:1]];
		}
		else{
			[[NSCursor arrowCursor] set];
			[status setTextColor:[NSColor colorWithCalibratedRed:(205.0/255.0) 
														   green:(205.0/255.0) 
															blue:(205.0/255.0) 
														   alpha:1]];
			
		}
		
		
		return NSDragOperationGeneric;
    }
    else
    {
   
        return NSDragOperationNone;
    }
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
	[status setTextColor:[NSColor colorWithCalibratedRed:(205.0/255.0) 
												   green:(205.0/255.0) 
													blue:(205.0/255.0) 
												   alpha:1]];
	[[NSCursor dragCopyCursor] set];

}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
		== NSDragOperationGeneric)
    {

		[[NSCursor dragCopyCursor] set];

        return NSDragOperationGeneric;
    }
    else
    {

        return NSDragOperationNone;
    }
}


- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}


- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
    [self setNeedsDisplay:YES];
}

@end
