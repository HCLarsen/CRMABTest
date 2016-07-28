//
//  ImportFromABController.h
//  CRMABTest
//
//  Created by Chris Larsen on 10-09-04.
//  Copyright 2010 home. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AddressBook/ABPeoplePickerView.h>
#import <AddressBook/AddressBook.h>

extern NSString * const CLImportFromABNotification;

@interface ImportFromABController : NSWindowController {
	NSRect oldFrame;
	
	IBOutlet NSWindow *window;
	
	IBOutlet ABPeoplePickerView *ppView;
	IBOutlet NSMatrix *selection;
	
	//NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	
}

@property (nonatomic, assign, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;

-(IBAction)changeSelection:(id)sender;
-(IBAction)accept:(id)sender;

-(id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator;
-(void)saveAction;
@end
