/**

- Form
- Which chord progression type?
- Lyrics - random sentences, rhyming
- Melody - random starting and ending note of first phrase, melody and harmony from chord progression type with three notes (split for melody), the circle of fifths for connection between sections
- Which of up to 3 instruments for each of melody and harmony
- What sections they will play

- Melody cut to the length of vocals

**/

use_module(library(pio)).

:- use_module(library(date)).
%%:-include('texttobr2qb').
%%:-include('mindreadtestshared').
%%:-include('texttobr2').
%%:-include('texttobr').
%%:-include('texttobr2qbmusic').

:-include('../listprologinterpreter/listprolog.pl').

:-include('mindreadtestmusiccomposer-unusual-ui-rhythm.pl').%mindreadtestmusiccomposer-unusual-mr-tree.pl').

%:-include('musiclibrary').
%:-include('../listprologinterpreter/listprolog.pl').
%:-include('../listprologinterpreter/la_strings.pl').
%:-include('../listprologinterpreter/la_files.pl').
%:-include('../mindreader/make_mind_reading_tree4 working1.pl').
%:-include('../mindreader/mr_tree.pl').
%:-include('instruments_mr-tree.pl').

%sectest(0) :- !.
%sectest(N1) :-
%	writeln(["\n",N1]),
:-dynamic ask_for_rhythm/1.


meta2mid :-
	retractall(ask_for_rhythm(_)),
	assertz(ask_for_rhythm(false)),

meta2mid1.

meta2mid_r :-
	retractall(ask_for_rhythm(_)),
	assertz(ask_for_rhythm(true)),

meta2mid1.
meta2mid1 :-

	check_asc2mid,



Folder="meta",
foldr(string_concat,[Folder,"/"],Path),
	directory_files(Path,F),
	delete_invisibles_etc(F,G),

