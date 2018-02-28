// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Person.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "Person.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - PersonRoot

@implementation PersonRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - PersonRoot_FileDescriptor

static GPBFileDescriptor *PersonRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
//    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@""
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Contact

@implementation Contact

@dynamic firstName;
@dynamic lastName;
@dynamic twitterName;
@dynamic email;
@dynamic githubLink;
@dynamic type;
@dynamic imageName;

typedef struct Contact__storage_ {
  uint32_t _has_storage_[1];
  Contact_ContactType type;
  NSString *firstName;
  NSString *lastName;
  NSString *twitterName;
  NSString *email;
  NSString *githubLink;
  NSString *imageName;
} Contact__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "firstName",
        .dataTypeSpecific.className = NULL,
        .number = Contact_FieldNumber_FirstName,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Contact__storage_, firstName),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "lastName",
        .dataTypeSpecific.className = NULL,
        .number = Contact_FieldNumber_LastName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Contact__storage_, lastName),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "twitterName",
        .dataTypeSpecific.className = NULL,
        .number = Contact_FieldNumber_TwitterName,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Contact__storage_, twitterName),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "email",
        .dataTypeSpecific.className = NULL,
        .number = Contact_FieldNumber_Email,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Contact__storage_, email),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "githubLink",
        .dataTypeSpecific.className = NULL,
        .number = Contact_FieldNumber_GithubLink,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(Contact__storage_, githubLink),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "type",
        .dataTypeSpecific.enumDescFunc = Contact_ContactType_EnumDescriptor,
        .number = Contact_FieldNumber_Type,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(Contact__storage_, type),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "imageName",
        .dataTypeSpecific.className = NULL,
        .number = Contact_FieldNumber_ImageName,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(Contact__storage_, imageName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Contact class]
                                     rootClass:[PersonRoot class]
                                          file:PersonRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Contact__storage_)
                                         flags:GPBDescriptorInitializationFlag_WireFormat];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\007\t\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t Contact_Type_RawValue(Contact *message) {
  GPBDescriptor *descriptor = [Contact descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Contact_FieldNumber_Type];
  return GPBGetMessageInt32Field(message, field);
}

void SetContact_Type_RawValue(Contact *message, int32_t value) {
  GPBDescriptor *descriptor = [Contact descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Contact_FieldNumber_Type];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum Contact_ContactType

GPBEnumDescriptor *Contact_ContactType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Speaker\000Attendant\000Volunteer\000";
    static const int32_t values[] = {
        Contact_ContactType_Speaker,
        Contact_ContactType_Attendant,
        Contact_ContactType_Volunteer,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(Contact_ContactType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:Contact_ContactType_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL Contact_ContactType_IsValidValue(int32_t value__) {
  switch (value__) {
    case Contact_ContactType_Speaker:
    case Contact_ContactType_Attendant:
    case Contact_ContactType_Volunteer:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Speakers

@implementation Speakers

@dynamic contactsArray, contactsArray_Count;

typedef struct Speakers__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *contactsArray;
} Speakers__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "contactsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(Contact),
        .number = Speakers_FieldNumber_ContactsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(Speakers__storage_, contactsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Speakers class]
                                     rootClass:[PersonRoot class]
                                          file:PersonRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Speakers__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
