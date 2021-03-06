//
//  speler.m
//  Damspel
//
//  Created by Patrick Böhner on 9/11/13.
//  Copyright (c) 2013 KB50-1. All rights reserved.
//

#import "speler.h"
#import "hokje.h"
#import "mens.h"
#import "computer.h"

@implementation speler
@synthesize steentjesTegenstander;
@synthesize kleur;

- (void) slaMet:(speler *)speler van:(NSString *)locSel op:(NSString *)locSla verplaats:(NSString *)locPlaats in:(NSDictionary *)hokjes
{
    hokje *hHuidig = [hokjes objectForKey:locSel];
    hokje *hTarget = [hokjes objectForKey:locSla];
    hokje *hLeeg = [hokjes objectForKey:locPlaats];
    
    hHuidig.inhoud = '0';
    hTarget.inhoud = '0';
    hLeeg.inhoud = speler.kleur;
    speler.steentjesTegenstander = speler.steentjesTegenstander-1;
    
    // Printen van slaan
    if ([speler isKindOfClass:[mens class]]) {
        printf("Jij slaat ");
    } else if ([speler isKindOfClass:[computer class]]) {
        printf("De computer slaat ");
    }
    
    printf("%s", [locSla UTF8String]);
    printf(" met ");
    printf("%s", [locSel UTF8String]);
    printf(" en staat nu op ");
    printf("%s", [locPlaats UTF8String]);
    printf(".\n");
    
    // Print aantal steentjes
    printf("De tegenstander heeft nu %i steentjes.\n", speler.steentjesTegenstander);
}

- (void) zet:(speler *)speler van:(NSString *)locVan naar:(NSString *)locNaar in:(NSDictionary *)hokjes
{
    hokje *hHuidig = [hokjes objectForKey:locVan];
    hokje *hTarget = [hokjes objectForKey:locNaar];
    
    hHuidig.inhoud = '0';
    hTarget.inhoud = speler.kleur;
    
    // Printen van zet
    if ([speler isKindOfClass:[mens class]]) {
        printf("Jij zet ");
    } else if ([speler isKindOfClass:[computer class]]) {
        printf("De computer zet ");
    }
    
    printf("van ");
    printf("%s", [locVan UTF8String]);
    printf(" naar ");
    printf("%s", [locNaar UTF8String]);
    printf(".\n");
}

- (NSString *) slaLocatie:(speler *)speler dictionary:(NSDictionary *)hokjes
{
    NSString *slaLocatie = [NSString stringWithFormat:@"Geen"];
    NSArray *alleHokjes = [hokjes allValues];
    
    for (hokje *h in alleHokjes) {
        if (h.inhoud == self.kleur) {
            NSString *loc = [[NSString alloc] initWithFormat:@"%@",h.loc];
            NSArray *substrings = [h.loc componentsSeparatedByString:@","];
            NSString *sub1 = [substrings objectAtIndex:0];
            NSString *sub2 = [substrings objectAtIndex:1];
            int hokX = [sub1 intValue];
            int hokY = [sub2 intValue];
            
            for (hokje *h2 in alleHokjes) {
                if (![h2.loc isEqualToString:loc]) {
                    if (h2.inhoud != speler.kleur && h2.inhoud != '0') {
                        if (speler.kleur == 'W') {
                            // check slaan onder
                            NSString *checkLO = [[NSString alloc] initWithFormat:@"%i,%i", hokX-1, hokY+1];
                            NSString *slaLO = [NSString stringWithFormat:@"%i,%i", hokX-2, hokY+2];
                            NSString *checkRO = [[NSString alloc] initWithFormat:@"%i,%i", hokX+1, hokY+1];
                            NSString *slaRO = [NSString stringWithFormat:@"%i,%i", hokX+2, hokY+2];
                            
                            if ([h2.loc isEqualToString:checkLO]) {
                                printf("Je moet slaan op: %s\n", [h2.loc UTF8String]);
                                return slaLO;
                            } else if ([h2.loc isEqualToString:checkRO]) {
                                printf("Je moet slaan op: %s\n", [h2.loc UTF8String]);
                                return slaRO;
                            }
                        } else if (speler.kleur == 'Z') {
                            // check slaan boven
                            NSString *checkLB = [[NSString alloc] initWithFormat:@"%i,%i", hokX-1, hokY-1];
                            NSString *slaLB = [NSString stringWithFormat:@"%i,%i", hokX-2, hokY-2];
                            NSString *checkRB = [[NSString alloc] initWithFormat:@"%i,%i", hokX+1, hokY-1];
                            NSString *slaRB = [NSString stringWithFormat:@"%i,%i", hokX+2, hokY-2];
                            
                            if ([h2.loc isEqualToString:checkLB]) {
                                printf("Je moet slaan op: %s\n", [h2.loc UTF8String]);
                                return slaLB;
                            } else if ([h2.loc isEqualToString:checkRB]) {
                                printf("Je moet slaan op: %s\n", [h2.loc UTF8String]);
                                return slaRB;
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    return slaLocatie;
}

@end
