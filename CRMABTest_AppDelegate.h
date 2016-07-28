//
//  CRMABTest_AppDelegate.h
//  CRMABTest
//
//  Created by Chris Larsen on 11-01-03.
//  Copyright home 2011 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AddressBook/AddressBook.h>
#include "Contact.h"
#include "ImportFromABController.h"

@interface CRMABTest_AppDelegate : NSObject 
{
    NSWindow *window;
    
	ImportFromABController *importController;
	NSArrayController *contactController;
	
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;
@property (readwrite, assign) IBOutlet NSArrayController *contactController;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

-(IBAction)loadAllContactsFromAB:(id)sender;
-(IBAction)loadContactsFromAB:(id)sender;
-(IBAction)clearList:(id)sender;
-(IBAction)showImportContactsPanel:(id)sender;

- (IBAction)saveAction:sender;

@end
