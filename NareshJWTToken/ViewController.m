//
//  ViewController.m
//  NareshJWTToken
//
//  Created by Narendra Kumar R on 12/8/17.
//  Copyright © 2017 Narendra. All rights reserved.
//

#import "ViewController.h"
#import "NSData+Base64.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *token = @"eyJhbGciOiJSUzI1NiIsImtpZCI6ImFza2V5MDEifQ.eyJlZ3Vlc3RfaWQiOiI5ODE4MTM5IiwiZGlnaXRhbF9pZCI6IjEwNjcxMDY5IiwibXBlcmtzX3Nob3BwZXJfaWQiOiI3Nzk3Nzg3NzU4MyIsImhhc19kaWdpdGFsIjoiMSIsImhhc19tcGVya3MiOiIxIiwibXBlcmtzX2V4dF9zaG9wcGVyX2lkIjoiRkNFQzE0RDUtQ0E2My00NDQwLTlCRUMtRTEwNkRGMzA2NTgwIiwiZXhwIjoxNTEyNzU1NTcyLCJzY29wZSI6WyJvcGVuaWQiXSwiY2xpZW50X2lkIjoiU2NhbkFuZEdvIiwiaXNzIjoiaHR0cHM6XC9cL2Nsb2dpbi5tZWlqZXIuY29tXC8ifQ.YSHihI8MVO8-eQWrtSrX0LBM_AjoB6AivV-XC3uRdFxAzcz_Knf0JpFUA3k3FDBP8iH7ibE6FHy3ha2FuQXV5HmkDXwn90ChznA-g1TBrwmfuAPaBagVp5qwOJh7gqP0bZ_sb6jOtr9ETvbqjtpcJph4U-G6fdHxE8h5DR152u-BLQkK1z-BPfTdbvjlxZzsawWitTW3T6Ut3e3xCrqT_vAM4RBSik5A0ZrQChopLAS8wNLhIL7Am3npRrbBjKZubHke1Mid_IrPKktX6AiCUv-u4mSZTltmbMlvSdjavsxyKrOilaUNUADEEjsE8dX99I3oqybvPf6fDAwGIW-J4A";
    
    NSArray *tokenComponents = [token componentsSeparatedByString:@"."];
    NSString *base64Payload = [tokenComponents objectAtIndex:1];
    NSData *data = [NSData dataFromBase64String:base64Payload];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSLog(@"digitals id is %@", [jsonDict valueForKey:@"digital_id"]);
}

+ (NSData *)base64DataFromString: (NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil)
    {
        return [NSData data];
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[string UTF8String];
    
    lentext = [string length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true)
    {
        if (ixtext >= lentext)
        {
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z'))
        {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z'))
        {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9'))
        {
            ch = ch - '0' + 52;
        }
        else if (ch == '+')
        {
            ch = 62;
        }
        else if (ch == '=')
        {
            flendtext = true;
        }
        else if (ch == '/')
        {
            ch = 63;
        }
        else
        {
            flignore = true;
        }
        
        if (!flignore)
        {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext)
            {
                if (ixinbuf == 0)
                {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2))
                {
                    ctcharsinbuf = 1;
                }
                else
                {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4)
            {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++)
                {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak)
            {
                break;
            }
        }
    }
    
    return theData;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
