/**

- Form
- Which chord progression type?
- Lyrics - random sentences, rhyming
- Melody - random starting and ending note of first phrase, melody and harmony from chord progression type with three notes (split for melody), the circle of fifths for connection between sections
- Which of up to 3 instruments for each of melody and harmony
- What sections they will play

- Melody cut to the length of vocals

**/

:-use_module(library(pio)).

:- use_module(library(date)).
%%:-include('texttobr2qb').
%%:-include('mindreadtestshared').
%%:-include('texttobr2').
%%:-include('texttobr').
%%:-include('texttobr2qbmusic').

:-include('musiclibrary').
:-include('la_strings').

:-dynamic rhythm/1.

sectest(0) :- !.
sectest(N1) :-
	writeln(["\n",N1]),
	sectest0(_Form1,_Lyrics,_Melody,_Harmony,_MelodyParts,
	_HarmonyParts,_Vocalstubinstrument,_Song1),
	N2 is N1-1,
	sectest(N2),!.

sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1) :-
	check_asc2mid,
	retractall(rhythm(_)),
	assertz(rhythm([])),
 	%%texttobr2qb(2), %%Imagine song
	%%form(Form1),
	writeln("Please enter form in format e.g. [n,v1,i1,v2,c,t2,s,s,s]."),
	read_string(user_input, "\n", "\r", _, Form1A),
	atom_to_term(Form1A,Form1,_),
	
	%%Form1=[v2,o],
	%%find("Should the chord progression type be 1451, 1564, 1645, Classical or Classical Pop?",CPT),
	writeln("Should the chord progression type be 1451, 1564, 1645, classical or classicalpop?"),
	read_string(user_input, "\n", "\r", _, CPT1),
	atom_string(CPT,CPT1),

	remove_dups(Form1,[],Form2),
	Voiceparts1=[v1,v2,c,s],
	intersection(Form1,[v1,v2,c,s],Voiceparts2),
	%%lyrics(Voiceparts1,Lyrics,Maxlength),
	writeln(["Please enter lyrics for parts",Voiceparts1,"in format e.g. [[v1, [\"All\", \"ney\", \"goes\", \"to\", \"the\"], [\"Le\", \"ice\", \"is\", \"in\"], [\"the\", \"mir\", \"ac\"], [\"the\", \"graph\"]], [v2, [\"Dix\", \"ard\"]]]."]),
	read_string(user_input, "\n", "\r", _End2, LyricsA),
	atom_to_term(LyricsA,Lyrics,_),

findall(DH,(member(C1H,Lyrics),C1H=[_|C2H],member(CH,C2H),length(CH,DH)),EH),sort(EH,FH),reverse(FH,GH),GH=[Maxlength|_],
 
	findall(B,(member(A1,Form2),string_concat(B1,_C,A1),
	string_length(B1,1),atom_string(B,B1)),Form3),
	remove_dups(Form3,[],Form4),
	%%repeat, %% in case melody, harmony don't work
	melodyharmony(Form4,CPT,Maxlength,Melody,Harmony),
	%%writeln(melodyharmony(Form4,CPT,Maxlength,Melody,Harmony)), %% ***
	instruments(Form1,MelodyInstruments,HarmonyInstruments,
		MelodyParts,HarmonyParts,Vocalstubinstrument),
		
	rhythm,%(MelodyParts,HarmonyParts),	
	%%writeln(instruments(Form1,MelodyInstruments,HarmonyInstruments,
%%		MelodyParts,HarmonyParts,
%%		Vocalstubinstrument)),
	%%writeln(rendersong(Form1,Voiceparts2,Maxlength,Melody,Harmony,
	%%	MelodyInstruments,HarmonyInstruments,MelodyParts,
	%%	HarmonyParts,Lyrics,
	%%	Vocalstubinstrument,Song1)), %%,
%%
%trace,
	rendersong(Form1,Voiceparts2,Maxlength,Melody,Harmony,
		MelodyInstruments,HarmonyInstruments,MelodyParts,
		HarmonyParts,Lyrics,
		Vocalstubinstrument,Song1,File1), %%,

rhythm(Rhythm),
Meta_file=[[form,Form1],[chord_progressions,CPT],[voice_part,Voiceparts2],[melody,Melody],[harmony,Harmony],[melody_instruments,
		MelodyInstruments],[harmony_instruments,HarmonyInstruments],[melody_parts,MelodyParts],[harmony_parts,
		HarmonyParts],[lyrics,Lyrics],
		[genre,["anthem"]],[rhythm,Rhythm]],
		
	term_to_atom(Meta_file,Meta_file1),
	string_atom(Meta_file2,Meta_file1),

	concat_list("",[File1,"_meta.txt"],File2),
	(open_s(File2,write,Stream1),
	write(Stream1,Meta_file2),
	close(Stream1)),!
	.
	%Section,Instrument,Playing
rhythm:-%(MelodyParts,HarmonyParts) :-
%trace,
	%writeln("Please enter the vocal rhythms*")
	%findall(R1,(member([Section,Instrument,1],MelodyParts)))
	rhythm1(R),
	retractall(rhythm(_)),
	assertz(rhythm(R)),!.

rhythm1(R2) :-
	writeln("Please enter the song's bar rhythm in the format [[time,type=n/r,length,nth_note_from_mel_harm,velocity=0-127],...], e.g. [[0,n,1/2,1,80],[1/2,n,1/2,1,80],[1,n,1/2,2,80],[1+1/2,n,1/2,2,80],[2,n,1/2,3,80],[2+1/2,n,1/2,3,80],[3,n,1/2,4,80],[3+1/2,n,1/2,4,80]] or \"ta1 ta1 tityca ta.\" (note full stop) where \"1\" optionally denotes nth_note_from_mel_harm."),
	read_string(user_input, "\n", "\r", _, R10),
	%trace,
	rhythm2(R10,R2),!.

string_compound(A,B) :- catch(number(B),_,false),number_string(B,A),!.
string_compound(A,C/D) :- %catch(number(B),_,false),%number_string(B,A1),
frac_to_string(C/D,CD),foldr(string_concat,[CD],A),!.
string_compound(A,B+C/D) :- catch(number(B),_,false),number_string(B,A1),frac_to_string(C/D,CD),foldr(string_concat,[A1,"+",CD],A).
frac_to_string(A/B,AB) :- foldr(string_concat,[A,"/",B],AB).

%% n intro, vn verse, c chorus, i1 instrumental1, t2, instrumental 2, s solo, o outro

rhythm2(R10,R2) :-
	% ta a a a(n), ta a a, ta a, ta, ti( )ca ti, same for za
	% delete space, replace with length
	% simplify time, ff frac
	string_concat(R101,".",R10),
	string_strings(R101,R11),
	delete(R11," ",R12),
	foldr(string_concat,R12,R13),
	process_rhythm(R13,R14),
	split_on_substring1(R14,"bcdefghijklmno",R15),
	%trace,
	find_rhythm(0,1,R15,[],R2),
	(R2=[]->true;
	(%trace,
	reverse(R2,[[T,_,L,_,_]|_]),
	term_to_atom(T1,T),term_to_atom(L1,L),
	Total is T1+L1,
	not(Total>4))),
	!.
	
rhythm2(R10,R2) :-
%trace,
	not(R10=""),
	catch(term_to_atom(R1,R10),_,false),
	%member([T,_,_,_],R1),not(T>=4),
	forall(member([A,B,C,D,F],R1),(string_compound(_,A),(B=n->true;B=r),string_compound(_,C),
	0=<F,F=<127)),
	findall([A1,B1,C1,D,F],(member([A,B,C,D,F],R1),string_compound(A1,A),(B=n->B1="NT";(B=r,B1="R")),string_compound(C1,C)
	),R2),!.
	
rhythm2(_R10,R2) :-
	writeln("Error: Please re-input:"),
	rhythm1(R2),!.

process_rhythm(A,C) :-
 process_rhythm1(Replacements),
 atom_string(A1,A),
 process_rhythm2(Replacements,A1,D1),
 atom_string(D1,C),!.
 
process_rhythm2([],A,A) :- !.
process_rhythm2(Replacements,A,D) :-
 Replacements=[[B,C]|G],
 atomic_list_concat(E,B,A),
 atomic_list_concat(E,C,F),
 process_rhythm2(G,F,D),!.

	process_rhythm1([['taaaa','b'],['taaa','c'],['taa','d'],['ta','e'],['ty','g'],['ca','g'],['ti','f'],['tim','n'],['zaaaa','h'],['zaaa','i'],['zaa','j'],['za','k'],['zi','l'],['zim','o'],['zy','m']]).
		
