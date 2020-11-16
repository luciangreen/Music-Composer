
%% do 100 business songs at start of day

%% automatically do a sale every hour until 11 PM x for n hours

%% get txt,mid filenames
%% get br count of txt
%% br multiple
   
%% move them into another folder (delete or save on la com next day - compress and email)

%% later: react to periods

sectest0(N) :-
	write("*** Please indicate "),
	write(N),
	writeln(" number 1 songs. ***"),
	sleep(5),
	sectest1(N).

sectest1(0) :- !.
sectest1(N1) :-
	catch(
	(sectest0(_Form1,_Lyrics,_Melody,_Harmony,_MelodyParts,
	_HarmonyParts,_Vocalstubinstrument,_Song1),
	writeln([song,N1,done]),
	N2 is N1-1,
	sectest1(N2)),
   _,
	sectest1(N1)
).

%% sales points, meditators lists

:-include('../../../Dropbox/ProgramFinder/possiblynotworking/vpsbu 27 10 19/meditatorsanddoctors.pl').

sales_points([real_people_not_bots,
to_the_meditator_for_the_sale_for_me,
graciously_given,
sales,
bot,
this_universe,
meditation_course,
money_to_and_from_them,
going_above_it,
i_don_t_want_to_x,
i_want_to_click_on_the_button,
click_on_it,
i_clicked_it,
education_when_they_buy_it,
philosophy_when_they_buy_it,
keep_them_happy_so_they_don_t_come_back,
our_seen_as_version_for_the_sale_play_tennis_court_in_place,
comment_high_quality_comment_from_primary_school,
all_the_wiggly_things_are_taken_care_of_for_us,
not_enough_as_x_all_the_rest_are_done_for_us,
they_can_resell_the_skills_in_the_course,
ten_br_songs_i_ve_listened_to,
i_d_kill_for_you_to_do_it,
from_god_s_perspective,
receiver_for_their_happy_and_sad_thoughts_for_five_days,
transmitter_for_solving_sad_thoughts_for_five_days,
solve_sad_thoughts_with_five_multiple_choice_questions_that_apply_to_any_sentence_i_understand_and_i_need_to_read_the_previous_sentence_and_i_need_to_find_a_term_s_definition_and_i_m_interested_in_finding_out_more_and_i_m_enjoying_reading_for_five_days,
i_do_something_and_they_do_something]).

