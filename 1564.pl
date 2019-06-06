/**
Prolog Music Composer V.3
Verse, Chorus and Solo (based on I-V-vi-IV):
Listen to a sample. (https://soundcloud.com/lucian-green/prolog-music-composer-v3-based-on-i-v-vi-iv).
Counter=4
?- versechorussoloprogression('C','D').
[[C,D],[C,G,D]]
Yes
?- versechorussoloprogression('C','C#').
[]
Yes
versechorussoloprogression('C','E').
[[C,D,E],[C,D,A,E],[C,G,A,E],[C,G,D,E],[C,G#,E]]
Yes
?- versechorussoloprogression('C','D#').
[[C,G,D#],[C,G#,D#]]
**/
versechorussoloprogression1564(Name1, Name2,Progression2) :-
note(Note1, Name1),
note(Note2, Name2),
versechorussoloprogression11564(Note1, Note2, 0, _, [Note1], Progression1), notestonames(Progression1,Progression2),!.
versechorussoloprogression11564(_, _, Counter, b, Progression, Progression) :-
Counter = 3, !.
versechorussoloprogression11564(Note, Note, _Counter, a, Progression, Progression) :- !.
versechorussoloprogression11564(Note1, Note2, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
step15641(Note1, Note3),
append(Progression1, [Note3], Progression3),
versechorussoloprogression21564(Note3, Note2, Note1, Counter2, Flag2, Progression3, Progression4),
step15642(Note1, Note4),
append(Progression1, [Note4], Progression5),
versechorussoloprogression21564(Note4, Note2, Note1, Counter2, Flag3, Progression5, Progression6),
step15643(Note1, Note5),
append(Progression1, [Note5], Progression7),
versechorussoloprogression21564(Note5, Note2, Note1, Counter2, Flag4, Progression7, Progression8),
flag1([[Flag2, Progression4], [Flag3, Progression6], [Flag4, Progression8]], Flag1, Progression2).
versechorussoloprogression21564(_, _, _, Counter, b, Progression, Progression) :-
Counter = 3, !.
versechorussoloprogression21564(Note, _, Note, _, _, _, _) :- !.
versechorussoloprogression21564(Note, Note, _, _Counter, a, Progression, Progression) :- !.
versechorussoloprogression21564(Note1, Note2, Note3, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
step15641(Note1, Note4),
append(Progression1, [Note4], Progression3),
versechorussoloprogression21564(Note4, Note2, Note3, Counter2, Flag2, Progression3, Progression4),
step15642(Note1, Note5),
append(Progression1, [Note5], Progression5),
versechorussoloprogression21564(Note5, Note2, Note3, Counter2, Flag3, Progression5, Progression6),
step15643(Note1, Note6),
append(Progression1, [Note6], Progression7),
versechorussoloprogression21564(Note6, Note2, Note3, Counter2, Flag4, Progression7, Progression8),
flag1([[Flag2, Progression4], [Flag3, Progression6], [Flag4, Progression8]], Flag1, Progression2).
step15641(Note1, Note2) :-
Value is Note1+2, Note2 is Value mod 12.
step15642(Note1, Note2) :-
Value is Note1+7, Note2 is Value mod 12.
step15643(Note1, Note2) :-
Value is Note1+8, Note2 is Value mod 12.