find_rhythm(_,_,[],B,B) :- !.
find_rhythm(Time,Note_n,A,B,C) :-
%writeln1(find_rhythm(Time,Note_n,A,B,C)),
%trace,
	A=[D|E],
	atom_string(D2,D),
	time(D2,Type,Length),
	% ["1/2","NT","1/2",1,80]
	ff_frac(Time,Time1),
	(Type=n->Type1="NT";Type1="R"),
	%Lengths=[Length1|Lengths2],
	ff_frac(Length,Length1),
	(E=[D1|E1]->
	(catch(number_string(D3,D1),_,false)->(Note_n1=D3,A1=E1);(Note_n1=Note_n,A1=E));
	(A1=E,Note_n1=Note_n)),
	%writeln1(append(B,[[Time1,Type1,Length1,Note_n1,80]],B1)),
	append(B,[[Time1,Type1,Length1,Note_n1,80]],B1),
	
	%catch(number_string(Length5,Length),_,false),
	Time2 is Time+Length,
	(Type1="NT"->Note_n2 is Note_n1+1;Note_n2=Note_n1),
	find_rhythm(Time2,Note_n2,A1,B1,C),!.

	
time(b,n,4).
time(c,n,3).
time(d,n,2).
time(e,n,1).
time(f,n,0.5).
time(g,n,0.25).
time(h,r,4).
time(i,r,3).
time(j,r,2).
time(k,r,1).
time(l,r,0.5).
time(m,r,0.25).
time(n,n,0.75).
time(o,r,0.75).

% 1, 1+1/2, 1/2
ff_frac(N1,S) :-
 floor(N1,N2),
 (N1 =:= N2->(N21=N2,N31="");
 (N3 is N1-N2,
 numbers(4,0,[],Ns),
 member(N4,Ns),
 member(N5,Ns),
 catch(N3 is N4/N5,_,false),
 (N2=0->N21="";string_concat(N2,"+",N21)),
 foldr(string_concat,[N4,"/",N5],N31))),
 foldr(string_concat,[N21,N31],S),!.
 
findall1(Form2,Form3) :-
	findall(B,shorten(Form2,B),Form3).

shorten(Form2,B) :-
	member(A1,Form2),string_concat(B1,_C,A1),
	string_length(B1,1),atom_string(B,B1).

form(Form) :-
	Form1=[n,v1],
	find("Should a chorus or instrumental come after the first verse?",CorI),
	(CorI=c->
	(append(Form1,[c,v2,c,t2,s],Form2),
	find(["Should a chorus and outro or two solos come after the first solo?",1],COorSS),
		(COorSS=[c,o]->
		(append(Form2,[c],Form3),
		append(Form3,[o],Form));
		COorSS=[s,s],
		append(Form2,[s],Form3),append(Form3,[s],Form))
	);
	(CorI=i1,append(Form1,[i1,v2,c,t2,s],Form2),
	find(["Should a chorus and outro or two solos come after the first solo?",2],COorSS),
		(COorSS=[c,o]->
		(append(Form2,[c],Form3),
		append(Form3,[o],Form));
		COorSS=[s,s],
		append(Form2,[s],Form3),append(Form3,[s],Form))
	)).

makename(N3) :-
	trialy2(["Ack","Luc","Add","All","Brae","Skye","Whist","Dix","Wilb","Duk","Le","Ven",
	"Syd","Don","Count","Black","Nei"],R1),
	findbest(R1,N1),
	trialy2(["an","ae","ye","ler","ee","ur","ard","ice","ney","ald","ess","el"],R2),
	findbest(R2,N2),
	append([N1],[N2],N3).

makenames(0,Ns,Ns) :- !.
makenames(Num1,N1,N2) :-
	random_member(R1,["Ack","Luc","Add","All","Brae","Skye","Whist","Dix","Wilb","Duk","Le","Ven",
	"Syd","Don","Count","Black","Nei"]),
	random_member(R2,["an","ae","ye","ler","ee","ur","ard","ice","ney","ald","ess","el"]),
	append([R1],[R2],R3),
	append(N1,[R3],N3),
	Num2 is Num1-1,
	makenames(Num2,N3,N2).

findsentence(Sentence,Names1,Names2) :-
	makename(N1),readv(Vs),reado(Os),
	makenames(5,[],N2s1),append(N2s1,Names1,N2s),
	trialy2(Vs,R1),
	findbest(R1,R11),
	append(Os,N2s,Os2),
	trialy2(Os2,R2),
	findbest(R2,R21),
	append_list(N1,[R11,R21],Sentence),
	(member(R21,N2s1)->
		append(Names1,[R21],Names2);
		Names2=Names1).

findrhyme(Phrase1,Phrase2,Names1,Names2) :-
	reverse(Phrase1,Reverse),
	Reverse=[Lastsyllable|_],
	readv(Vs),reado(Os),makenames(5,[],N2s1),
	append(N2s1,Names1,N2s),
	append(Os,N2s,Os2),
	trialy2(Os2,R2),
	findbest(R2,R21),
	trialy2(Vs,R1),
	findbest(R1,R11),
	findall(C,(member(C,N2s),reverse(C,B),B=[E|_],rhymes2(E,Lastsyllable)),Phrases22),
	trialy2(Phrases22,R3),
	findbest(R3,R31),
	append_list(R21,[R11,R31],Phrase2),
	(member(R21,N2s1)->
		append(Names1,[R21],Names3);
		Names3=Names1),
	(member(Phrases22,N2s1)->
		append(Names3,[R21],Names2);
		Names2=Names3).

rhymes2(Syllable1,Syllable2) :-
	rhymes(Lists),
	member(List1,Lists),
	member(Syllable1,List1),
	member(Syllable2,List1).

lyrics(Form1,Lyrics,Maxlength) :-
	%%find("Who is the song about?",Character),
	%%lyrics1(Form,Character,[],Lyrics).
	catch((lyrics2(Form1,[],Lyrics,[],_Names,0,Maxlength)),_,
	lyrics(Form1,Lyrics,Maxlength)).

lyrics2([],Lyrics,Lyrics,Names,Names,Maxlength,Maxlength) :- !.
lyrics2(Form1,Lyrics1,Lyrics2,Names1,Names2,Maxlength1,Maxlength2) :-
	Form1=[Form2|Forms3],
	findsentence(Sentence1,Names1,Names3),
	length(Sentence1,Length1),
	findsentence(Sentence2,Names3,Names4),
	length(Sentence2,Length2),
	findrhyme(Sentence1,Sentence3,Names4,Names5),
	length(Sentence3,Length3),
	findrhyme(Sentence2,Sentence4,Names5,Names6),
	length(Sentence4,Length4),
	append(Lyrics1,[[Form2,Sentence1,Sentence2,Sentence3,Sentence4]],Lyrics3),
	max([Length1,Length2,Length3,Length4],Maxlength1,Maxlength3),
	lyrics2(Forms3,Lyrics3,Lyrics2,Names6,Names2,Maxlength3,Maxlength2),!.


melodyharmony(Form1,CPT,Maxlength,Melody,Harmony) :-
	Partlength is Maxlength div 3,
	Extra is Maxlength mod 3,
	Total is Partlength+Extra,
	_Parts=[Partlength,Partlength,Partlength,Total],
	%%(CPT=1451->findall(A,note0(_,A),Notes);
	%%findall(A,note0(_,A),Notes)),
	%% What note should the song start on?
	%%trialy2(Notes,R1),
	%%findbest(R1,R11),
	%%R11='A',
	melodyharmony(Form1,CPT,_Parts2,_R11,_R2,[],Melody,[],Harmony).
	
melodyharmony([],_CPT,_Parts,N,N,Melody,Melody,Harmony,Harmony) :- !.
melodyharmony(Form1,CPT,Parts,N1,N2,Melody1,Melody2,Harmony1,Harmony2) :-
	Form1=[Form2|Forms3],
	findmelody(Form2,CPT,Parts,N1,N3,Melody1,Melody3,Harmony1,Harmony3),

	(CPT='1451'->harmony1451(N3,3,N4);harmonyr(N3,5,N4)),
	findmelody(Form2,CPT,Parts,N4,N5,Melody3,Melody4,Harmony3,Harmony4),
	%%reverse(Melody3,Melody3R),Melody3R=[[_,Melody3RI]|_], %% relies on repeat *1
	%%reverse(Melody4,Melody4R),Melody4R=[[_,Melody4RI]|_],
	%%not((length(Melody3RI,1),length(Melody4RI,1))),
	melodyharmony(Forms3,CPT,Parts,N5,N2,Melody4,Melody2,
		Harmony4,Harmony2).

