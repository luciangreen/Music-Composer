%%use_module(library(pio)).

%%:- use_module(library(date)).
%%:- include('texttobr2qb').
%%:- include('mindreadtestshared').

:- include('musiclibrary').
%%:- include('1451').
:- include('1564').
:- include('1645').
:- include('popclassical').
:- include('classical').

%% *** remember mindreadtest prep 28 t2b2.txt

sectest0(Form1,Lyrics,Melody,Harmony) :-
	%%get_time(TS),stamp_date_time(TS,date(_Year,Month,Day,_Hour1,_Minute1,_Seconda,_A,_TZ,_False),local),
	form(Form1),
	find("Should the chord progression type be 1564, 1645, Classical or Classical Pop?",CPT),
	remove_dups(Form1,[],Form2),
	Voiceparts=[v1,v2,c,s],
	lyrics(Voiceparts,Lyrics,Maxlength),
	findall(B,(member(A1,Form2),string_concat(B,_C,A1),string_length(B,1)),Form3),
	remove_dups(Form3,[],Form4),
	melodyharmony(Form4,CPT,Maxlength,Melody,Harmony),!
	/**instruments(Form1,MelodyParts,HarmonyParts,Vocalstubinstrument),
	rendersong(Form1,Voiceparts,Maxlength,Melody,Harmony,MelodyParts,
		HarmonyParts,Lyrics,Vocalstubinstrument,Song1),
	outputlyrics(Lyrics)**/
	.
	
%% n intro, vn verse, c chorus, i1 instrumental1, t2, instrumental 2, s solo, o outro

