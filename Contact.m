// 
//  Contact.m
//  CRMABTest
//
//  Created by Chris Larsen on 11-02-21.
//  Copyright 2011 home. All rights reserved.
//

#import "Contact.h"
//#import "NSManagedObject.h"

@implementation Contact 

@dynamic phoneNumber;
@dynamic lastName;
@dynamic address1;
@dynamic suffix;
@dynamic address2;
@dynamic province;
@dynamic company;
@dynamic city;
@dynamic postalCode;
@dynamic salutation;
@dynamic email;
@dynamic country;
@dynamic name;
@dynamic activities;

-(id)initFromABPerson:(ABPerson *)person intoManagedObjectContext:(NSManagedObjectContext *)moc
{
	ABMutableMultiValue *multiValue;
	
	// Loads managed object model and inserts the Contact into the managed object context
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
	NSEntityDescription *contactEntity = [[managedObjectModel entitiesByName] objectForKey:@"Contact"];
	self = [super initWithEntity:contactEntity insertIntoManagedObjectContext:moc];
	
	// This line onwards copies the contact info from the address book entry into the Contact
	if (![person valueForProperty:kABFirstNameProperty] && ![person valueForProperty:kABLastNameProperty]) {
		self.name = @"";
	} else if (![person valueForProperty:kABLastNameProperty]) {
		self.name = [person valueForProperty:kABFirstNameProperty];
	} else if (![person valueForProperty:kABFirstNameProperty]) {
		self.name = [person valueForProperty:kABLastNameProperty];
	} else {		
		self.name = [NSString stringWithFormat:@"%@ %@", 
					 [person valueForProperty:kABFirstNameProperty], 
					 [person valueForProperty:kABLastNameProperty]];
	}
	
	self.company = [person valueForProperty:kABOrganizationProperty];
	
	multiValue = [person valueForProperty:kABAddressProperty];
	NSMutableDictionary *addr = [[NSMutableDictionary alloc] init];
	if (![self firstValueWithLabel:multiValue:kABAddressWorkLabel:&addr]) {
		if (![self firstValueWithLabel:multiValue:kABAddressHomeLabel:&addr]) {
			addr = [multiValue valueAtIndex:0];
		}
	}	

	self.address1 = [addr valueForKey:kABAddressStreetKey];
	self.address2 = @"";
	self.city = [addr valueForKey:kABAddressCityKey];
	self.province = [addr valueForKey:kABAddressStateKey];
	self.country = [addr valueForKey:kABAddressCountryKey];
	self.postalCode = [addr valueForKey:kABAddressZIPKey];

	multiValue = [person valueForProperty:kABPhoneProperty];
	NSString *phoneNumber = [NSString string];
	if (![self firstValueWithLabel:multiValue:kABPhoneWorkLabel:&phoneNumber]) {
		if (![self firstValueWithLabel:multiValue:kABPhoneMobileLabel:&phoneNumber]) {
			if (![self firstValueWithLabel:multiValue:kABPhoneiPhoneLabel:&phoneNumber]) {
				if (![self firstValueWithLabel:multiValue:kABPhoneHomeLabel:&phoneNumber]) {
					phoneNumber = [multiValue valueAtIndex:0];
				}
			}
		}
	}
	self.phoneNumber = phoneNumber;
	
	multiValue = [person valueForProperty:kABEmailProperty];
	NSString *email = [NSString string];
	if (![self firstValueWithLabel:multiValue:kABEmailWorkLabel:&email]) {
		if (![self firstValueWithLabel:multiValue:kABEmailHomeLabel:&email]) {
			email = [multiValue valueAtIndex:0];
		}
	}
	self.email = email;
	
	// At this point, I will call the duplicate checker, which will load all the contacts 
	// from the persistent store and see if a contact with this name already exists.
	
	return self;
}

-(BOOL)firstValueWithLabel:(ABMultiValue *)multiValue:(NSString *)label:(id *)result{
	int x;
	
	for (x=0; x<[multiValue count]; x++) {
		if ([[multiValue labelAtIndex:x] isEqual:label]) {
			*result = [multiValue valueAtIndex:x];
			return true;
		}
	}
	
	return false;
}

@end