findmelody(Form,CPT,_Parts,_N1,_N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT='1451',
	%%(CPT=1451->findall(A,note0(_,A),Notes);
	%%findall(A,note0(_,A),Notes)),
	%% What note should the phrase end on?
	%%repeat,
	%%trialy2(Notes,R1),
	%%findbest(R1,N2),
	%%versechorussoloprogression1451(N1,N2,Progression),
	%%trialy2(Progression,R2),
	%%findbest(R2,Progression2),
	repeat,
	writeln(["Please enter melody line for form",Form,"in format e.g. four notes from [d,di,r,ri,m,f,fi,s,si,l,li,t]."]),
	read_string(user_input, "\n", "\r", _End21, Progression2B),
	atom_to_term(Progression2B,Progression2A,_),
	solfatonotes(Progression2A,[],Progression2),
not(Progression2=[]),
	append(Melody1,[[Form,Progression2]],Melody2),
	%%versechorussoloprogression1451(N1,N2,Progression3),
	%%trialy2(Progression3,R3),
	%%findbest(R3,Progression4),
	repeat,
	writeln(["Please enter harmony line in format e.g. four notes from ['C','E','G'] for",Form,"."]),
	read_string(user_input, "\n", "\r", _, Progression4A),
	atom_to_term(Progression4A,Progression4,_),

	harmony(Form,CPT,Progression4,Harmony1,Harmony2).	
findmelody(Form,CPT,_Parts,_N1,_N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT='1564',
	repeat,
	writeln(["Please enter melody line for form",Form,"in format e.g. four notes from [d,di,r,ri,m,f,fi,s,si,l,li,t]."]),
	read_string(user_input, "\n", "\r", _, Progression2B),
	atom_to_term(Progression2B,Progression2A,_),
	solfatonotes(Progression2A,[],Progression2),	not(Progression2=[]),
	append(Melody1,[[Form,Progression2]],Melody2),
	%%versechorussoloprogression1451(N1,N2,Progression3),
	%%trialy2(Progression3,R3),
	%%findbest(R3,Progression4),
	repeat,
	writeln(["Please enter harmony line in format e.g. four notes from ['C','E','G'] for",Form,"."]),
	read_string(user_input, "\n", "\r", _, Progression4A),
	atom_to_term(Progression4A,Progression4,_),
	harmony(Form,CPT,Progression4,Harmony1,Harmony2).
findmelody(Form,CPT,_Parts,_N1,_N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT='1645',
	repeat,
	writeln(["Please enter melody line for form",Form,"in format e.g. four notes from [d,di,r,ri,m,f,fi,s,si,l,li,t]."]),
	read_string(user_input, "\n", "\r", _, Progression2B),
	atom_to_term(Progression2B,Progression2A,_),
	solfatonotes(Progression2A,[],Progression2),	not(Progression2=[]),
	append(Melody1,[[Form,Progression2]],Melody2),
	%%versechorussoloprogression1451(N1,N2,Progression3),
	%%trialy2(Progression3,R3),
	%%findbest(R3,Progression4),
	repeat,
	writeln(["Please enter harmony line in format e.g. four notes from ['C','E','G'] for",Form,"."]),
	read_string(user_input, "\n", "\r", _, Progression4A),
	atom_to_term(Progression4A,Progression4,_),
	harmony(Form,CPT,Progression4,Harmony1,Harmony2).
findmelody(Form,CPT,_Parts,_N1,_N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT=classical,
	repeat,
	writeln(["Please enter melody line for form",Form,"in format e.g. four notes from [d,di,r,ri,m,f,fi,s,si,l,li,t]."]),
	read_string(user_input, "\n", "\r", _, Progression2B),
	atom_to_term(Progression2B,Progression2A,_),
	solfatonotes(Progression2A,[],Progression2),	not(Progression2=[]),
	append(Melody1,[[Form,Progression2]],Melody2),
	%%versechorussoloprogression1451(N1,N2,Progression3),
	%%trialy2(Progression3,R3),
	%%findbest(R3,Progression4),
	repeat,
	writeln(["Please enter harmony line in format e.g. four notes from ['C','E','G'] for",Form,"."]),
	read_string(user_input, "\n", "\r", _, Progression4A),
	atom_to_term(Progression4A,Progression4,_),
	harmony(Form,CPT,Progression4,Harmony1,Harmony2).
findmelody(Form,CPT,_Parts,_N1,_N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT=classicalpop,
	repeat,
	writeln(["Please enter melody line for form",Form,"in format e.g. four notes from [d,di,r,ri,m,f,fi,s,si,l,li,t]."]),
	read_string(user_input, "\n", "\r", _, Progression2B),
	atom_to_term(Progression2B,Progression2A,_),
	solfatonotes(Progression2A,[],Progression2),	not(Progression2=[]),
	append(Melody1,[[Form,Progression2]],Melody2),
	%%versechorussoloprogression1451(N1,N2,Progression3),
	%%trialy2(Progression3,R3),
	%%findbest(R3,Progression4),
	repeat,
	writeln(["Please enter harmony line in format e.g. four notes from ['C','E','G'] for",Form,"."]),
	read_string(user_input, "\n", "\r", _, Progression4A),
	atom_to_term(Progression4A,Progression4,_),
	harmony(Form,CPT,Progression4,Harmony1,Harmony2).

harmony(Form,CPT,Progression,Harmony1,Harmony2) :-
	harmony1(Form,CPT,Progression,[],Harmony3),
	append(Harmony1,[Harmony3],Harmony2).
	
harmony1(_Form,_CPT,[],Harmony,Harmony) :- !.
harmony1(Form,CPT,Progression1,Harmony1,Harmony2) :-
	Progression1=[Note1|Progression2],
	(CPT='1451'->(harmony1451(Note1,2,Note2),harmony1451(Note1,4,Note3));
	(harmonyr(Note1,4,Note2),harmonyr(Note1,7,Note3))),
	Harmony30=[Note2,Note3],
	findall(B1,(member(A1,Harmony30),string_concat(B,_C,A1),string_length(B,1),atom_string(B1,B)),Harmony31),
	append([Note1],Harmony31,Harmony3),
	append(Harmony1,[[Form,Harmony3]],Harmony4),
	harmony1(Form,CPT,Progression2,Harmony4,Harmony2),!.
	
harmony1451(Note1,Value2,Note2) :-
	note(Value1,Note1),Value3 is Value1+Value2,Value4 is Value3 mod 12,note(Value4,Note2).
harmonyr(Note1,Value2,Note2) :-
	note(Value1,Note1),Value3 is Value1+Value2,Value4 is Value3 mod 12,note(Value4,Note2).


solfatonotes([],Progression1,Progression1) :- !.
solfatonotes(Progression2A,Progression1,Progression2) :-
	Progression2A=[N1|Ns],
	solfegenotetonote(N1,N2),
	append(Progression1,[N2],Progression3),
	solfatonotes(Ns,Progression3,Progression2).

solfegenotetonote(d,'C').
solfegenotetonote(di,'C#').
solfegenotetonote(r,'D').
solfegenotetonote(ri,'D#').
solfegenotetonote(m,'E').
solfegenotetonote(f,'F').
solfegenotetonote(fi,'F#').
solfegenotetonote(s,'G').
solfegenotetonote(si,'G#').
solfegenotetonote(l,'A').
solfegenotetonote(li,'A#').
solfegenotetonote(t,'B').


instruments(Form1,MelodyInstruments,HarmonyInstruments,MelodyParts,HarmonyParts,Vocalstubinstrument) :-
	melodyinstrumentnumber(MelodyInstrumentNumber),
	harmonyinstrumentnumber(HarmonyInstrumentNumber),
	instrumentlist(MelodyInstrumentNumber,MelodyInstruments),
	instrumentlist(HarmonyInstrumentNumber,HarmonyInstruments),
	Vocalstubinstrument=[0,"Acoustic Grand Piano"],
	parts(Form1,MelodyInstruments,MelodyParts),
	aggregate_all(count, (member(A1,MelodyParts),not(A1=[_,_,0])), Count1),
	not(Count1=0),
	parts(Form1,HarmonyInstruments,HarmonyParts),
	aggregate_all(count, (member(A2,HarmonyParts),not(A2=[_,_,0])), Count2),
	not(Count2=0).	
	
melodyinstrumentnumber(NumberofInstruments) :-
	%% Number of melody instruments
	trialy2("Number of melody instruments?",[1,2,3,4,5,6,7,8,9,10],R1),
	findbest(R1,NumberofInstruments).

harmonyinstrumentnumber(NumberofInstruments) :-
	%% Number of harmony instruments
	trialy2("Number of harmony instruments?",[1,2,3,4,5,6,7,8,9,10],R1),
	findbest(R1,NumberofInstruments).
	
instrumentlist(NumberofInstruments,Instruments) :-
	instrumentlist(NumberofInstruments,[],Instruments),!.

instrumentlist(0,Instruments,Instruments) :- !.
instrumentlist(NumberofInstruments1,Instruments1,Instruments2) :-
	Instruments=[[0,"Acoustic Grand Piano"],[1,"Bright Acoustic Piano"],[2,"Electric Grand Piano"],[3,"Honky-Tonk Piano"],[4,"Electric Piano 1"],[5,"Electric Piano 2"],[6,"Harpsichord"],[7,"Clavinet"],[8,"Celesta"],[9,"Glockenspiel"],[10,"Music Box"],[11,"Vibraphone"],[12,"Marimba"],[13,"Xylophone"],[14,"Tubular Bells"],[15,"Dulcimer"],[16,"Drawbar Organ"],[17,"Percussive Organ"],[18,"Rock Organ"],[19,"Church Organ"],[20,"Reed Organ"],[21,"Accordian"],[22,"Harmonica"],[23,"Tango Accordian"],[24,"Nylon Acoustic Guitar"],[25,"Steel Acoustic Guitar"],[26,"Jazz Electric Guitar"],[27,"Clean Electric Guitar"],[28,"Muted Electric Guitar"],[29,"Overdriven Guitar"],[30,"Distortion Guitar"],[31,"Guitar Harmonics"],[32,"Acoustic Bass"],[33,"Electric Bass (finger)"],[34,"Electric Bass (pick)"],[35,"Fretless Bass"],[36,"Slap Bass 1"],[37,"Slap Bass 2"],[38,"Synth Bass 1"],[39,"Synth Bass 2"],[40,"Violin"],[41,"Viola"],[42,"Cello"],[43,"Contrabass"],[44,"Tremolo Strings"],[45,"Pizzicato Strings"],[46,"Orchestral Harp"],[47,"Timpani"],[48,"String Ensemble 1"],[49,"String Ensemble 2"],[50,"Synth Strings 1"],[51,"Synth Strings 2"],[52,"Choir Aahs"],[53,"Voice Oohs"],[54,"Synth Choir"],[55,"Orchestra Hit"],[56,"Trumpet"],[57,"Trombone"],[58,"Tuba"],[59,"Muted Trumpet"],[60,"French Horn"],[61,"Brass Section"],[62,"Synth Brass 1"],[63,"Synth Brass 2"],[64,"Soprano Sax"],[65,"Alto Sax"],[66,"Tenor Sax"],[67,"Baritone Sax"],[68,"Oboe"],[69,"English Horn"],[70,"Bassoon"],[71,"Clarinet"],[72,"Piccolo"],[73,"Flute"],[74,"Recorder"],[75,"Pan Flute"],[76,"Blown Bottle"],[77,"Shakuhachi"],[78,"Whistle"],[79,"Ocarina"],[80,"Lead 1 (square)"],[81,"Lead 2 (sawtooth)"],[82,"Lead 3 (calliope)"],[83,"Lead 4 (chiff)"],[84,"Lead 5 (charang)"],[85,"Lead 6 (voice)"],[86,"Lead 7 (fifths)"],[87,"Lead 8 (bass + lead)"],[88,"Pad 1 (new age)"],[89,"Pad 2 (warm)"],[90,"Pad 3 (polysynth)"],[91,"Pad 4 (choir)"],[92,"Pad 5 (bowed)"],[93,"Pad 6 (metallic)"],[94,"Pad 7 (halo)"],[95,"Pad 8 (sweep)"],[96,"FX 1 (rain)"],[97,"FX 2 (soundtrack)"],[98,"FX 3 (crystal)"],[99,"FX 4 (atmosphere)"],[100,"FX 5 (brightness)"],[101,"FX 6 (goblins)"],[102,"FX 7 (echoes)"],[103,"FX 8 (sci-fi)"],[104,"Sitar"],[105,"Banjo"],[106,"Shamisen"],[107,"Koto"],[108,"Kalimba"],[109,"Bagpipe"],[110,"Fiddle"],[111,"Shanai"],[112,"Tinkle Bell"],[113,"Agogo"],[114,"Steel Drums"],[115,"Woodblock"],[116,"Taiko Drum"],[117,"Melodic Tom"],[118,"Synth Drum"],[119,"Reverse Cymbal"],[120,"Guitar Fret Noise"],[121,"Breath Noise"],[122,"Seashore"]],
	%% ,[123,"Bird Tweet"],[124,"Telephone Ring"],[125,"Helicopter"],[126,"Applause"],[127,"Gunshot"]
	
	trialy2("Please select an instrument from:",Instruments,R1),
	findbest(R1,Instrument),
	append(Instruments1,[Instrument],Instruments3),
	NumberofInstruments2 is NumberofInstruments1-1,
	instrumentlist(NumberofInstruments2,Instruments3,Instruments2),!.

parts(Form,Instruments,Parts) :-
	parts1(Form,Instruments,[],Parts),!.

parts1(_Form,[],Parts,Parts) :- !.
parts1(Form,Instruments1,Parts1,Parts2) :-
	Instruments1=[Instrument2|Instruments3],
	parts2(Form,Instrument2,[],Part3),
	append(Parts1,[Part3],Parts4),
	parts1(Form,Instruments3,Parts4,Parts2),!.
	
parts2([],_Instrument,Part,Part) :- !.
parts2(Form1,Instrument,Part1,Part2) :-
	Form1=[Section|Form2],
	(member([Section,Instrument,Playing],Part1)->true;
	%% Is the instrument playing in the section?
	term_to_atom(Instrument,Instrument1),
	concat_list("Is ",[Instrument1," playing in ",Section,"?"],Question),
	(trialy2(Question,[0,1],R1),
	findbest(R1,Playing))),
	append(Part1,[[Section,Instrument,Playing]],Part3),
	parts2(Form2,Instrument,Part3,Part2),!.
	
/**
concat_list(A,[],A):-!.
concat_list(A,List,B) :-
	List=[Item|Items],
	string_concat(A,Item,C),
	concat_list(C,Items,B).
**/

concat_list(A,[],A) :-!.
concat_list(A,List,B) :-
	List=[Item|Items],
	concat_list2(A,[Item],C),
	concat_list(C,Items,B).
concat_list2(A,List,C) :-
	((List=[[Item|Items]]->true;List=[Item|Items])->
	concat_list0(A,[Item|Items],C);
	fail),!.
concat_list2(A,Item,C) :-
	concat_list(A,Item,C),!.
	
concat_list0([],""):-!.
concat_list0(A1,B):-
	A1=[A|List],
	concat_list0(A,List,B),!.

concat_list0(A,[],A):-!.
concat_list0(A,List,B) :-
	List=[Item|Items],
	string_concat(A,Item,C),
	concat_list0(C,Items,B).

sentencewithspaces(Sentence1,Sentence2) :-
	Sentence1=[Item|Items],
	string_concat(Firstletter1,Rest,Item),
	string_length(Firstletter1,1),
	upcase_atom(Firstletter1,Firstletter2),
	concat_list(Firstletter2,[Rest,""],Item2),
	flatten(Items,Items1),
	sentencewithspaces(Items1,Item2,Sentence3),
	string_concat(Sentence3,".",Sentence2).

sentencewithspaces([],Sentence,Sentence) :- !.
sentencewithspaces(Sentence1,Sentence2,Sentence3) :-
	Sentence1=[Word|Sentence4],
	concat_list("",[Sentence2," ",Word],Item2),
	sentencewithspaces(Sentence4,Item2,Sentence3),!.

rendersong(Form1,Voiceparts,_Maxlength,Melody,
	Harmony,MelodyInstruments,
	HarmonyInstruments,MelodyParts1,
	HarmonyParts,Lyrics,Vocalstubinstrument,Song1,File1) :-
	Totallength=8,
	Voicetrack=1,
	length(MelodyInstruments,MelodyInstrumentsLength),
	length(HarmonyInstruments,HarmonyInstrumentsLength),
	TracksNumber is MelodyInstrumentsLength+HarmonyInstrumentsLength+2,
	Lyrics=[[_,Sentence1|_]|_],sentencewithspaces(Sentence1,Sentence2),
	concat_list("format=1 tracks=", [TracksNumber, " division=384\n\nBA    1   CR         0   TR  0   CH 16   Text type 2: \"Produced by Mind Reading Music Composer by Lucian Academy (Manual Entry Rhythm Mode)\"\nBA    1   CR         0   TR  0   CH 16   Text type 3: \"", Sentence2, "\"\nBA    1   CR         0   TR  0   CH  1   Channel volume 127\nBA    1   CR         0   TR  0   CH 16   Tempo 63.00009\n"], Song2),
	printheader(Voicetrack,Vocalstubinstrument,Song2,Song3),
	%%writeln(renderv1(Form1,Voiceparts,_,Lyrics,Melody,
	%%	Totallength,Voicetrack,1,_,Song3,Song4)), %% ****
	renderv1(Form1,Voiceparts,_,Lyrics,Melody,
		Totallength,Voicetrack,1,_,Song3,Song4),
	Track2 is Voicetrack+1,
	renderm1(Form1,Melody,MelodyParts1,
		Track2,_Track3,Song4,Song5),
	Track4 is MelodyInstrumentsLength+2,
	renderh1(Form1,Harmony,HarmonyParts,
	Track4,_Track5,Song5,Song6),
	length(Form1,FormLength),
	TotalBars is 4*FormLength+1,
	concat_list(Song6,["BA    ",TotalBars,"   CR         0   TR  0   CH 16   End of track"],Song1),
		get_time(TS),stamp_date_time(TS,date(Year,Month,Day,Hour1,Minute1,Seconda,_A,_TZ,_False),local),
	concat_list("song",[Year,Month,Day,Hour1,Minute1,Seconda],File1),
	concat_list(File1,[".txt"],File2),
	concat_list(File1,[".mid"],File3),
	open_s(File2,write,Stream),
	write(Stream,Song1),
 	close(Stream),
 	concat_list("./asc2mid ",[File2," > ",File3],Command),
 	shell1_s(Command),
 	%%writeln(["Texttobr, Texttobr2 not working.  Please manually breason out ",File2]),
 	%%N is 4, M is 4000,  texttobr2(N,File2,u,M),texttobr(N,File2,u,M),
	outputlyrics(File1,Lyrics),

/**
 	texttobr2qb(3), %% give self breasonings
 	texttobr2qb(20), %%Feature 1
 	texttobr2qb(20), %%Updates
 	texttobr2qb(20), %%Feature 2
 	texttobr2qb(20), %%Updates
 	texttobr2qb(20), %%Feature 3
 	texttobr2qb(20), %%Updates
 	texttobr2qb(100), %%Icon
 	texttobr2qb(20), %%Updates
 	texttobr2qb(32), %%Lyrics
 	texttobr2qb(36), %%Music
 	texttobr2qb(20), %%Updates
 	
 	texttobr2qb(2), %%Medicine
 	texttobr2qb(20), %%Updates
 	texttobr2qb(2), %%Sales
 	texttobr2qb(20), %%Updates
 	texttobr2qb(2), %%Marketing
 	texttobr2qb(20), %%Updates

 	texttobr2qb(2), %%Graciously give or blame listener for colour imagery
 	texttobr2qb(20), %%Updates

 	texttobr2qb(2), %%Play song
 	texttobr2qb(2), %%Like song
 	**/
!.

printheader(Voicetrack,Vocalstubinstrument,Song1,Song2) :-
	Vocalstubinstrument=[N1,_],
	N2 is N1+1,
	concat_list("BA    1   CR         0   TR  ",[Voicetrack,"   CH  ",Voicetrack,"   Instrument ",N2,"\nBA    1   CR         0   TR  ",Voicetrack,"   CH  ",Voicetrack,"   NT  R            0   von=127   voff=0\n"],Song3),
	string_concat(Song1,Song3,Song2).

renderv1([],_Voiceparts,_Vocalstubinstrument,_Lyrics,_Melody,_Totallength,_Track,_Bar,_Bar2,Voice,Voice) :- !.
renderv1(Form1,Voiceparts1,Vocalstubinstrument,Lyrics,Melody,Totallength,Track,Bar1,Bar2,Voice1,Voice2) :-
	Form1=[Section|Form2],
	Voiceparts1=[Section|Voiceparts2],
	renderv2(Section,Lyrics,Melody,Totallength,Track,
		Bar1,Bar3,Voice1,Voice3),
	renderv1(Form2,Voiceparts2,Vocalstubinstrument,Lyrics,Melody,
		Totallength,Track,Bar3,Bar2,Voice3,Voice2),!.

renderv1(Form1,Voiceparts1,Vocalstubinstrument,Lyrics,Melody,Totallength,
Track,Bar1,Bar2,Voice1,Voice2) :-
	Form1=[Section1|Form2],
	((Voiceparts1=[Section2|_Voiceparts2],
	not(Section1=Section2))->true;Voiceparts1=[]),
	Bar3 is Bar1+4,
	renderv1(Form2,Voiceparts1,Vocalstubinstrument,Lyrics,Melody,
		Totallength,Track,Bar3,Bar2,Voice1,Voice2),!.

renderv2(Section,Lyrics,_Melody,_Totallength,_Track,Bar,Bar,Voice,Voice) :- 
	not(member([Section|_],Lyrics)),!.
renderv2(Section1,Lyrics1,Melody1,_Totallength0,Track,Bar1,Bar2,Voice1,Voice2) :-
	findall(Lyrics2,(member(Lyrics2,Lyrics1),
		Lyrics2=[Section1|_]),Lyrics3),
	string_concat(Section2A,_C,Section1),
	string_length(Section2A,1),
	atom_string(Section2,Section2A),
	findall(Melody2,(member(Melody2,Melody1),
	Melody2=[Section2|_]),Melody3),
		Lyrics3=[Lyrics3A1|_Lyrics5],
		%%trace,
		(Lyrics3A1=[_,Lyrics1A,Lyrics2A,Lyrics3A,Lyrics4A]->true;
		(writeln(["Error:",Lyrics3A1,"does not have 4 lines"]),abort)),
	Melody3=[[_, Melody1A], [_, Melody2A]],
	renderline1(Lyrics1A,Melody1A,_Totallength1,Track,Bar1,Voice1,Voice3),
	Bar3 is Bar1+1,
	renderline1(Lyrics2A,Melody2A,_Totallength2,Track,Bar3,Voice3,Voice4),
	Bar4 is Bar3+1,
	renderline1(Lyrics3A,Melody1A,_Totallength3,Track,Bar4,Voice4,Voice5),
	Bar5 is Bar4+1,
	renderline1(Lyrics4A,Melody2A,_Totallength4,Track,Bar5,Voice5,Voice6),
	Bar6 is Bar5+1,
	delete(Lyrics1,[Section1|_],Lyrics51),
	renderv2(Section1,Lyrics51,Melody1,_Totallength,Track,Bar6,Bar2,Voice6,Voice2).
	
renderline1(Lyrics2,Melody1,_Totallength,Track,Bar1,Voice1,Voice2) :-
	%%Lyrics1=[_,Lyrics2],
	length(Lyrics2,Lyrics2Length),
	%%Rests is Totallength-Lyrics2Length,
	rhythm(BarTimes1),%=["0","1/2","1","1+1/2","2","2+1/2","3","3+1/2"],
	generatemelody(Lyrics2Length,Melody1,Melody2),
	renderline2(BarTimes1,BarTimes2,Melody2,Track,Bar1,Voice1,Voice3),
	renderlinerests(BarTimes2,_BarTimes3,Track,Bar1,Voice3,Voice2).	

generatemelody(Lyrics2Length,Melody1,Melody2) :-
	generatemelody1(Melody1,[],Melody3),
	length(Melody3,Melody2Length),
	changelength(Lyrics2Length,Melody2Length,Melody3,Melody2).	

generatemelody1([],Melody,Melody) :- !.
generatemelody1(Melody1,Melody2,Melody3) :-
	Melody1=[Melody4|Melody5],
	append(Melody2,[Melody4%,Melody4
	],Melody6),
	generatemelody1(Melody5,Melody6,Melody3),!.

%%changelength(_Melody2Length,Melody,Melody) :- !.
changelength(Lyrics2Length,Melody2Length,Melody,Melody) :-
	Lyrics2Length=Melody2Length,!.
changelength(Lyrics2Length,Melody2Length,Melody1,Melody2) :-
	Lyrics2Length > Melody2Length,
	Length is Lyrics2Length-Melody2Length,
	repeatlastnote1(Length,Melody1,Melody2).
changelength(Lyrics2Length,Melody2Length,Melody1,Melody2) :-
	Lyrics2Length < Melody2Length,
	length(Melody2,Lyrics2Length),
	append(Melody2,_,Melody1).

repeatlastnote1(Length,Melody1,Melody2) :-
	reverse(Melody1,Melody3),
	Melody3=[Item|_],
	repeatlastnote2(Length,Item,Melody1,Melody2),!.

repeatlastnote2(0,_Item,Melody,Melody) :- !.
repeatlastnote2(Length1,Item,Melody1,Melody2) :-
	append(Melody1,[Item],Melody3),
	Length2 is Length1-1,
	repeatlastnote2(Length2,Item,Melody3,Melody2),!.

renderline2([]%BarTimes
,_BarTimes,_,_Track,_Bar1,Voice,Voice) :- !.
renderline2(BarTimes1,BarTimes4,Melody1,Track,Bar,Voice1,Voice2) :-
	BarTimes1=[BarTimes2|BarTimes3],
	BarTimes2=[Time,Type,Length,Nth_note_from_mel_harm,Velocity],
	%trace,
	((Type="NT",
	get_item_n(Melody1,Nth_note_from_mel_harm,Melody2),
	%Melody1=[Melody2|Melody3],
	concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  ",Melody2,"-           ",Length,"   von=",Velocity,"   voff=0\n"],Song))->true;
	(%Type="R",
	concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  R          ",Length,"      voff=0\n"],Song))),
	
	string_concat(Voice1,Song,Voice3),
	renderline2(BarTimes3,BarTimes4,Melody1,Track,Bar,Voice3,Voice2).

renderlinerests([]%BarTimes
,_BarTimes,_Track,_Bar1,Voice,Voice) :- !.
renderlinerests(BarTimes1,BarTimes2,Track,Bar,Voice1,Voice2) :-
	BarTimes1=[BarTimes2|BarTimes3],
	BarTimes2=[Time,_Type,Length,_Nth_note_from_mel_harm,_Velocity],
	concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  R            ",Length,"   voff=0\n"],Song),
	string_concat(Voice1,Song,Voice3),
	renderlinerests(BarTimes3,BarTimes2,Track,Bar,Voice3,Voice2).
	
longtoshortform(Section1,Section2) :-
	string_concat(Section2A,_C,Section1),
	string_length(Section2A,1),
	atom_string(Section2,Section2A),!.


renderm1(_Form1,_Melody,[],_Track1,_Track2,Song,Song) :- !.
renderm1(Form1,Melody,MelodyParts1,Track1,Track2,Song1,Song2) :-
	%%length(Form1,FormLength),
	MelodyParts1=[MelodyParts2|MelodyParts3],
	MelodyParts2=[[_A,[InstrumentNumber1,_B],_C]|_D],
	InstrumentNumber2 is InstrumentNumber1,%% + 1,
	printheader(Track1,[InstrumentNumber2,_],Song1,Song3),
	%%renderm21(Form1,Melody,MelodyParts1,Track1,1,_,Song3,Song4),
	renderm21(Form1,Melody,MelodyParts2,Track1,1,_E,Song3,Song4),
	Track3 is Track1+1,
	renderm1(Form1,Melody,MelodyParts3,Track3,Track2,Song4,Song2),!.


renderm21(_Form1,_Melody,[],_Track,Bar,Bar,Voice,Voice) :- !.
renderm21(Form1,Melody,MelodyParts1,Track,Bar1,Bar2,Voice1,Voice2) :-
	MelodyParts1=[MelodyPart2|MelodyParts3],
		MelodyPart2=[Section1,[_,_],1],
	longtoshortform(Section1,Section2),
	renderm22(Section2,Melody,Track,Bar1,Bar3,Voice1,Voice3),
	renderm21(Form1,Melody,MelodyParts3,Track,Bar3,Bar2,Voice3,Voice2),!.

renderm21(Form1,Melody,MelodyParts1,Track,Bar1,Bar2,Voice1,Voice2) :-
	MelodyParts1=[MelodyPart2|MelodyParts3],
		MelodyPart2=[_Section,[_,_],0],
	Bar3 is Bar1+4,
	renderm21(Form1,Melody,MelodyParts3,Track,Bar3,Bar2,Voice1,Voice2),!.

renderm22(Section2,Melody1,_Track,Bar,Bar,Voice,Voice) :- 
	findall(Melody2,(member(Melody2,Melody1),
		Melody2=[Section1|_],longtoshortform(Section1,Section2)),List2),List2=[],!.
renderm22(Section1,Melody1,Track,Bar1,Bar2,Voice1,Voice2) :-
	/**
	findall(Lyrics2,(member(Lyrics2,Lyrics1),
		Lyrics2=[Section1|_]),Lyrics3),
	string_concat(Section2A,_C,Section1),
	string_length(Section2A,1),
	atom_string(Section2,Section2A),
	**/
	findall(Melody2,(member(Melody2,Melody1),
	Melody2=[Section1|_]),Melody3),
		%%Lyrics3=[[_, Lyrics1A,Lyrics2A,Lyrics3A,Lyrics4A]],
	Melody3=[[_, Melody1A], [_, Melody2A]],
	renderline1m(Melody1A,Track,Bar1,Voice1,Voice3),
	Bar3 is Bar1+1,
	renderline1m(Melody2A,Track,Bar3,Voice3,Voice4),
	Bar4 is Bar3+1,
	renderline1m(Melody1A,Track,Bar4,Voice4,Voice5),
	Bar5 is Bar4+1,
	renderline1m(Melody2A,Track,Bar5,Voice5,Voice6),
	Bar6 is Bar5+1,
	delete(Melody3,[Section1|_],Melody5),
	renderm22(Section1,Melody5,Track,Bar6,Bar2,Voice6,Voice2).
	
renderline1m(Melody1,Track,Bar1,Voice1,Voice2) :-
	%%Lyrics1=[_,Lyrics2],
	%%Rests is Totallength-Lyrics2Length,
	rhythm(BarTimes1),%BarTimes1=["0","1/2","1","1+1/2","2","2+1/2","3","3+1/2"],
	generatemelodym(Melody1,Melody2),
	renderline2(BarTimes1,BarTimes2,Melody2,Track,Bar1,Voice1,Voice3),
	renderlinerests(BarTimes2,_BarTimes3,Track,Bar1,Voice3,Voice2).	

generatemelodym(Melody1,Melody2) :-
	generatemelody1(Melody1,[],Melody3),
	length(Melody3,Melody2Length),
	Lyrics2Length=8,
	changelength(Lyrics2Length,Melody2Length,Melody3,Melody2).	
		
renderh1(_Form1,_Harmony,[],_Track1,_Track2,Song,Song) :- !.
renderh1(Form1,Harmony,HarmonyParts1,Track1,Track2,Song1,Song2) :-
	%%length(Form1,FormLength),
	HarmonyParts1=[HarmonyParts2|HarmonyParts3],
	HarmonyParts2=[[_A,[InstrumentNumber1,_B],_C]|_D],
	InstrumentNumber2 is InstrumentNumber1,%% + 1,
	printheader(Track1,[InstrumentNumber2,_],Song1,Song3),
	%%renderh21(Form1,Harmony,HarmonyParts1,Track1,1,_,Song3,Song4),
	renderh21(Form1,Harmony,HarmonyParts2,Track1,1,_E,Song3,Song4),
	Track3 is Track1+1,
	renderh1(Form1,Harmony,HarmonyParts3,Track3,Track2,Song4,Song2),!.


renderh21(_Form1,_Harmony,[],_Track,Bar,Bar,Voice,Voice) :- !.
renderh21(Form1,Harmony,HarmonyParts1,Track,Bar1,Bar2,Voice1,Voice2) :-
	HarmonyParts1=[HarmonyPart2|HarmonyParts3],
		HarmonyPart2=[Section1,[_,_],1],
	longtoshortform(Section1,Section2),
	renderh22(Section2,Harmony,Track,Bar1,Bar3,Voice1,Voice3),
	renderh22(Section2,Harmony,Track,Bar3,Bar4,Voice3,Voice4),
	renderh21(Form1,Harmony,HarmonyParts3,Track,Bar4,Bar2,Voice4,Voice2),!.

renderh21(Form1,Harmony,HarmonyParts1,Track,Bar1,Bar2,Voice1,Voice2) :-
	HarmonyParts1=[HarmonyPart2|HarmonyParts3],
		HarmonyPart2=[_Section,[_,_],0],
	Bar3 is Bar1+4,
	renderh21(Form1,Harmony,HarmonyParts3,Track,Bar3,Bar2,Voice1,Voice2),!.

renderh22(Section2,Harmony1,_Track,Bar,Bar,Voice,Voice) :- 
	
	%%longtoshortform(Section21,Section2),
	findall(Harmony2,(member(Harmony3,Harmony1),member(Harmony2,Harmony3),
		Harmony2=[Section1|_],longtoshortform(Section1,Section2)),List2),List2=[],!.
renderh22(Section1,Harmony1A,Track,Bar1,Bar2,Voice1,Voice2) :-
	Harmony1A=[Harmony1A1|Harmony1A2],
	/**
	findall(Lyrics2,(member(Lyrics2,Lyrics1),
		Lyrics2=[Section1|_]),Lyrics3),
	string_concat(Section2A,_C,Section1),
	string_length(Section2A,1),
	atom_string(Section2,Section2A),
	**/
	
		%% shorten
	%%string_concat(B11,_C1,Section11),
	%%string_length(B11,1),atom_string(Section1,B11),


	
	findall(Harmony2,(member(Harmony2,Harmony1A1),
	Harmony2=[Section1|_]
	%%,string_concat(B1,_C,Section1A),
	%%string_length(B1,1),atom_string(Section1,B1)
	),Harmony3),
		%% shorten


	
	(not(Harmony3=[])->
		%%Lyrics3=[[_, Lyrics1A,Lyrics2A,Lyrics3A,Lyrics4A]],
	%%Harmony3=[[_, Harmony1A], [_, Harmony2A]],
	(renderlines1h(Harmony3,Track,Bar1,Voice1,Voice3),
	Bar3 is Bar1+1);(Bar3 is Bar1,Voice3=Voice1)),
	/**
	Bar3 is Bar1+1,
	renderline1h(Harmony2A,Track,Bar3,Voice3,Voice4),
	Bar4 is Bar3+1,
	renderline1h(Harmony1A,Track,Bar4,Voice4,Voice5),
	Bar5 is Bar4+1,
	renderline1h(Harmony2A,Track,Bar5,Voice5,Voice6),
	Bar6 is Bar5+1,
	**/
	%%delete(Harmony3,[Section1|_],Harmony5),
	renderh22(Section1,Harmony1A2,Track,Bar3,Bar2,Voice3,Voice2).

renderlines1h([],_Track,_Bar,Voice,Voice) :- !.
renderlines1h(Harmony1,Track,Bar1,Voice1,Voice2) :-
	%%Lyrics1=[_,Lyrics2],
	%%Rests is Totallength-Lyrics2Length,
	rhythm(BarTimes1),%BarTimes1=["0","1/2","1","1+1/2","2","2+1/2","3","3+1/2"],
	generatemelodyh(Harmony1,Harmony2),
%%writeln(generatemelodyh(Harmony1,Harmony2)),
	renderlineh2(BarTimes1,BarTimes2,Harmony2,Track,Bar1,Voice1,Voice3),
	renderlinerests(BarTimes2,_BarTimes3,Track,Bar1,Voice3,Voice2).	

generatemelodyh(Harmony1,Harmony2) :-
	generatemelodyh1(Harmony1,[],Harmony3),
	length(Harmony3,Harmony2Length),
	Lyrics2Length=8,
	changelengthh(Lyrics2Length,Harmony2Length,
		Harmony3,Harmony2).	
		
generatemelodyh1([],Melody,Melody) :- !.
generatemelodyh1(Melody1,Melody2,Melody3) :-
	Melody1=[Melody4|Melody5],
	append(Melody2,[Melody4%,Melody4
	],Melody6),
	generatemelodyh1(Melody5,Melody6,Melody3),!.

%%changelengthh(_Melody2Length,Melody,Melody) :- !.
changelengthh(Lyrics2Length,Melody2Length,Melody,Melody) :-
	Lyrics2Length=Melody2Length,!.
changelengthh(Lyrics2Length,Melody2Length,Melody1,Melody2) :-
	Lyrics2Length > Melody2Length,
	Length is Lyrics2Length-Melody2Length,
	repeatlastnoteh1(Length,Melody1,Melody2).
changelengthh(Lyrics2Length,Melody2Length,Melody1,Melody2) :-
	Lyrics2Length < Melody2Length,
	length(Melody2,Lyrics2Length),
	append(Melody2,_,Melody1).

repeatlastnoteh1(Length,Melody1,Melody2) :-
	reverse(Melody1,Melody3),
	Melody3=[Item|_],
	repeatlastnoteh2(Length,Item,Melody1,Melody2),!.

repeatlastnoteh2(0,_Item,Melody,Melody) :- !.
repeatlastnoteh2(Length1,Item,Melody1,Melody2) :-
	append(Melody1,[Item],Melody3),
	Length2 is Length1-1,
	repeatlastnoteh2(Length2,Item,Melody3,Melody2),!.

renderlineh2([]%BarTimes
,_BarTimes,_%[]
,_Track,_Bar1,Voice,Voice) :- !.
renderlineh2(BarTimes1,BarTimes4,Melody1,Track,Bar,Voice1,Voice2) :-
	%Melody1=[Melody2|Melody3],
	%Melody2=[_,[Melody21,Melody22,Melody23]],
	BarTimes1=[BarTimes2|BarTimes3],


	BarTimes2=[Time,Type,Length,Nth_note_from_mel_harm,Velocity],
	((Type="NT",
	get_item_n(Melody1,Nth_note_from_mel_harm,Melody2),
	Melody2=[_,[Melody21,Melody22,Melody23]],
	%Melody1=[Melody2|Melody3],
	%concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  ",Melody2,"-           ",Length,"   von=",Velocity,"   voff=0\n"],Song));


	concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  ",Melody21,"-           ",Length,"   von=",Velocity," voff=0\n"],Song1),	
	concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  ",Melody22,"-           ",Length,"   von=",Velocity," voff=0\n"],Song2),	
	concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  ",Melody23,"-           ",Length,"   von=",Velocity," voff=0\n"],Song3))->true;
	
	(%Type="R",
	%get_item_n(Melody1,Nth_note_from_mel_harm,Melody2),
	%Melody2=[_,[Melody21,Melody22,Melody23]],
	%Melody1=[Melody2|Melody3],
	%concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  ",Melody2,"-           ",Length,"   von=",Velocity,"   voff=0\n"],Song));


	concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  R           ",Length,"    voff=0\n"],Song1),	
	concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  R           ",Length,"    voff=0\n"],Song2),	
	concat_list("BA    ",[Bar,"   CR         ",Time,"   TR  ",Track,"   CH  ",Track,"   NT  R           ",Length,"    voff=0\n"],Song3))),
		
	concat_list(Voice1,[Song1,Song2,Song3],Voice3),
	renderlineh2(BarTimes3,BarTimes4,Melody1,Track,Bar,Voice3,Voice2).

outputlyrics(File1,Lyrics1) :-
	Lyrics1=[Lyrics2|_Lyrics3],
	Lyrics2=[_|Lyrics4],
	Lyrics4=[Lyrics5|_Lyrics6],
	sentencewithspaces(Lyrics5,Lyrics7A),
	string_concat(Lyrics7A,"\n\n",Lyrics7),
	outputlyrics1(Lyrics1,Lyrics7,Lyrics8),
	concat_list(File1,["lyrics.txt"],File2),
	open_s(File2,write,Stream),
	write(Stream,Lyrics8),
 	close(Stream).
%%texttobr2(u,File2,u,u),texttobr(u,File2,u,u).
 	%%writeln(["Texttobr, Texttobr2 not working.  Please manually breason out ",File2]).

outputlyrics1([],Lyrics,Lyrics) :- !.
outputlyrics1(Lyrics1,Lyrics5,Lyrics6) :-
	Lyrics1=[Lyrics2|Lyrics3],
	Lyrics2=[_|Lyrics4],
	outputlyrics2(Lyrics4,Lyrics5,Lyrics7),
	string_concat(Lyrics7,"\n",Lyrics8),
	outputlyrics1(Lyrics3,Lyrics8,Lyrics6).

outputlyrics2([],Lyrics,Lyrics) :- !.
outputlyrics2(Lyrics1,Lyrics5,Lyrics6) :-
	Lyrics1=[Lyrics2|Lyrics3],
	sentencewithspaces(Lyrics2,Lyrics4),
	%%writeln(Lyrics4),
	concat_list(Lyrics5,[Lyrics4,"\n"],Lyrics7),
	outputlyrics2(Lyrics3,Lyrics7,Lyrics6).

max([],M,M) :- !.
max(List1,Max1,Max2) :-
	List1=[Item|List2],
	Item>=Max1,
	max(List2,Item,Max2),!.
max(List1,Max1,Max2) :-
	List1=[Item|List2],
	Item<Max1,
	max(List2,Max1,Max2),!.
	
	
findbest(R,Item):-
	sort(R,RA),
	reverse(RA,RB),
	RB=[[_,Item]|_Rest].

find("decimal",Item1) :-
	trialy2([0,1,2,3,4,5,6,7,8,9],R), %% 0 is 0->1 etc.
	findbest(R,Item1).

find("Should a chorus or instrumental come after the first verse?",CorI) :-
	trialy2([c,i1],R),
	findbest(R,CorI).

find(["Should a chorus and outro or two solos come after the first solo?",1],COorSS) :-
	trialy2([[c,o],[s,s]],R),
	findbest(R,COorSS).

find(["Should a chorus and outro or two solos come after the first solo?",2],COorSS) :-
	trialy2([[c,o],[s,s]],R),
	findbest(R,COorSS).

%%find("Who is the song about?",Character) :-
%%	trialy2(["Ma","til","da"],["Jo","se","phine"],["Hap","py"],["Ha","rold"],R),
%%	findbest(R,Character).

find("Should the chord progression type be 1451, 1564, 1645, Classical or Classical Pop?",CPT) :-
	trialy2([1451, 1564, 1645
	%%
	, classical, classicalpop
	],R),
	findbest(R,CPT).

/**generatelyricslistsverse(Character,Lyrics1,Lyrics2):-
%% read c, o, v
 reado(Objects),
 readv(Verbs),
 
	charobj( %% character verb object  first
	%% object verb object pairs

lyrics1([],_Character,Lyrics,Lyrics) :- !.
lyrics1(Form1,Character,Lyrics1,Lyrics2) :-
	Form1=[Form2|Forms2],
	lyrics2(Form2,Character,Lyrics1,Lyrics3),

lyrics2([instrumental,_],_Character,Lyrics1,Lyrics2) :-

append_list(Lyrics1,[[],[],[],[]],Lyrics2).
lyrics2([verse,_],Character,Lyrics1,Lyrics2) :-
	lyricsv1(Lyrics1,[Character],Lyrics3),
	append_list(Lyrics1,[Lyrics3,*],Lyrics2),
	.
	
lyricsv1(Lyrics0,Lyrics1,Lyrics2) :-
	readsc(SyllableCount),
	readv(Verbs1),

reado(Objects1),
	**/
%%removetoolongandnotrhyming(Lyrics0,Lyrics1,SyllableCount,Verbs1,Verbs2,Objects1,Objects2),]
%%findv
%% same for o
%%	findo
	%% choose words that fit syllable count

append_list(A,[],A) :-!.
append_list(A,List,B) :-
	List=[Item|Items],
	append2(A,[Item],C),
	append_list(C,Items,B).
append2(A,List,C) :-
	(List=[Item]->
	append(A,Item,C);
	fail),!.
append2(A,Item,C) :-
	append_list(A,Item,C),!.

readsc(7).
readv([["loves"],["is"],["has"],["is","in"],["moves","to"],["nur","tures"],["needs"],["makes"],["lifts"],["finds"],["forms"],["goes","to"],["writes","on"],["reads","on"],["feels"],["is"]]).

reado([["one"],["the","oth","er"],["the","runn","er"],["the","draw","er"],["the","count","er"],["the","graph","er"],["the","test","er"],["the","breaths","on","er"],["the","writ","er"],["the","spell","er"],["the","updat","er"],["the","check","er"],["the","choos","er"],["the","ess","ence"],["the","comb","in","er"],["the","mir","ac","le"],["the","trans","lat","or"],["the","gramm","ar"]]).

rhymes([["one","er","or","ar","an","ae","er","ler","ur","ard","ney","ald","ess","el"],["le","py","ye","ee","ice"]]).

%%removetoolongandnotrhyming(Lyrics1,SyllableCount,[],Verbs,Verbs) :- !.
/**removetoolongandnotrhyming(Lyrics0,Lyrics1,SyllableCount,Verbs1,Verbs2,Objects1,Objects2) :-
%% makes list of all combos, checks, asks, asks
	removetoolong1(Lyrics1,SyllableCount,
	Verbs1,[],Verbs3), %% do after end
	* %% not until object
	%% find v x
	removenotrhyming1(Lyrics0,Verbs3,
	Verbs4),

			removetoolong1(Lyrics1,SyllableCount,[],Verbs,Verbs) :- !.%*
			removetoolong1(Lyrics1,SyllableCount,Verbs1,Verbs2,Verbs3) :-
	Verbs1=[Verb4|Verbs5],
	append_list(Lyrics1,Verb4,Lyrics2),
	length(Lyrics2,Length),
	(Length<=SyllableCount->(append(Verbs2,	[Verb4],Verbs6),		removetoolong1(Lyrics1,SyllableCount,Verbs5,Verbs6,Verbs3));(removetoolong1(Lyrics1,SyllableCount,Verbs5,Verbs2,Verbs3))).

removenotrhyming1(Lyrics,Verbs1,Verbs2) :-
	rhymes(Rhymes1)
	length(Lyrics,Length),
	Line1 is mod(Length,4),
	(Line1 is 3-1->
		(Line2 is 3-2,
		removenotrhyming15(Line2,Rhymes1,
		Rhymes3),
		removenotrhyming2(Rhymes3,
		Verbs1,[],Verbs2));
	(Line1 is 4-1->
		(removenotrhyming15(Line2,Rhymes1,
		Rhymes3),
		removenotrhyming2(Rhymes3,
		Verbs1,[],Verbs2));Verbs1=Verbs2)
	).
	
removenotrhyming15(Line2,Rhymes1,Rhymes3) :-
	length(List1,Line2),
		append(List1,_,Lyrics),
		reverse(List1,List2),
		List2=[Item1|_Items2],
		reverse(Item1,Item2),
		Item2=[Item3|_Items4],
		member(Rhymes2,Rhymes1),
		member(Item3,Rhymes2),
		delete(Rhymes2,Item3,Rhymes3)
		
removenotrhyming2(_Rhymes3,[],Verbs,Verbs) :- !.
removenotrhyming2(Rhymes3,Verbs1,Verbs2,Verbs3) :-
	(Verbs1=[Verb4|Verbs5],
	(member(Verb4,Rhymes3)
	delete(Rhymes3,Verb4,Rhymes4))
	->(append(Verbs2,[Verb4],Verbs6),
	removenotrhyming2(Rhymes4,Verbs5,
	Verbs6,Verbs3));
	removenotrhyming2(Rhymes3,Verbs5,
	Verbs2,Verbs3)).
	**/
trialy2([],R) :-
	R=[[_,['C']]].
	%%writeln([[],in,trialy2]),abort.
trialy2(Question,List,R) :-
	%%random_member(A,List),
	term_to_atom(List,List1),
	repeat,
	writeln([Question,%%"Please enter an item from:",
		List1]),
	read_string(user_input, "\n", "\r", _End2, A1),
	atom_to_term(A1,A,_),
	%%((number_string(A,A1)->true;atom_string(A,A1))->true;,
	member(A,List),
	R=[[_,A]].
	
concat_list(A,[],A):-!.
concat_list(A,List,B) :-
	List=[Item|Items],
	string_concat(A,Item,C),
	concat_list(C,Items,B).

remove_dups([],List,List) :- !.
remove_dups(List1,List2,List3) :-
	List1=[Item|List4],
	delete(List4,Item,List5),
	append(List2,[Item],List6),
	remove_dups(List5,List6,List3),!.
	
shell1(Command) :-
				(bash_command(Command,_)->
					true;
					(writeln(["Failed shell1 command: ",Command]),abort)
				),!.

bash_command(Command, Output) :-
        setup_call_cleanup(process_create(path(bash),
                ['-c', Command],
                [stdout(pipe(Out))]),
        read_string(Out, _, Output),
        close(Out)).

