//
//  winios.h
//  iNetHack
//
//  Created by dirk on 18/10/14.
//  Copyright (c) 2014 Dirk Zimmermann. All rights reserved.
//

#include "wintype.h"

#import "iNetHack-Swift.h"

void setNhWindows(id<NHWindows> windows);
id<NHWindows> getNhWindows();

void ios_init_nhwindows(int* argc, char** argv);
void ios_player_selection();
void ios_askname();
void ios_get_nh_event();
void ios_exit_nhwindows(const char *str);
void ios_suspend_nhwindows(const char *str);
void ios_resume_nhwindows();
winid ios_create_nhwindow(int type);
void ios_clear_nhwindow(winid wid);
void ios_display_nhwindow(winid wid, BOOLEAN_P block);
void ios_destroy_nhwindow(winid wid);
void ios_curs(winid wid, int x, int y);
void ios_putstr(winid wid, int attr, const char *text);
void ios_display_file(const char *filename, BOOLEAN_P must_exist);
void ios_start_menu(winid wid);
void ios_add_menu(winid wid, int glyph, const ANY_P *identifier,
                     CHAR_P accelerator, CHAR_P group_accel, int attr,
                     const char *str, BOOLEAN_P presel);
void ios_end_menu(winid wid, const char *prompt);
int ios_select_menu(winid wid, int how, menu_item **menu_list);
void ios_update_inventory();
void ios_mark_synch();
void ios_wait_synch();
void ios_cliparound(int x, int y);
void ios_cliparound_window(winid wid, int x, int y);
void ios_print_glyph(winid wid, XCHAR_P x, XCHAR_P y, int glyph);
void ios_raw_print(const char *str);
void ios_raw_print_bold(const char *str);
int ios_nhgetch();
int ios_nh_poskey(int *x, int *y, int *mod);
void ios_nhbell();
int ios_doprev_message();
char ios_yn_function(const char *question, const char *choices, CHAR_P def);
void ios_getlin(const char *prompt, char *line);
int ios_get_ext_cmd();
void ios_number_pad(int num);
void ios_delay_output();
void ios_start_screen();
void ios_end_screen();
void ios_outrip(winid wid, int how);