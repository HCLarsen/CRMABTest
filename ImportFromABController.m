//
//  ImportFromABController.m
//  CRMABTest
//
//  Created by Chris Larsen on 10-09-04.
//  Copyright 2010 home. All rights reserved.
//

#import "ImportFromABController.h"
#import "Contact.h"

NSString * const CLImportFromABNotification = @"Import from AddressBook";

@implementation ImportFromABController

@synthesize managedObjectContext;

-(id)init
{
	if (![super initWithWindowNibName:@"ImportFromAB"]) {
		return nil;
	}
	
	return self;
}

-(id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator
{
	if (![super initWithWindowNibName:@"ImportFromAB"]) 
		return nil;
	
	// Instead of using the same managed object context, it creates its own using the same
	// persistent store as the main program
	
	self.managedObjectContext = [[NSManagedObjectContext alloc] init];
	[[self managedObjectContext] setPersistentStoreCoordinator:coordinator];
	NSLog(@"Panel's coordinator: %@", [[self managedObjectContext] persistentStoreCoordinator]);
	
	return self;
}

-(void)dealloc
{
    [window release];
	[ppView release];
	[selection release];
	
    [managedObjectContext release];
    //[persistentStoreCoordinator release];
    [managedObjectModel release];
	
    [super dealloc];	
}

-(void)awakeFromNib
{
	[ppView addProperty:kABOrganizationProperty];
}

-(void)saveAction
{
    NSError *error = nil;
	
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%s unable to commit editing before saving", [self class], _cmd);
    }
	
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }	
}

-(IBAction)changeSelection:(id)sender
{
	NSRect windowFrame = [[self window] frame];

	if ([sender selectedTag]==1) {
		// User has selected All Contacts
		oldFrame = windowFrame;

		float heightChange = [ppView frame].size.height - [selection frame].size.height;
		float widthChange = windowFrame.size.width - 400;
		
		windowFrame.size.height -= heightChange;
		windowFrame.origin.y += heightChange;
		windowFrame.size.width -= widthChange;
		
		[ppView setHidden:YES];
		[[self window] setShowsResizeIndicator:NO];
	} else if ([sender selectedTag]==0 & [ppView isHidden] == YES) {
		// User has selected "Select Contacts"

		windowFrame = oldFrame;
		[ppView setHidden:NO];
		[[self window] setShowsResizeIndicator:YES];
	}
	[[self window] setFrame:windowFrame display:YES animate:YES];
}

-(IBAction)accept:(id)sender
{
	[self managedObjectContext];
	NSArray *array = [[NSArray alloc] init];
	
	if ([selection selectedTag]==1) {
		ABAddressBook *addressBook = [ABAddressBook sharedAddressBook];	
		array = [[NSArray alloc] initWithArray:[addressBook people]];
	} else if ([selection selectedTag]==0) {
		array = [ppView selectedRecords];
	}
	for (ABPerson *person in array){
		Contact *aContact = [[Contact alloc] initFromABPerson:person intoManagedObjectContext:managedObjectContext];
		// I could change the above line to nil for the moc, and then add the duplicate
		// checker here, with the result of inserting the new contact if the duplicate
		// checker returns a NO result.
		[aContact release];
	}
	
	[self saveAction];
	[[self window] performClose:self];
}

#pragma mark Core Data Accessors

/**
 Creates, retains, and returns the managed object model for the application 
 by merging all of the models found in the application bundle.
 */

- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel) return managedObjectModel;
	
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}

@end