form(Form) :-
	Form1=[n,v1],
	find("Should a chorus or instrumental come after the first verse?",CorI),
	(CorI=c->
	(append(Form1,[i1,v2,c,t2,s],Form2),
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
	trialy2(["Ac","Luc","Adr","All","Brae","Skye","Whistl","Dix","Wilb","Duk","Le","Ven",
	"Sydn","Don","Count","Black","Nei"],R1),
	findbest(R1,N1),
	trialy2(["an","ae","ye","er","ie","ur","e","ard","ice","ey","ald","ess",
	"l"],R2),
	findbest(R2,N2),
	append([N1],[N2],N3).

makenames(0,Ns,Ns) :- !.
makenames(Num1,N1,N2) :-
	random_member(R1,["Ac","Luc","Adr","All","Brae","Skye","Whistl","Dix","Wilb","Duk","Le","Ven",
	"Sydn","Don","Count","Black","Nei"]),
	random_member(R2,["an","ae","ye","er","ie","ur","e","ard","ice","ey","ald","ess",
	"l"]),
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
	%%repeat,
	%%find("Who is the song about?",Character),
	%%lyrics1(Form,Character,[],Lyrics).
	lyrics2(Form1,[],Lyrics,[],_Names,0,Maxlength).

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
	(CPT=1451->findall(A,note0(_,A),Notes);
	findall(A,note(_,A),Notes)),
	%% What note should the song start on?
	trialy2(Notes,R1),
	findbest(R1,R11),
	melodyharmony(Form1,CPT,_Parts2,R11,_R2,[],Melody,[],Harmony).
	
melodyharmony([],_CPT,_Parts,N,N,Melody,Melody,Harmony,Harmony) :- !.
melodyharmony(Form1,CPT,Parts,N1,N2,Melody1,Melody2,Harmony1,Harmony2) :-
	Form1=[Form2|Forms3],
	findmelody(Form2,CPT,Parts,N1,N3,Melody1,Melody3,Harmony1,Harmony3),
	(CPT=1451->harmony1451(N3,3,N4);harmonyr(N3,5,N4)),
	findmelody(Form2,CPT,Parts,N4,N5,Melody3,Melody4,Harmony3,Harmony4),
	melodyharmony(Forms3,CPT,Parts,N5,N2,Melody4,Melody2,Harmony4,Harmony2).

findmelody(Form,CPT,_Parts,N1,N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT=1451,
	(CPT=1451->findall(A,note0(_,A),Notes);
	findall(A,note(_,A),Notes)),
	%% What note should the phrase end on?
	trialy2(Notes,R1),
	findbest(R1,N2),
	chorussoloprogression1451(N1,N2,Progression),
	trialy2(Progression,R2),
	findbest(R2,Progression2),
	append(Melody1,[[Form,Progression2]],Melody2),
	chorussoloprogression1451(N1,N2,Progression3),
	trialy2(Progression3,R3),
	findbest(R3,Progression4),
	harmony(Form,CPT,Progression4,Harmony1,Harmony2).	
findmelody(Form,CPT,_Parts,N1,N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT=1564,
	(CPT=1451->findall(A,note0(_,A),Notes);
	findall(A,note(_,A),Notes)),
	%% What note should the phrase end on?
	trialy2(Notes,R1),
	findbest(R1,N2),
	versechorussoloprogression1564(N1,N2,Progression),
	trialy2(Progression,R2),
	findbest(R2,Progression2),
	append(Melody1,[[Form,Progression2]],Melody2),
	versechorussoloprogression1564(N1,N2,Progression3),
	trialy2(Progression3,R3),
	findbest(R3,Progression4),
	harmony(Form,CPT,Progression4,Harmony1,Harmony2).
findmelody(Form,CPT,_Parts,N1,N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT=1645,
	(CPT=1451->findall(A,note0(_,A),Notes);
	findall(A,note(_,A),Notes)),
	%% What note should the phrase end on?
	trialy2(Notes,R1),
	findbest(R1,N2),
	versechorussoloprogression1645(N1,N2,Progression),
	trialy2(Progression,R2),
	findbest(R2,Progression2),
	append(Melody1,[[Form,Progression2]],Melody2),
	versechorussoloprogression1645(N1,N2,Progression3),
	trialy2(Progression3,R3),
	findbest(R3,Progression4),
	harmony(Form,CPT,Progression4,Harmony1,Harmony2).
findmelody(Form,CPT,_Parts,N1,N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT=classical,
	(CPT=1451->findall(A,note0(_,A),Notes);
	findall(A,note(_,A),Notes)),
	%% What note should the phrase end on?
	trialy2(Notes,R1),
	findbest(R1,N2),
	classicalcomposition(N1,N2,Progression),
	trialy2(Progression,R2),
	findbest(R2,Progression2),
	append(Melody1,[[Form,Progression2]],Melody2),
	classicalcomposition(N1,N2,Progression3),
	trialy2(Progression3,R3),
	findbest(R3,Progression4),
	harmony(Form,CPT,Progression4,Harmony1,Harmony2).
findmelody(Form,CPT,_Parts,N1,N2,Melody1,Melody2,Harmony1,Harmony2) :-
	CPT=classicalpop,
	(CPT=1451->findall(A,note0(_,A),Notes);
	findall(A,note(_,A),Notes)),
	%%repeat,
	%% What note should the phrase end on?
	trialy2(Notes,R1),
	findbest(R1,N2),
	popclassicalcomposition(N1,N2,Progression),
	trialy2(Progression,R2),
	findbest(R2,Progression2),
	append(Melody1,[[Form,Progression2]],Melody2),
	popclassicalcomposition(N1,N2,Progression3),
	trialy2(Progression3,R3),
	findbest(R3,Progression4),
	harmony(Form,CPT,Progression4,Harmony1,Harmony2).

harmony(Form,CPT,Progression,Harmony1,Harmony2) :-
	harmony1(Form,CPT,Progression,[],Harmony3),
	append(Harmony1,[Harmony3],Harmony2).
	
harmony1(_Form,_CPT,[],Harmony,Harmony) :- !.
harmony1(Form,CPT,Progression1,Harmony1,Harmony2) :-
	Progression1=[Note1|Progression2],
	(CPT=1451->(harmony1451(Note1,2,Note2),harmony1451(Note1,4,Note3));
	(harmonyr(Note1,4,Note2),harmonyr(Note1,7,Note3))),
	Harmony30=[Note2,Note3],
	findall(B,(member(A1,Harmony30),string_concat(B,_C,A1),string_length(B,1)),Harmony31),
	append([Note1],Harmony31,Harmony3),
	append(Harmony1,[[Form,Harmony3]],Harmony4),
	harmony1(Form,CPT,Progression2,Harmony4,Harmony2),!.
	
harmony1451(Note1,Value2,Note2) :-
	note0(Value1,Note1),Value3 is Value1+Value2,Value4 is Value3 mod 12,note0(Value4,Note2).
harmonyr(Note1,Value2,Note2) :-
	note(Value1,Note1),Value3 is Value1+Value2,Value4 is Value3 mod 12,note(Value4,Note2).
/**
instruments(Form1,MelodyParts,HarmonyParts,Vocalstubinstrument) :-
	instrumentnumber(MelodyInstrumentNumber),
	instrumentnumber(HarmonyInstrumentNumber),
	instrumentlist(MelodyInstrumentNumber,MelodyInstruments),
	instrumentlist(HarmonyInstrumentNumber,HarmonyInstruments),
	Vocalstubinstrument=[0,"Acoustic Grand Piano"],
	parts(Form1,MelodyInstruments,MelodyParts),
	parts(Form1,HarmonyInstruments,HarmonyParts).	
	
instrumentnumber(NumberofInstruments) :-
	%% Number of melody instruments
	trialy2([1,2,3],R1),
	findbest(R1,NumberofInstruments).
	
instrumentlist(NumberofInstruments,Instruments) :-
	instrumentlist(NumberofInstruments,[],Instruments),!.

instrumentlist(0,Instruments,Instruments) :- !.
instrumentlist(NumberofInstruments1,Instruments1,Instruments2) :-
	Instruments=[[0,"Acoustic Grand Piano"],[1,"Bright Acoustic Piano"],[2,"Electric Grand Piano"],[3,"Honky-Tonk Piano"],[4,"Electric Piano 1"],[5,"Electric Piano 2"],[6,"Harpsichord"],[7,"Clavinet"],[8,"Celesta"],[9,"Glockenspiel"],[10,"Music Box"],[11,"Vibraphone"],[12,"Marimba"],[13,"Xylophone"],[14,"Tubular Bells"],[15,"Dulcimer"],[16,"Drawbar Organ"],[17,"Percussive Organ"],[18,"Rock Organ"],[19,"Church Organ"],[20,"Reed Organ"],[21,"Accordian"],[22,"Harmonica"],[23,"Tango Accordian"],[24,"Nylon Acoustic Guitar"],[25,"Steel Acoustic Guitar"],[26,"Jazz Electric Guitar"],[27,"Clean Electric Guitar"],[28,"Muted Electric Guitar"],[29,"Overdriven Guitar"],[30,"Distortion Guitar"],[31,"Guitar Harmonics"],[32,"Acoustic Bass"],[33,"Electric Bass (finger)"],[34,"Electric Bass (pick)"],[35,"Fretless Bass"],[36,"Slap Bass 1"],[37,"Slap Bass 2"],[38,"Synth Bass 1"],[39,"Synth Bass 2"],[40,"Violin"],[41,"Viola"],[42,"Cello"],[43,"Contrabass"],[44,"Tremolo Strings"],[45,"Pizzicato Strings"],[46,"Orchestral Harp"],[47,"Timpani"],[48,"String Ensemble 1"],[49,"String Ensemble 2"],[50,"Synth Strings 1"],[51,"Synth Strings 2"],[52,"Choir Aahs"],[53,"Voice Oohs"],[54,"Synth Choir"],[55,"Orchestra Hit"],[56,"Trumpet"],[57,"Trombone"],[58,"Tuba"],[59,"Muted Trumpet"],[60,"French Horn"],[61,"Brass Section"],[62,"Synth Brass 1"],[63,"Synth Brass 2"],[64,"Soprano Sax"],[65,"Alto Sax"],[66,"Tenor Sax"],[67,"Baritone Sax"],[68,"Oboe"],[69,"English Horn"],[70,"Bassoon"],[71,"Clarinet"],[72,"Piccolo"],[73,"Flute"],[74,"Recorder"],[75,"Pan Flute"],[76,"Blown Bottle"],[77,"Shakuhachi"],[78,"Whistle"],[79,"Ocarina"],[80,"Lead 1 (square)"],[81,"Lead 2 (sawtooth)"],[82,"Lead 3 (calliope)"],[83,"Lead 4 (chiff)"],[84,"Lead 5 (charang)"],[85,"Lead 6 (voice)"],[86,"Lead 7 (fifths)"],[87,"Lead 8 (bass + lead)"],[88,"Pad 1 (new age)"],[89,"Pad 2 (warm)"],[90,"Pad 3 (polysynth)"],[91,"Pad 4 (choir)"],[92,"Pad 5 (bowed)"],[93,"Pad 6 (metallic)"],[94,"Pad 7 (halo)"],[95,"Pad 8 (sweep)"],[96,"FX 1 (rain)"],[97,"FX 2 (soundtrack)"],[98,"FX 3 (crystal)"],[99,"FX 4 (atmosphere)"],[100,"FX 5 (brightness)"],[101,"FX 6 (goblins)"],[102,"FX 7 (echoes)"],[103,"FX 8 (sci-fi)"],[104,"Sitar"],[105,"Banjo"],[106,"Shamisen"],[107,"Koto"],[108,"Kalimba"],[109,"Bagpipe"],[110,"Fiddle"],[111,"Shanai"],[112,"Tinkle Bell"],[113,"Agogo"],[114,"Steel Drums"],[115,"Woodblock"],[116,"Taiko Drum"],[117,"Melodic Tom"],[118,"Synth Drum"],[119,"Reverse Cymbal"],[120,"Guitar Fret Noise"],[121,"Breath Noise"],[122,"Seashore"],[123,"Bird Tweet"],[124,"Telephone Ring"],[125,"Helicopter"],[126,"Applause"],[127,"Gunshot"]],
	trialy2(Instruments,R1),
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
	%% Is the instrument playing in the section?
	trialy2([0,1],R1),
	findbest(R1,Playing),
	append(Part1,[[Section,Instrument,Playing]],Part3),
	parts2(Form2,Instrument,Part3,Part2),!.

concat_list(A,[],A):-!.
concat_list(A,List,B) :-
	List=[Item|Items],
	string_concat(A,Item,C),
	concat_list(C,Items,B).

sentencewithspaces(Sentence1,Sentence2) :-
	Sentence1=[Item|Items],
	string_concat(Firstletter,Rest,Item),string_length(Firstletter,1),
	upcase_atom(Firstletter1,Firstletter2),
	concat_list(Firstletter2,[Rest,""],Item2),
	sentencewithspaces(Sentence1,[Item2],Sentence3),
	string_concat(Sentence3,".",Sentence2).

sentencewithspaces([],Sentence,Sentence) :- !.
sentencewithspaces(Sentence1,Sentence2,Sentence3) :-
	Sentence1=[Word|Sentence4]),
	concat_list(Sentence2,[" ",Word],Item2),
	sentencewithspaces(Sentence4,Item2,Sentence3),!.

rendersong(Form1,Voiceparts,Maxlength,Melody,Harmony,MelodyParts,
	HarmonyParts,Lyrics,Vocalstubinstrument,Song1) :-
	Totallength=8,
	Voicetrack=0,
	length(MelodyParts,MelodyPartsLength),
	length(HarmonyParts,HarmonyPartsLength),
	TracksNumber is MelodyPartsLength+HarmonyPartsLength+1,
	Lyrics=[[_,Sentence1|_]_],sentencewithspaces(Sentence1,Sentence2),
	concat_list("format=1 tracks=",[TracksNumber," division=384\n\nBA    1   CR         0   TR  0   CH 16   Text type 2: \"Produced by Mind Reading Music Composer by Lucian Academy\"\nBA    1   CR         0   TR  0   CH 16   Text type 3: \"",Sentence2,"\"\nBA    1   CR         0   TR  0   CH  1   Channel volume 127\nBA    1   CR         0   TR  0   CH 16   Tempo 63.00009\n"],Song2),
%% /n
	printheader(Voicetrack,Vocalstubinstrument,Song2,Song3),
	renderv1(Form1,Voiceparts,Lyrics,Melody,Totallength,Voicetrack,1,_,[],Voice),

printheader(Voicetrack,Vocalstubinstrument,Song2,Song3) :-
	Vocalstubinstrument=[N1,_],
	N2 is N1+1,
	concat_list("BA    1   CR         0   TR  ",[Voicetrack,"   CH  1   Instrument ",N2,"\nBA    1   CR         0   TR  ",Voicetrack,"   CH  1   NT  R            0   von=127   voff=0"],Song3).

renderv1([],_Voiceparts,_Vocalstubinstrument,_Lyrics,_Melody,_Totallength,_Track,_Bar,Voice,Voice) :- !.
renderv1(Form1,Voiceparts1,Vocalstubinstrument,Lyrics,Melody,Totallength,Track,Bar1,Bar2,Voice1,Voice2) :-
	Form1=[Section|Form2],
	Voiceparts1=[Section|Voiceparts2],
	renderv2(Section,Lyrics,Melody,Totallength,Track,Bar1,Bar2,Voice1,Voice3),
	
renderv1(Form1,Voiceparts1,Vocalstubinstrument,Lyrics,Melody,Totallength,Track,Bar1,Bar2,Voice1,Voice2) :-
	Form1=[Section1|Form2],
	Voiceparts1=[Section2|Voiceparts2],
	not(Section1=Section2),
	Bar3 is Bar1+4,
	renderv1(Form2,Voiceparts1,Vocalstubinstrument,Lyrics,Melody,Totallength,Track,Bar3,Bar2,Voice1,Voice2),!.

renderv2(Section,Lyrics,_Melody,_Totallength,_Track,Bar,Bar,Voice,Voice) :- 
	not(member([Section,_],Lyrics),!.
renderv2(Section1,Lyrics1,Melody1,_Totallength,Track,Bar1,Bar2,Voice1,Voice2) :-
	findall(Lyrics2,(member(Lyrics2,Lyrics1),Lyrics2=[Section1,_]),Lyrics3),
	string_concat(B,_C,Section1),string_length(Section2,1),
	findall(Melody2,(member(Melody2,Melody1),Melody2=[Section2,_]),Melody3),
	Lyrics3=[Lyrics1A,Lyrics2A,Lyrics3A,Lyrics4A],
	Melody3=[Melody1A,Melody2A],
	renderline1(Lyrics1A,Melody1A,_Totallength,Track,Bar1,Bar3,Voice1,Voice3),
	Bar4 is Bar3+1,
	renderline1(Lyrics2A,Melody2A,_Totallength,Track,Bar4,Bar5,Voice3,Voice4),
	Bar6 is Bar5+1,
	renderline1(Lyrics3A,Melody1A,_Totallength,Track,Bar6,Bar7,Voice4,Voice5),
	Bar8 is Bar7+1,
	renderline1(Lyrics4A,Melody2A,_Totallength,Track,Bar8,Bar9,Voice5,Voice6),
	Bar10 is Bar9+1,
	delete(Lyrics1,[Section,_],Lyrics5),
	renderv2(Section1,Lyrics5,Melody1,_Totallength,Track,Bar10,Bar2,Voice6,Voice2).
	
renderline1(Lyrics1,Melody1,_Totallength,Track,Bar1,Bar2,Voice1,Voice2) :-
	Lyrics1=[_,Lyrics2],
	length(Lyrics2,Lyrics2Length),
	%%Rests is Totallength-Lyrics2Length,
	BarTimes1=["0","1/2","1","1+1/2","2","2+1/2","3","3+1/2"],
	generatemelody(Lyrics2Length,Melody1,Melody2),
	renderline2(BarTimes1,BarTimes2,Melody2,Track,Bar1,Voice1,Voice3),
	renderlinerests(BarTimes2,_BarTimes3,Track,Bar1,Voice3,Voice2).	

generatemelody(Lyrics2Length,Melody1,Melody2) :-
	generatemelody(Melody1,[],Melody3),
	length(Melody3,Melody2Length),
	changelength(Lyrics2Length,Melody2Length,Melody3,Melody2).	

generatemelody([],Melody,Melody) :- !.
generatemelody(Melody1,Melody2,Melody3) :-
	Melody1=[Melody4|Melody5],
	append(Melody2,[Melody4,Melody4],Melody6),
	generatemelody(Melody5,Melody6,Melody3),!.

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
	repeatlastnote1(Length,Item,Melody1,Melody2),!.

repeatlastnote2(0,_Item,Melody,Melody) :- !.
repeatlastnote2(Length1,Item,Melody1,Melody2) :-
	append(Melody1,[Item],Melody3),
	Length2 is Length1-1,
	repeatlastnote2(Length2,Item,Melody3,Melody2),!.

renderline2(BarTimes,BarTimes,[],_Track,_Bar1,Voice,Voice) :- !.
renderline2(BarTimes1,BarTimes4,Melody1,Track,Bar,Voice1,Voice2) :-
	Melody1=[Melody2|Melody3],
	BarTimes1=[BarTimes2|BarTimes3],
	concat_list("BA    ",[Bar,"   CR         ",BarTimes2,"   TR  ",Track,"   CH  1   NT  ",Melody4,"-           1/2   voff=0\n"],Song),
	string_concat(Voice1,Song,Voice3),
	renderline2(BarTimes3,BarTimes4,Melody3,Track,Bar,Voice3,Voice2).

renderlinerests(BarTimes,BarTimes,Track,Bar1,Voice,Voice) :- !.
renderlinerests(BarTimes1,BarTimes2,Track,Bar1,Voice1,Voice2) :-
	BarTimes1=[BarTimes2|BarTimes3],
	concat_list("BA    ",[Bar,"   CR         ",BarTimes2,"   TR  ",Track,"   CH  1   NT  R            1/2   voff=0\n"],Song),
	string_concat(Voice1,Song,Voice3),
	renderlinerests(BarTimes3,BarTimes2,Track,Bar,Voice3,Voice2).

outputlyrics(Lyrics) :-

**/

max([],M,M) :- !.
max(List1,Max1,Max2) :-
	List1=[Item|List2],
	(Item>Max1->max(List2,Item,Max2);
	max(List2,Max1,Max2)).
	
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

find("Should the chord progression type be 1564, 1645, Classical or Classical Pop?",CPT) :-
	trialy2([1564, 1645, classical, classicalpop],R),
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
%%	repeat,%%also for o
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
readv([["loves"],["is"],["has"],["is","in"],["moves","to"],["nur","tures"],["needs"],["makes"],["lifts"],["finds"],["forms"],["goes","to"],["writes","about"],["reads","about"],["feels"],["is"]]).

reado([["one"],["the","o","ther"],["the","run","ner"],["the","dra","wer"],["the","coun","ter"],["the","gra","pher"],["the","tes","ter"],["the","breath","so","ner"],["the","wri","ter"],["the","spel","ler"],["the","upda","ter"],["the","chec","ker"],["the","se","lec","tor"],["the","es","sen","tial"],["the","com","bi","ner"],["the","mi","rac","le"],["the","tran","sla","tor"],["the","gram","mar"]]).

rhymes([["good","one","ther","ner","wer","ter","pher","ter","ter","ler","ker","tor","mar","an","ae","er","ur","ard","ey","ald","ess","l"],["tial","le","py","ye","ie","e","ice"]]).

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
trialy2(List,R) :-
	random_member(A,List),
	R=[[_,A]].
	/**
	length(List,L),
	Trials is L*3,
	trialy22(List,Trials,[],R).**/

trialy22([],_,R,R) :- !.
trialy22(List,Trials,RA,RB) :-
	List=[Item|Items],
	trialy21(Item,Trials,R1),
	append(RA,[R1],RC),
	trialy22(Items,Trials,RC,RB),!.

trialy21(Label,Trials,RA) :-
	trialy3(Trials,[],R),
	aggregate_all(count, member(true,R), Count),
	RA=[Count,Label].

trialy3(0,R,R) :-!.
trialy3(Trials1,RA,RB) :-
	trialy1(R1),
	append(RA,[R1],RC),
	Trials2 is Trials1-1,
	trialy3(Trials2,RC,RB),!.
	
%% try other nouns
trialy1(R1) :-
	%%control11(A1),
	trial0(A22), %% Control
	sum(A22,0,S22),
	mean(S22,A1),
	trial0(A21), %% Test 1
	sum(A21,0,S02),
	mean(S02,A2),
	(A1>A2->R1=true;R1=fail).

trial0(S3) :- N is 10, trial1(N,[],S),trial01(S,S3).
trial01(S1,S3) :-
	sort(S1,S),
	%%midpoint(S,MP),
	halves(S,H1,H2),
	midpoint(H1,Q1),
	midpoint(H2,Q3),
	IQR is Q3-Q1,
	sum(S,0,S02),
	mean(S02,Mean),
	furthestfrommean(S,Mean,V),
	D1 is 1.5*IQR,
	D2 is V-Mean,
	(D2>D1->(delete(S,V,S2),trial01(S2,S3));S=S3).
	
trial1(0,A,A) :- !.
trial1(N,A,B) :- mindreadtest(S), append(A,[S],A2),
	N1 is N-1,trial1(N1,A2,B).
	
midpoint(S,MP) :-
	length(S,L),
	A is mod(L,2),
	(A is 0->
		(M1 is L/2, M2 is M1+1,N1 is M1-1,N2 is M2-1,length(N11,N1),length(N21,N2),append(N11,[N12|_Rest1],S),append(N21,[N22|_Rest2],S),MP is (N12+N22)/2)
	;
		(L2 is L+1, M1 is L2/2, N1 is M1-1,length(N11,N1),append(N11,[MP|_Rest],S))).

halves(S,H1,H2) :-
	length(S,L),
	A is mod(L,2),
	(A is 0->
		(M1 is L/2,length(H1,M1),append(H1,H2,S))
	;
		(L2 is L-1,M1 is L2/2,length(H1,M1),append(H1,[_|H2],S))).

sum([],S,S):-!.
sum(S0,S1,S2) :-
	S0=[S3|S4],
	S5 is S1+S3,
	sum(S4,S5,S2).
	
mean(Sum,Mean) :-
	Mean is Sum/2.

furthestfrommean(S,Mean,V) :-
	absdiffmean(S,Mean,[],D),
	sort(D,D1),
	reverse(D1,[[_,V]|_Rest]).

absdiffmean([],_M,D,D) :- !.
absdiffmean(S,M,D1,D2) :-
	S=[S1|S2],
	S3 is abs(S1-M),
	append(D1,[[S3,S1]],D3),
	absdiffmean(S2,M,D3,D2).

mindreadtest(Sec) :-
	%% 250 br for characters to be br out with 10 br each from person to me - do when initial 250 br test done and doing 10 br test
	%%comment(fiftyastest),
	%%random(X),X1 is 10*X, X2 is floor(X1), (X2=<2 -> (
	%%texttobr,writeln(['true test']), %%); %% use breasonings breasoned out by computer for not by me, for job medicine for "me", at last time point
	%%true), %% leave last time point blank
	%%**texttobr2(640);true),%% make an A to detect reaction to gracious giving or blame of in following
	get_time(TimeStamp1),
	%%phrase_from_file(string(_String), 'file.txt'),
	%%**texttobr2(2), %% 100 As for answer (must be br before this on same day)
	%% is gracious giving or blame
	get_time(TimeStamp2),
	%%comment(turnoffas),
   Sec is TimeStamp2 - TimeStamp1.

/**string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

comment(fiftyastest).
comment(turnoffas).
**/

remove_dups([],List,List) :- !.
remove_dups(List1,List2,List3) :-
	List1=[Item|List4],
	delete(List4,Item,List5),
	append(List2,[Item],List6),
	remove_dups(List5,List6,List3),!.
	
