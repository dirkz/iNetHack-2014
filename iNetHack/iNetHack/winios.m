//
//  winios.m
//  iNetHack
//
//  Created by dirk on 18/10/14.
//  Copyright (c) 2014 Dirk Zimmermann. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <stdarg.h>
#import <stdio.h>
#import <stdlib.h>

#include "hack.h"

#import "winios.h"

#pragma mark -- Setting and getting windows implementation

static id<NHWindows> nhWindows;

void setNhWindows(id<NHWindows> windows) {
    nhWindows = windows;
}

id<NHWindows> getNhWindows() {
    return nhWindows;
}

#pragma mark -- window procs

struct window_procs ios_procs = {
    "ios",
    WC_COLOR|WC_HILITE_PET|
    WC_ASCII_MAP|WC_TILED_MAP|
    WC_FONT_MAP|WC_TILE_FILE|WC_TILE_WIDTH|WC_TILE_HEIGHT|
    WC_PLAYER_SELECTION|WC_SPLASH_SCREEN,
    0L,
    ios_init_nhwindows,
    ios_player_selection,
    ios_askname,
    ios_get_nh_event,
    ios_exit_nhwindows,
    ios_suspend_nhwindows,
    ios_resume_nhwindows,
    ios_create_nhwindow,
    ios_clear_nhwindow,
    ios_display_nhwindow,
    ios_destroy_nhwindow,
    ios_curs,
    ios_putstr,
    ios_display_file,
    ios_start_menu,
    ios_add_menu,
    ios_end_menu,
    ios_select_menu,
    genl_message_menu,	/* no need for X-specific handling */
    ios_update_inventory,
    ios_mark_synch,
    ios_wait_synch,
#ifdef CLIPPING
    ios_cliparound,
#endif
#ifdef POSITIONBAR
    donull,
#endif
    ios_print_glyph,
    ios_raw_print,
    ios_raw_print_bold,
    ios_nhgetch,
    ios_nh_poskey,
    ios_nhbell,
    ios_doprev_message,
    ios_yn_function,
    ios_getlin,
    ios_get_ext_cmd,
    ios_number_pad,
    ios_delay_output,
#ifdef CHANGE_COLOR /* only a Mac option currently */
    donull,
    donull,
#endif
    /* other defs that really should go away (they're tty specific) */
    ios_start_screen,
    ios_end_screen,
    ios_outrip,
    genl_preference_update,
};

#pragma mark -- some needed functions for NetHack

// These must be defined but are not used (they handle keyboard interrupts).
void intron() {}
void introff() {}

void error(const char *s, ...) {
    //DLog(@"error: %s");
    char message[512];
    va_list ap;
    va_start(ap, s);
    vsprintf(message, s, ap);
    va_end(ap);
    NSLog(@"error: %s", message);
    // todo (button to wait for user?)
    exit(0);
}

void regularize(char *s) {
    register char *lp;
    for (lp = s; *lp; lp++) {
        if (*lp == '.' || *lp == ':')
            *lp = '_';
    }
}

#pragma mark -- window API implementation

#define BASE_WINDOW (0)