findall(_,(member(Filex1,G),
	string_concat(Path,Filex1,Filex),
	% Additional_variables are [label,var]
	open_file_s(Filex,Meta_file),

%open_file_s("meta/song202422921430.467365026474_meta.txt",Meta_file),	

Meta_file=[[form,Form1],[chord_progressions,CPT],[voice_part,Voiceparts2],[melody,Melody],[harmony,Harmony],[melody_instruments,
		MelodyInstruments],[harmony_instruments,HarmonyInstruments],[melody_parts,MelodyParts],[harmony_parts,
		HarmonyParts],[lyrics,Lyrics],
		[genre,["anthem"]]|Rhythm1],
		
		(Rhythm1=[[rhythm,Rhythm]]->
		(
	retractall(rhythm(_)),
	assertz(rhythm(Rhythm)));
	
	(ask_for_rhythm(true)->rhythm;%(MelodyParts,HarmonyParts);
	(retractall(rhythm(_)),
	assertz(rhythm([["0","NT","1/2",1,80],["1/2","NT","1/2",1,80],["1","NT","1/2",2,80],["1+1/2","NT","1/2",2,80],["2","NT","1/2",3,80],["2+1/2","NT","1/2",3,80],["3","NT","1/2",4,80],["3+1/2","NT","1/2",4,80]]))))),
	
%sectest0(_Form1,_Lyrics,_Melody,_Harmony,_MelodyParts,
	%_HarmonyParts,_Vocalstubinstrument,_Song1),
	%N2 is N1-1,
	%sectest(N2),!.

%sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1) :-
	
 	%%texttobr2qb(2), %%Imagine song
	%form(Form1),
	%%Form1=[v2,o],
	%find("Should the chord progression type be 1451, 1564, 1645, Classical or Classical Pop?",CPT),
	%remove_dups(Form1,[],Form2),
	%Voiceparts1=[v1,v2,c,s],
	intersection(Form1,[v1,v2,c,s],Voiceparts2),
	lyrics2_m2m(%Voiceparts1,
	Lyrics,0,Maxlength),
	%findall(B,(member(A1,Form2),string_concat(B1,_C,A1),
	%string_length(B1,1),atom_string(B,B1)),Form3),
	%remove_dups(Form3,[],Form4),
	%%repeat, %% in case melody, harmony don't work
	%melodyharmony(Form4,CPT,Maxlength,Melody,Harmony),
	%%writeln(melodyharmony(Form4,CPT,Maxlength,Melody,Harmony)), %% ***
	%instruments(Form1,MelodyInstruments,HarmonyInstruments,
		%MelodyParts,HarmonyParts,Vocalstubinstrument),
	%%writeln(instruments(Form1,MelodyInstruments,HarmonyInstruments,
%%		MelodyParts,HarmonyParts,
%%		Vocalstubinstrument)),
	%%writeln(rendersong(Form1,Voiceparts2,Maxlength,Melody,Harmony,
	%%	MelodyInstruments,HarmonyInstruments,MelodyParts,
	%%	HarmonyParts,Lyrics,
	%%	Vocalstubinstrument,Song1)), %%,
	Vocalstubinstrument=[0,"Acoustic Grand Piano"],

	%working_directory1(WD,WD),
	%working_directory1(_,"mid/"),
	
	rendersong(Form1,Voiceparts2,Maxlength,Melody,Harmony,
		MelodyInstruments,HarmonyInstruments,MelodyParts,
		HarmonyParts,Lyrics,
		Vocalstubinstrument,_Song1,File1),
		
		rhythm(Rhythm2),
		
		Meta_file3=[[form,Form1],[chord_progressions,CPT],[voice_part,Voiceparts2],[melody,Melody],[harmony,Harmony],[melody_instruments,
		MelodyInstruments],[harmony_instruments,HarmonyInstruments],[melody_parts,MelodyParts],[harmony_parts,
		HarmonyParts],[lyrics,Lyrics],
		[genre,["anthem"]],[rhythm,Rhythm2]],
		
			term_to_atom(Meta_file3,Meta_file1),
	string_atom(Meta_file2,Meta_file1),

%member(Filex1,G),
	% Additional_variables are [label,var]
	%open_file_s(Filex,Meta_file),
	
	%concat_list("",[Filex1],File2),
	
	concat_list("",[File1,"_meta.txt"],Filex2),
	%string_concat(Path,File2,Filex2),
	%working_directory1(WD,WD),
	%working_directory1(_,"../"),	
	(open_s(Filex2,write,Stream1),
	write(Stream1,Meta_file2),
	close(Stream1))
	%working_directory1(_,WD)	

),_), %%,

	%working_directory1(_,WD),
/*
Meta_file=[[form,Form1],[chord_progressions,CPT],[voice_part,Voiceparts2],[melody,Melody],[harmony,Harmony],[melody_instruments,
		MelodyInstruments],[harmony_instruments,HarmonyInstruments],[melody_parts,MelodyParts],[harmony_parts,
		HarmonyParts],[lyrics,Lyrics],
		[genre,["anthem"]]],
*/
	!.

%lyrics_m2m(Form1,Lyrics,Maxlength) :-
	%%find("Who is the song about?",Character),
	%%lyrics1(Form,Character,[],Lyrics).
	%catch((lyrics2_m2m(Form1,[],Lyrics,[],_Names,0,Maxlength)),_,
%	lyrics_m2m(Form1,Lyrics,Maxlength)).

lyrics2_m2m([],Maxlength,Maxlength) :- !.
lyrics2_m2m(Lyrics1,Maxlength1,Maxlength2) :-
	
	%Form1=[Form2|Forms3],
	Lyrics1=[[_Form2,Sentence1,Sentence2,Sentence3,Sentence4]|Lyrics3],
	
	%findsentence(Sentence1,Names1,Names3),
	length(Sentence1,Length1),
	%findsentence(Sentence2,Names3,Names4),
	length(Sentence2,Length2),
	%findrhyme(Sentence1,Sentence3,Names4,Names5),
	length(Sentence3,Length3),
	%findrhyme(Sentence2,Sentence4,Names5,Names6),
	length(Sentence4,Length4),
	%append(Lyrics1,[[Form2,Sentence1,Sentence2,Sentence3,Sentence4]],Lyrics3),
	max([Length1,Length2,Length3,Length4],Maxlength1,Maxlength3),
	lyrics2_m2m(Lyrics3,Maxlength3,Maxlength2),!.