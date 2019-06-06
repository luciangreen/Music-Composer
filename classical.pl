/**
Classical Composition
Based on 2 3 5 6 7 10 11 intervals
https://swish.swi-prolog.org/p/LucianGreenMusic.pl
Counter=4
?- classicalcomposition('C','D').
?- classicalcomposition('C','C#').
classicalcomposition('C','E').
?- classicalcomposition('C','D#').
**/

classicalcomposition(Name1, Name2,Progression2) :-
note(Note1, Name1),
note(Note2, Name2),
classicalcomposition1(Note1, Note2, 0, _, [Note1], Progression1), notestonames(Progression1,Progression2),!.%%writeln(Progression2),!.
classicalcomposition1(_, _, Counter, b, Progression, Progression) :-
Counter = 3, !.
classicalcomposition1(Note, Note, _Counter, a, Progression, Progression) :- !.
classicalcomposition1(Note1, Note2, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
stepclassical1(Note1, Note3),
append(Progression1, [Note3], Progression3),
classicalcomposition2(Note3, Note2, Note1, Counter2, Flag2, Progression3, Progression4),
stepclassical2(Note1, Note4),
append(Progression1, [Note4], Progression5),
classicalcomposition2(Note4, Note2, Note1, Counter2, Flag3, Progression5, Progression6),
stepclassical3(Note1, Note5),
append(Progression1, [Note5], Progression7),
classicalcomposition2(Note5, Note2, Note1, Counter2, Flag4, Progression7, Progression8),

stepclassical4(Note1, Note7),
append(Progression1, [Note7], Progression9),
classicalcomposition2(Note7, Note2, Note3, Counter2, Flag5, Progression9, Progression10),

stepclassical5(Note1, Note8),
append(Progression1, [Note8], Progression11),
classicalcomposition2(Note8, Note2, Note3, Counter2, Flag6, Progression11, Progression12),

stepclassical6(Note1, Note9),
append(Progression1, [Note9], Progression13),
classicalcomposition2(Note9, Note2, Note3, Counter2, Flag7, Progression13, Progression14),

stepclassical7(Note1, Note10),
append(Progression1, [Note10], Progression15),
classicalcomposition2(Note10, Note2, Note3, Counter2, Flag8, Progression15, Progression16),

flag1([[Flag2, Progression4], [Flag3, Progression6], [Flag4, Progression8], 

[Flag5, Progression10], [Flag6, Progression12], [Flag7, Progression14], [Flag8, Progression16]], Flag1, Progression2).

classicalcomposition2(_, _, _, Counter, b, Progression, Progression) :-
Counter = 3, !.
classicalcomposition2(Note, _, Note, _, _, _, _) :- !.
classicalcomposition2(Note, Note, _, _Counter, a, Progression, Progression) :- !.
classicalcomposition2(Note1, Note2, Note3, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
stepclassical1(Note1, Note4),
append(Progression1, [Note4], Progression3),
classicalcomposition2(Note4, Note2, Note3, Counter2, Flag2, Progression3, Progression4),
stepclassical2(Note1, Note5),
append(Progression1, [Note5], Progression5),
classicalcomposition2(Note5, Note2, Note3, Counter2, Flag3, Progression5, Progression6),
stepclassical3(Note1, Note6),
append(Progression1, [Note6], Progression7),
classicalcomposition2(Note6, Note2, Note3, Counter2, Flag4, Progression7, Progression8),

stepclassical4(Note1, Note7),
append(Progression1, [Note7], Progression9),
classicalcomposition2(Note7, Note2, Note3, Counter2, Flag5, Progression9, Progression10),

stepclassical5(Note1, Note8),
append(Progression1, [Note8], Progression11),
classicalcomposition2(Note8, Note2, Note3, Counter2, Flag6, Progression11, Progression12),

stepclassical6(Note1, Note9),
append(Progression1, [Note9], Progression13),
classicalcomposition2(Note9, Note2, Note3, Counter2, Flag7, Progression13, Progression14),

stepclassical7(Note1, Note10),
append(Progression1, [Note10], Progression15),
classicalcomposition2(Note10, Note2, Note3, Counter2, Flag8, Progression15, Progression16),

flag1([[Flag2, Progression4], [Flag3, Progression6], [Flag4, Progression8], 

[Flag5, Progression10], [Flag6, Progression12], [Flag7, Progression14], [Flag8, Progression16]], Flag1, Progression2).

stepclassical1(Note1, Note2) :-
Value is Note1+2, Note2 is Value mod 12.
stepclassical2(Note1, Note2) :-
Value is Note1+3, Note2 is Value mod 12.
stepclassical3(Note1, Note2) :-
Value is Note1+5, Note2 is Value mod 12.
stepclassical4(Note1, Note2) :-
Value is Note1+6, Note2 is Value mod 12.
stepclassical5(Note1, Note2) :-
Value is Note1+7, Note2 is Value mod 12.
stepclassical6(Note1, Note2) :-
Value is Note1+10, Note2 is Value mod 12.
stepclassical7(Note1, Note2) :-
Value is Note1+11, Note2 is Value mod 12.
