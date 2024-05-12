
%% do 100 business songs at start of day

%% automatically do a sale every hour until 11 PM x for n hours

%% get txt,mid filenames
%% get br count of txt
%% br multiple
   
%% move them into another folder (delete or save on la com next day - compress and email)

%% later: react to periods

sectest01(N) :-
	write("*** Please indicate "),
	write(N),
	writeln(" number 1 songs. ***"),
	sleep(5),
	sectest11(N).

sectest11(0) :- !.
sectest11(N1) :-
	(catch(
	sectest0(_Form1,_Lyrics,_Melody,_Harmony,_MelodyParts,
	_HarmonyParts,_Vocalstubinstrument,_Song1),
	%(random(X),X1 is ceiling(2*X),X1 =1),
	_,
	false)->
	(writeln([song,N1,done]),
	N2 is N1-1,
	sectest11(N2)
	);
	sectest11(N1)
).
