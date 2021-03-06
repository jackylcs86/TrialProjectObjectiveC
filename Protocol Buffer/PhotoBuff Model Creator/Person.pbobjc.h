// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Person.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class Contact;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum Contact_ContactType

typedef GPB_ENUM(Contact_ContactType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  Contact_ContactType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  Contact_ContactType_Speaker = 0,
  Contact_ContactType_Attendant = 1,
  Contact_ContactType_Volunteer = 2,
};

GPBEnumDescriptor *Contact_ContactType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL Contact_ContactType_IsValidValue(int32_t value);

#pragma mark - PersonRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface PersonRoot : GPBRootObject
@end

#pragma mark - Contact

typedef GPB_ENUM(Contact_FieldNumber) {
  Contact_FieldNumber_FirstName = 1,
  Contact_FieldNumber_LastName = 2,
  Contact_FieldNumber_TwitterName = 3,
  Contact_FieldNumber_Email = 4,
  Contact_FieldNumber_GithubLink = 5,
  Contact_FieldNumber_Type = 6,
  Contact_FieldNumber_ImageName = 7,
};

@interface Contact : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *firstName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *lastName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *twitterName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *email;

@property(nonatomic, readwrite, copy, null_resettable) NSString *githubLink;

@property(nonatomic, readwrite) Contact_ContactType type;

@property(nonatomic, readwrite, copy, null_resettable) NSString *imageName;

@end

/**
 * Fetches the raw value of a @c Contact's @c type property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t Contact_Type_RawValue(Contact *message);
/**
 * Sets the raw value of an @c Contact's @c type property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetContact_Type_RawValue(Contact *message, int32_t value);

#pragma mark - Speakers

typedef GPB_ENUM(Speakers_FieldNumber) {
  Speakers_FieldNumber_ContactsArray = 1,
};

@interface Speakers : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Contact*> *contactsArray;
/** The number of items in @c contactsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger contactsArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
