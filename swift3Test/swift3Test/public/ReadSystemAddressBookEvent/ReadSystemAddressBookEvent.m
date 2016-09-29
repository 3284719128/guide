//
//  ReadSystemAddressBookEvent.m
//  LogisticsHousekeeper
//
//  Created by 43696467 on 16/8/8.
//  Copyright © 2016年 ZengXingTechnology. All rights reserved.
//

#import "ReadSystemAddressBookEvent.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import <ContactsUI/ContactsUI.h>

#import "popupView.h"

@interface ReadSystemAddressBookEvent()<CNContactPickerDelegate,ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ReadSystemAddressBookEvent

static ReadSystemAddressBookEvent* readSystemAddressBookE=nil;

+(id)sharedReadSystemAddressBookEvent{
    
    if (readSystemAddressBookE == nil) {
        readSystemAddressBookE=[[ReadSystemAddressBookEvent alloc] init];
    };
    
    return readSystemAddressBookE;
    
}


-(void)ReadSystemAddressBook:(UIViewController*) VC andSubBlock:(void (^)(NSString* name,NSString* phone)) block{
    
    self.targetVC=VC;
    self.subBlock=block;
    
    [self skipPeoplePickerNavigationController];
}

-(void)skipPeoplePickerNavigationController{
    
    float systemVersion=[[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 9.0) {
        
        CNContactPickerViewController* VC=[[CNContactPickerViewController alloc] init];
        VC.delegate=self;
        [self.targetVC presentViewController:VC animated:YES completion:nil];
        
    }else{
        
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        [self.targetVC presentViewController:peoplePicker animated:YES completion:nil];
        
        
    };
   
}

#pragma mark- CNContactPickerDelegate

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    
    NSString* familyName=contact.familyName;
    NSString* givenName=contact.givenName;
    
    NSArray* array=contact.phoneNumbers;
    NSMutableArray* phoneArray=[[NSMutableArray alloc] init];
    for (int i=0,leng=(int)array.count; i<leng; i++) {
        
        CNLabeledValue* labeledValue=array[i];
        CNPhoneNumber* number=labeledValue.value;
        NSString* phoneStr=number.stringValue;
        [phoneArray addObject:[self phoneStringFilter:phoneStr]];
    };
    
    [self setMoreViewValueAndFirstName:givenName lastName:familyName phoneArray:phoneArray];
    
}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
}


#pragma mark- ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0){
    
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    NSString* firstName=(__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName=(__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    NSMutableArray* phoneArray=[[NSMutableArray alloc] init];
    for (int k = 0; k<ABMultiValueGetCount(valuesRef); k++)
    {
        //获取电话Label
        //NSString* personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(valuesRef, k));
        //获取該Label下的电话值
        NSString* personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(valuesRef, k);
        
        [phoneArray addObject:personPhone];
    }
    
    [self setMoreViewValueAndFirstName:firstName lastName:lastName phoneArray:phoneArray];
    
}


-(void)setMoreViewValueAndFirstName:(NSString*) first lastName:(NSString*) last phoneArray:(NSMutableArray*) arrary{
    
    NSMutableString* receiveManName=[[NSMutableString alloc] init];
    
    if (![last isEqualToString:@""] && last != nil) {
        [receiveManName appendString:last];
    }
    
    if (![first isEqualToString:@""] && first != nil) {
        [receiveManName appendString:first];
    }
    
    
    
    
    if ([arrary count] > 1) {
        
        popupView* popupV=[[popupView alloc] initWithButtonArray:arrary block:^(NSInteger num) {
            NSString* phone=arrary[num];
            NSArray* array2=[phone componentsSeparatedByString:@"-"];
            
            NSMutableString* phoneStr=[[NSMutableString alloc] init];
            for (int i=0; i<[array2 count]; i++) {
                [phoneStr appendString:array2[i]];
            };
            
            if (self.subBlock) {
                self.subBlock(receiveManName,phoneStr);
            };
            
        }];
        [self.targetVC.view addSubview:popupV];
        
    }else{
        NSString* phone=arrary[0];
        NSArray* array2=[phone componentsSeparatedByString:@"-"];
        
        NSMutableString* phoneStr=[[NSMutableString alloc] init];
        for (int i=0; i<[array2 count]; i++) {
            [phoneStr appendString:array2[i]];
        };
        
        if (self.subBlock) {
            self.subBlock(receiveManName,phoneStr);
        };
        
    };
    
}


#pragma mark- 电话号码特殊符号处理

-(NSString*)phoneStringFilter:(NSString*) phoneStr{
    
    if ([phoneStr isEqualToString:@""] || phoneStr == nil) {
        return @"";
    };
    
    NSCharacterSet* characterSet=[NSCharacterSet characterSetWithCharactersInString:@"-+ "];
    NSArray* strArray=[phoneStr componentsSeparatedByCharactersInSet:characterSet];
    
    NSMutableString* newString=[[NSMutableString alloc] init];
    for (int i=0; i<[strArray count]; i++) {
        NSString* string=[strArray objectAtIndex:i];
        if (string.length > 0) {
            [newString appendString:string];
        };
    };
    
    return newString;
    
}



@end
