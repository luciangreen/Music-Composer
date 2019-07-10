/**
Prolog Music Composer V.1
1. Chorus, Solo (based on I-IV-V-I) **/
versechorussoloprogression1451(Name1, Name2,Progression2) :-
note(Note1, Name1),
note(Note2, Name2),
versechorussoloprogression11451(Note1, Note2, 0, _, [Note1], Progression1), notestonames(Progression1,Progression2),!.%%, writeln(Progression2),!.
versechorussoloprogression11451(_, _, _, Counter, b, Progression, Progression) :-
Counter = 4, !.
versechorussoloprogression11451(Note, Note, _, _Counter, a, Progression, Progression) :- !.
versechorussoloprogression11451(Note1, Note2, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
step14511(Note1, Note3),
append(Progression1, [Note3], Progression3),
versechorussoloprogression21451(Note3, Note2, Note1, Counter2, Flag2, Progression3, Progression4),
step14512(Note1, Note4),
append(Progression1, [Note4], Progression5),
versechorussoloprogression21451(Note4, Note2, Note1, Counter2, Flag3, Progression5, Progression6),
flag1([[Flag2, Progression4], [Flag3, Progression6]], Flag1, Progression2).
versechorussoloprogression21451(_, _, _, Counter, b, Progression, Progression) :-
Counter = 4, !.
versechorussoloprogression21451(Note, _, Note, _, _, _, _) :- !.
versechorussoloprogression21451(Note, Note, _, _Counter, a, Progression, Progression) :- !.
versechorussoloprogression21451(Note1, Note2, Note3, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
step14511(Note1, Note4),
append(Progression1, [Note4], Progression3),
versechorussoloprogression21451(Note4, Note2, Note3, Counter2, Flag2, Progression3, Progression4),
step14512(Note1, Note5),
append(Progression1, [Note5], Progression5),
versechorussoloprogression21451(Note5, Note2, Note3, Counter2, Flag3, Progression5, Progression6),
flag1([[Flag2, Progression4], [Flag3, Progression6]], Flag1, Progression2).
step14511(Note1, Note2) :-
Value is Note1+2, Note2 is Value mod 12. %% IV-V
step14512(Note1, Note2) :-
Value is Note1+5, Note2 is Value mod 12. %% I-IV, V-I

%% 1 4 5 1
%%  5 2 5
