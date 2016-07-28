//
//  Contact.h
//  CRMABTest
//
//  Created by Chris Larsen on 11-02-21.
//  Copyright 2011 home. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <AddressBook/AddressBook.h>

@class NSManagedObject;

@interface Contact :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * address1;
@property (nonatomic, retain) NSString * suffix;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * province;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSNumber * salutation;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* activities;

-(id)initFromABPerson:(ABPerson *)person intoManagedObjectContext:(NSManagedObjectContext *)moc;
-(BOOL)firstValueWithLabel:(ABMultiValue *)multiValue :(NSString *)label :(id *)result;

@end


@interface Contact (CoreDataGeneratedAccessors)
/*- (void)addActivitiesObject:(NSManagedObject *)value;
- (void)removeActivitiesObject:(NSManagedObject *)value;
- (void)addActivities:(NSSet *)value;
- (void)removeActivities:(NSSet *)value;*/

@end

