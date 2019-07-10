/**
Prolog Music Composer V.4
Verse, Chorus and Solo (based on I-vi-IV-V):
Counter=4
**/
versechorussoloprogression1645(Name1, Name2,Progression2) :-
note(Note1, Name1),
note(Note2, Name2),
versechorussoloprogression11645(Note1, Note2, 0, _, [Note1], Progression1), notestonames(Progression1,Progression2),!.
versechorussoloprogression11645(_, _, Counter, b, Progression, Progression) :-
Counter = 4, !.
versechorussoloprogression11645(Note, Note, _Counter, a, Progression, Progression) :- !.
versechorussoloprogression11645(Note1, Note2, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
step16451(Note1, Note3),
append(Progression1, [Note3], Progression3),
versechorussoloprogression21645(Note3, Note2, Note1, Counter2, Flag2, Progression3, Progression4),
step16452(Note1, Note4),
append(Progression1, [Note4], Progression5),
versechorussoloprogression21645(Note4, Note2, Note1, Counter2, Flag3, Progression5, Progression6),
step16453(Note1, Note5),
append(Progression1, [Note5], Progression7),
versechorussoloprogression21645(Note5, Note2, Note1, Counter2, Flag4, Progression7, Progression8),
flag1([[Flag2, Progression4], [Flag3, Progression6], [Flag4, Progression8]], Flag1, Progression2).
versechorussoloprogression21645(_, _, _, Counter, b, Progression, Progression) :-
Counter = 4, !.
versechorussoloprogression21645(Note, _, Note, _, _, _, _) :- !.
versechorussoloprogression21645(Note, Note, _, _Counter, a, Progression, Progression) :- !.
versechorussoloprogression21645(Note1, Note2, Note3, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
step16451(Note1, Note4),
append(Progression1, [Note4], Progression3),
versechorussoloprogression21645(Note4, Note2, Note3, Counter2, Flag2, Progression3, Progression4),
step16452(Note1, Note5),
append(Progression1, [Note5], Progression5),
versechorussoloprogression21645(Note5, Note2, Note3, Counter2, Flag3, Progression5, Progression6),
step16453(Note1, Note6),
append(Progression1, [Note6], Progression7),
versechorussoloprogression21645(Note6, Note2, Note3, Counter2, Flag4, Progression7, Progression8),
flag1([[Flag2, Progression4], [Flag3, Progression6], [Flag4, Progression8]], Flag1, Progression2).
step16451(Note1, Note2) :-
Value is Note1+2, Note2 is Value mod 12.
step16452(Note1, Note2) :-
Value is Note1+8, Note2 is Value mod 12.
step16453(Note1, Note2) :-
Value is Note1+9, Note2 is Value mod 12.