void ios_init_nhwindows(int* argc, char** argv) {
    [nhWindows initNHWindows:argc argv:<#(NSArray *)#>]
    nhWindows.initNHWindows(argc, argv);
    //DLog(@"init_nhwindows");
    iflags.runmode = RUN_STEP;
    iflags.window_inited = TRUE;
    iflags.use_color = TRUE;
    switch_graphics(IBM_GRAPHICS);
#if TARGET_OS_IPHONE && TARGET_IPHONE_SIMULATOR
    wizard = TRUE; /* debugging */
#endif
}

void ios_askname() {
    //DLog(@"askname");
    ios_getlin("Enter your name", plname);
}

void ios_get_nh_event() {
    //DLog(@"get_nh_event");
}

void ios_exit_nhwindows(const char *str) {
    //DLog(@"exit_nhwindows %s", str);
}

void ios_suspend_nhwindows(const char *str) {
    //DLog(@"suspend_nhwindows %s", str);
}

void ios_resume_nhwindows() {
    //DLog(@"resume_nhwindows");
}

winid ios_create_nhwindow(int type) {
    switch (type) {
        case NHW_MAP:
            break;
        case NHW_MENU:
            break;
        case NHW_STATUS:
            break;
        default:
            break;
    }
    //DLog(@"create_nhwindow(%x) %x", type, w);
    return (winid) 0;
}

void ios_clear_nhwindow(winid wid) {
    //DLog(@"clear_nhwindow %x", wid);
}

void ios_display_nhwindow(winid wid, BOOLEAN_P block) {
    //DLog(@"display_nhwindow %x, %i, %i", wid, ((NhWindow *) wid).type, block);
}

void ios_destroy_nhwindow(winid wid) {
    //DLog(@"destroy_nhwindow %x", wid);
}

void ios_curs(winid wid, int x, int y) {
    //DLog(@"curs %x %d,%d", wid, x, y);
}

void ios_putstr(winid wid, int attr, const char *text) {
    //DLog(@"putstr %x %s", wid, text);
    if (wid == WIN_ERR || !wid) {
        wid = BASE_WINDOW;
    }
}

void ios_display_file(const char *filename, BOOLEAN_P must_exist) {
    //DLog(@"display_file %s", filename);
}

void ios_start_menu(winid wid) {
    //DLog(@"start_menu %x", wid);
}

void ios_add_menu(winid wid, int glyph, const ANY_P *identifier,
                     CHAR_P accelerator, CHAR_P group_accel, int attr,
                     const char *str, BOOLEAN_P presel) {
    //DLog(@"add_menu %x %s", wid, str);
}

void ios_end_menu(winid wid, const char *prompt) {
    //DLog(@"end_menu %x, %s", wid, prompt);
}

int ios_select_menu(winid wid, int how, menu_item **selected) {
    //DLog(@"select_menu %x", wid);
    return 0;
}

void ios_update_inventory() {
    //DLog(@"update_inventory");
}

void ios_mark_synch() {
    //DLog(@"mark_synch");
}

void ios_wait_synch() {
    //DLog(@"wait_synch");
}

void ios_cliparound(int x, int y) {
    //DLog(@"cliparound %d,%d", x, y);
}

void ios_cliparound_window(winid wid, int x, int y) {
    //DLog(@"cliparound_window %x %d,%d", wid, x, y);
}

void ios_print_glyph(winid wid, XCHAR_P x, XCHAR_P y, int glyph) {
    //DLog(@"print_glyph %x %d,%d", wid, x, y);
}

void ios_raw_print(const char *str) {
    NSLog(@"raw_print %s", str);
}

void ios_raw_print_bold(const char *str) {
    //DLog(@"raw_print_bold %s", str);
    ios_raw_print(str);
}

int ios_nhgetch() {
    NSLog(@"nhgetch");
    return 0;
}

int ios_nh_poskey(int *x, int *y, int *mod) {
    //DLog(@"nh_poskey");
    return 0;
}

void ios_nhbell() {
    NSLog(@"nhbell");
}

int ios_doprev_message() {
    //DLog(@"doprev_message");
    return 0;
}

char ios_yn_function(const char *question, const char *choices, CHAR_P def) {
    //DLog(@"yn_function %s", question);
    return 0;
}

void ios_getlin(const char *prompt, char *line) {
    //DLog(@"getlin %s", prompt);
}

int ios_get_ext_cmd() {
    //DLog(@"get_ext_cmd");
    return 0;
}

void ios_number_pad(int num) {
    NSLog(@"number_pad %d", num);
}

void ios_delay_output() {
    //DLog(@"delay_output");
}

void ios_start_screen() {
    NSLog(@"start_screen");
}
void ios_end_screen() {
    NSLog(@"end_screen");
}
void ios_outrip(winid wid, int how) {
    NSLog(@"outrip %x", wid);
}

#pragma mark -- window API player_selection()

// from tty port
/* clean up and quit */
static void bail(const char *mesg) {
    ios_exit_nhwindows(mesg);
    terminate(EXIT_SUCCESS);
}

// from tty port
static int ios_role_select(char *pbuf, char *plbuf) {
    int i, n;
    char thisch, lastch = 0;
    char rolenamebuf[QBUFSZ];
    winid win;
    anything any;
    menu_item *selected = 0;
    ios_clear_nhwindow(BASE_WINDOW);
    ios_putstr(BASE_WINDOW, 0, "Choosing Character's Role");
    /* Prompt for a role */
    win = create_nhwindow(NHW_MENU);
    start_menu(win);
    any.a_void = 0; /* zero out all bits */
    for (i = 0; roles[i].name.m; i++) {
        if (ok_role(i, flags.initrace, flags.initgend,
                    flags.initalign)) {
            any.a_int = i+1;	/* must be non-zero */
            thisch = lowc(roles[i].name.m[0]);
            if (thisch == lastch) thisch = highc(thisch);
            if (flags.initgend != ROLE_NONE && flags.initgend != ROLE_RANDOM) {
                if (flags.initgend == 1 && roles[i].name.f)
                    Strcpy(rolenamebuf, roles[i].name.f);
                else
                    Strcpy(rolenamebuf, roles[i].name.m);
            } else {
                if (roles[i].name.f) {
                    Strcpy(rolenamebuf, roles[i].name.m);
                    Strcat(rolenamebuf, "/");
                    Strcat(rolenamebuf, roles[i].name.f);
                } else
                    Strcpy(rolenamebuf, roles[i].name.m);
            }
            add_menu(win, NO_GLYPH, &any, thisch,
                     0, ATR_NONE, an(rolenamebuf), MENU_UNSELECTED);
            lastch = thisch;
        }
    }
    any.a_int = pick_role(flags.initrace, flags.initgend,
                          flags.initalign, PICK_RANDOM)+1;
    if (any.a_int == 0)	/* must be non-zero */
        any.a_int = randrole()+1;
    add_menu(win, NO_GLYPH, &any , '*', 0, ATR_NONE,
             "Random", MENU_UNSELECTED);
    any.a_int = i+1;	/* must be non-zero */
    add_menu(win, NO_GLYPH, &any , 'q', 0, ATR_NONE,
             "Quit", MENU_UNSELECTED);
    Sprintf(pbuf, "Pick a role for your %s", plbuf);
    end_menu(win, pbuf);
    n = select_menu(win, PICK_ONE, &selected);
    ios_destroy_nhwindow(win);
    /* Process the choice */
    if (n != 1 || selected[0].item.a_int == any.a_int) {
        free((genericptr_t) selected),	selected = 0;
        return (-1);	/* Selected quit */
    }
    flags.initrole = selected[0].item.a_int - 1;
    free((genericptr_t) selected),	selected = 0;
    return (flags.initrole);
}

// from tty port
static int ios_race_select(char * pbuf, char * plbuf) {
    int i, k, n;
    char thisch, lastch = 0;
    winid win;
    anything any;
    menu_item *selected = 0;
    /* Count the number of valid races */
    n = 0;	/* number valid */
    k = 0;	/* valid race */
    for (i = 0; races[i].noun; i++) {
        if (ok_race(flags.initrole, i, flags.initgend,
                    flags.initalign)) {
            n++;
            k = i;
        }
    }
    if (n == 0) {
        for (i = 0; races[i].noun; i++) {
            if (validrace(flags.initrole, i)) {
                n++;
                k = i;
            }
        }
    }
    /* Permit the user to pick, if there is more than one */
    if (n > 1) {
        ios_clear_nhwindow(BASE_WINDOW);
        ios_putstr(BASE_WINDOW, 0, "Choosing Race");
        win = create_nhwindow(NHW_MENU);
        start_menu(win);
        any.a_void = 0; /* zero out all bits */
        for (i = 0; races[i].noun; i++)
            if (ok_race(flags.initrole, i, flags.initgend,
                        flags.initalign)) {
                any.a_int = i+1;	/* must be non-zero */
                thisch = lowc(races[i].noun[0]);
                if (thisch == lastch) thisch = highc(thisch);
                add_menu(win, NO_GLYPH, &any, thisch,
                         0, ATR_NONE, races[i].noun, MENU_UNSELECTED);
                lastch = thisch;
            }
        any.a_int = pick_race(flags.initrole, flags.initgend,
                              flags.initalign, PICK_RANDOM)+1;
        if (any.a_int == 0)	/* must be non-zero */
            any.a_int = randrace(flags.initrole)+1;
        add_menu(win, NO_GLYPH, &any , '*', 0, ATR_NONE,
                 "Random", MENU_UNSELECTED);
        any.a_int = i+1;	/* must be non-zero */
        add_menu(win, NO_GLYPH, &any , 'q', 0, ATR_NONE,
                 "Quit", MENU_UNSELECTED);
        Sprintf(pbuf, "Pick the race of your %s", plbuf);
        end_menu(win, pbuf);
        n = select_menu(win, PICK_ONE, &selected);
        destroy_nhwindow(win);
        if (n != 1 || selected[0].item.a_int == any.a_int)
            return(-1);	/* Selected quit */
        k = selected[0].item.a_int - 1;
        free((genericptr_t) selected),	selected = 0;
    }
    flags.initrace = k;
    return (k);
}

// from tty port
void ios_player_selection() {
    int i, k, n;
    char pick4u = 'n';
    char pbuf[QBUFSZ], plbuf[QBUFSZ];
    winid win;
    anything any;
    menu_item *selected = 0;
    /* prevent an unnecessary prompt */
    rigid_role_checks();
    /* Should we randomly pick for the player? */
    if (!flags.randomall &&
        (flags.initrole == ROLE_NONE || flags.initrace == ROLE_NONE ||
         flags.initgend == ROLE_NONE || flags.initalign == ROLE_NONE)) {
            char *prompt = build_plselection_prompt(pbuf, QBUFSZ, flags.initrole,
                                                    flags.initrace, flags.initgend, flags.initalign);
            pick4u = ios_yn_function(prompt, "ynq", pick4u);
            ios_clear_nhwindow(BASE_WINDOW);
            if (pick4u != 'y' && pick4u != 'n') {
            give_up:	/* Quit */
                if (selected) free((genericptr_t) selected);
                bail((char *)0);
                /*NOTREACHED*/
                return;
            }
        }
    (void) root_plselection_prompt(plbuf, QBUFSZ - 1,
                                   flags.initrole, flags.initrace, flags.initgend, flags.initalign);
    /* Select a role, if necessary */
    /* we'll try to be compatible with pre-selected race/gender/alignment,
     * but may not succeed */
    if (flags.initrole < 0) {
        /* Process the choice */
        if (pick4u == 'y' || flags.initrole == ROLE_RANDOM || flags.randomall) {
            /* Pick a random role */
            flags.initrole = pick_role(flags.initrace, flags.initgend,
                                       flags.initalign, PICK_RANDOM);
            if (flags.initrole < 0) {
                ios_putstr(BASE_WINDOW, 0, "Incompatible role!");
                flags.initrole = randrole();
            }
        } else {
            if (ios_role_select(pbuf, plbuf) < 0) goto give_up;
        }
        (void) root_plselection_prompt(plbuf, QBUFSZ - 1,
                                       flags.initrole, flags.initrace, flags.initgend, flags.initalign);
    }
    /* Select a race, if necessary */
    /* force compatibility with role, try for compatibility with
     * pre-selected gender/alignment */
    if (flags.initrace < 0 || !validrace(flags.initrole, flags.initrace)) {
        /* pre-selected race not valid */
        if (pick4u == 'y' || flags.initrace == ROLE_RANDOM || flags.randomall) {
            flags.initrace = pick_race(flags.initrole, flags.initgend,
                                       flags.initalign, PICK_RANDOM);
            if (flags.initrace < 0) {
                ios_putstr(BASE_WINDOW, 0, "Incompatible race!");
                flags.initrace = randrace(flags.initrole);
            }
        } else {	/* pick4u == 'n' */
            if (ios_race_select(pbuf, plbuf) < 0) goto give_up;
        }
        (void) root_plselection_prompt(plbuf, QBUFSZ - 1,
                                       flags.initrole, flags.initrace, flags.initgend, flags.initalign);
    }
    /* Select a gender, if necessary */
    /* force compatibility with role/race, try for compatibility with
     * pre-selected alignment */
    if (flags.initgend < 0 || !validgend(flags.initrole, flags.initrace,
                                         flags.initgend)) {
        /* pre-selected gender not valid */
        if (pick4u == 'y' || flags.initgend == ROLE_RANDOM || flags.randomall) {
            flags.initgend = pick_gend(flags.initrole, flags.initrace,
                                       flags.initalign, PICK_RANDOM);
            if (flags.initgend < 0) {
                ios_putstr(BASE_WINDOW, 0, "Incompatible gender!");
                flags.initgend = randgend(flags.initrole, flags.initrace);
            }
        } else {	/* pick4u == 'n' */
            /* Count the number of valid genders */
            n = 0;	/* number valid */
            k = 0;	/* valid gender */
            for (i = 0; i < ROLE_GENDERS; i++) {
                if (ok_gend(flags.initrole, flags.initrace, i,
                            flags.initalign)) {
                    n++;
                    k = i;
                }
            }
            if (n == 0) {
                for (i = 0; i < ROLE_GENDERS; i++) {
                    if (validgend(flags.initrole, flags.initrace, i)) {
                        n++;
                        k = i;
                    }
                }
            }
            /* Permit the user to pick, if there is more than one */
            if (n > 1) {
                ios_clear_nhwindow(BASE_WINDOW);
                ios_putstr(BASE_WINDOW, 0, "Choosing Gender");
                win = create_nhwindow(NHW_MENU);
                start_menu(win);
                any.a_void = 0; /* zero out all bits */
                for (i = 0; i < ROLE_GENDERS; i++)
                    if (ok_gend(flags.initrole, flags.initrace, i,
                                flags.initalign)) {
                        any.a_int = i+1;
                        add_menu(win, NO_GLYPH, &any, genders[i].adj[0],
                                 0, ATR_NONE, genders[i].adj, MENU_UNSELECTED);
                    }
                any.a_int = pick_gend(flags.initrole, flags.initrace,
                                      flags.initalign, PICK_RANDOM)+1;
                if (any.a_int == 0)	/* must be non-zero */
                    any.a_int = randgend(flags.initrole, flags.initrace)+1;
                add_menu(win, NO_GLYPH, &any , '*', 0, ATR_NONE,
                         "Random", MENU_UNSELECTED);
                any.a_int = i+1;	/* must be non-zero */
                add_menu(win, NO_GLYPH, &any , 'q', 0, ATR_NONE,
                         "Quit", MENU_UNSELECTED);
                Sprintf(pbuf, "Pick the gender of your %s", plbuf);
                end_menu(win, pbuf);
                n = select_menu(win, PICK_ONE, &selected);
                destroy_nhwindow(win);
                if (n != 1 || selected[0].item.a_int == any.a_int)
                    goto give_up;	/* Selected quit */
                k = selected[0].item.a_int - 1;
                free((genericptr_t) selected),	selected = 0;
            }
            flags.initgend = k;
        }
        (void) root_plselection_prompt(plbuf, QBUFSZ - 1,
                                       flags.initrole, flags.initrace, flags.initgend, flags.initalign);
    }
    /* Select an alignment, if necessary */
    /* force compatibility with role/race/gender */
    if (flags.initalign < 0 || !validalign(flags.initrole, flags.initrace,
                                           flags.initalign)) {
        /* pre-selected alignment not valid */
        if (pick4u == 'y' || flags.initalign == ROLE_RANDOM || flags.randomall) {
            flags.initalign = pick_align(flags.initrole, flags.initrace,
                                         flags.initgend, PICK_RANDOM);
            if (flags.initalign < 0) {
                ios_putstr(BASE_WINDOW, 0, "Incompatible alignment!");
                flags.initalign = randalign(flags.initrole, flags.initrace);
            }
        } else {	/* pick4u == 'n' */
            /* Count the number of valid alignments */
            n = 0;	/* number valid */
            k = 0;	/* valid alignment */
            for (i = 0; i < ROLE_ALIGNS; i++) {
                if (ok_align(flags.initrole, flags.initrace, flags.initgend,
                             i)) {
                    n++;
                    k = i;
                }
            }
            if (n == 0) {
                for (i = 0; i < ROLE_ALIGNS; i++) {
                    if (validalign(flags.initrole, flags.initrace, i)) {
                        n++;
                        k = i;
                    }
                }
            }
            /* Permit the user to pick, if there is more than one */
            if (n > 1) {
                ios_clear_nhwindow(BASE_WINDOW);
                ios_putstr(BASE_WINDOW, 0, "Choosing Alignment");
                win = create_nhwindow(NHW_MENU);
                start_menu(win);
                any.a_void = 0; /* zero out all bits */
                for (i = 0; i < ROLE_ALIGNS; i++)
                    if (ok_align(flags.initrole, flags.initrace,
                                 flags.initgend, i)) {
                        any.a_int = i+1;
                        add_menu(win, NO_GLYPH, &any, aligns[i].adj[0],
                                 0, ATR_NONE, aligns[i].adj, MENU_UNSELECTED);
                    }
                any.a_int = pick_align(flags.initrole, flags.initrace,
                                       flags.initgend, PICK_RANDOM)+1;
                if (any.a_int == 0)	/* must be non-zero */
                    any.a_int = randalign(flags.initrole, flags.initrace)+1;
                add_menu(win, NO_GLYPH, &any , '*', 0, ATR_NONE,
                         "Random", MENU_UNSELECTED);
                any.a_int = i+1;	/* must be non-zero */
                add_menu(win, NO_GLYPH, &any , 'q', 0, ATR_NONE,
                         "Quit", MENU_UNSELECTED);
                Sprintf(pbuf, "Pick the alignment of your %s", plbuf);
                end_menu(win, pbuf);
                n = select_menu(win, PICK_ONE, &selected);
                destroy_nhwindow(win);
                if (n != 1 || selected[0].item.a_int == any.a_int)
                    goto give_up;	/* Selected quit */
                k = selected[0].item.a_int - 1;
                free((genericptr_t) selected),	selected = 0;
            }
            flags.initalign = k;
        }
    }
    /* Success! */
    ios_display_nhwindow(BASE_WINDOW, FALSE);
}