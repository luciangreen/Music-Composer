/**
Classical Pop (with minor sixth) Composition
Based on 2 3 5 6 7 8 10 11 intervals
Counter=4
?- popclassicalcomposition('C','D').
?- popclassicalcomposition('C','C#').
?- popclassicalcomposition('C','E').
?- popclassicalcomposition('C','D#').
**/
popclassicalcomposition(Name1, Name2,Progression2) :-
note(Note1, Name1),
note(Note2, Name2),
popclassicalcomposition1(Note1, Note2, 0, _, [Note1], Progression1), notestonames(Progression1,Progression2),!.
popclassicalcomposition1(_, _, Counter, b, Progression, Progression) :-
Counter = 3, !.
popclassicalcomposition1(Note, Note, _Counter, a, Progression, Progression) :- !.
popclassicalcomposition1(Note1, Note2, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
steppopclassical1(Note1, Note3),
append(Progression1, [Note3], Progression3),
popclassicalcomposition2(Note3, Note2, Note1, Counter2, Flag2, Progression3, Progression4),
steppopclassical2(Note1, Note4),
append(Progression1, [Note4], Progression5),
popclassicalcomposition2(Note4, Note2, Note1, Counter2, Flag3, Progression5, Progression6),
steppopclassical3(Note1, Note5),
append(Progression1, [Note5], Progression7),
popclassicalcomposition2(Note5, Note2, Note1, Counter2, Flag4, Progression7, Progression8),

steppopclassical4(Note1, Note7),
append(Progression1, [Note7], Progression9),
popclassicalcomposition2(Note7, Note2, Note3, Counter2, Flag5, Progression9, Progression10),

steppopclassical5(Note1, Note8),
append(Progression1, [Note8], Progression11),
popclassicalcomposition2(Note8, Note2, Note3, Counter2, Flag6, Progression11, Progression12),

steppopclassical52(Note1, Note82),
append(Progression1, [Note82], Progression112),
popclassicalcomposition2(Note82, Note2, Note3, Counter2, Flag62, Progression112, Progression122),

steppopclassical6(Note1, Note9),
append(Progression1, [Note9], Progression13),
popclassicalcomposition2(Note9, Note2, Note3, Counter2, Flag7, Progression13, Progression14),

steppopclassical7(Note1, Note10),
append(Progression1, [Note10], Progression15),
popclassicalcomposition2(Note10, Note2, Note3, Counter2, Flag8, Progression15, Progression16),

flag1([[Flag2, Progression4], [Flag3, Progression6], [Flag4, Progression8], 

[Flag5, Progression10], [Flag6, Progression12], [Flag62, Progression122], [Flag7, Progression14], [Flag8, Progression16]], Flag1, Progression2).

popclassicalcomposition2(_, _, _, Counter, b, Progression, Progression) :-
Counter = 3, !.
popclassicalcomposition2(Note, _, Note, _, _, _, _) :- !.
popclassicalcomposition2(Note, Note, _, _Counter, a, Progression, Progression) :- !.
popclassicalcomposition2(Note1, Note2, Note3, Counter1, Flag1, Progression1, Progression2) :-
Counter2 is Counter1 + 1,
steppopclassical1(Note1, Note4),
append(Progression1, [Note4], Progression3),
popclassicalcomposition2(Note4, Note2, Note3, Counter2, Flag2, Progression3, Progression4),
steppopclassical2(Note1, Note5),
append(Progression1, [Note5], Progression5),
popclassicalcomposition2(Note5, Note2, Note3, Counter2, Flag3, Progression5, Progression6),
steppopclassical3(Note1, Note6),
append(Progression1, [Note6], Progression7),
popclassicalcomposition2(Note6, Note2, Note3, Counter2, Flag4, Progression7, Progression8),

steppopclassical4(Note1, Note7),
append(Progression1, [Note7], Progression9),
popclassicalcomposition2(Note7, Note2, Note3, Counter2, Flag5, Progression9, Progression10),

steppopclassical5(Note1, Note8),
append(Progression1, [Note8], Progression11),
popclassicalcomposition2(Note8, Note2, Note3, Counter2, Flag6, Progression11, Progression12),

steppopclassical52(Note1, Note82),
append(Progression1, [Note82], Progression112),
popclassicalcomposition2(Note82, Note2, Note3, Counter2, Flag62, Progression112, Progression122),

steppopclassical6(Note1, Note9),
append(Progression1, [Note9], Progression13),
popclassicalcomposition2(Note9, Note2, Note3, Counter2, Flag7, Progression13, Progression14),

steppopclassical7(Note1, Note10),
append(Progression1, [Note10], Progression15),
popclassicalcomposition2(Note10, Note2, Note3, Counter2, Flag8, Progression15, Progression16),

flag1([[Flag2, Progression4], [Flag3, Progression6], [Flag4, Progression8], 

[Flag5, Progression10], [Flag6, Progression12], [Flag62, Progression122], [Flag7, Progression14], [Flag8, Progression16]], Flag1, Progression2).

steppopclassical1(Note1, Note2) :-
Value is Note1+2, Note2 is Value mod 12.
steppopclassical2(Note1, Note2) :-
Value is Note1+3, Note2 is Value mod 12.
steppopclassical3(Note1, Note2) :-
Value is Note1+5, Note2 is Value mod 12.
steppopclassical4(Note1, Note2) :-
Value is Note1+6, Note2 is Value mod 12.
steppopclassical5(Note1, Note2) :-
Value is Note1+7, Note2 is Value mod 12.
steppopclassical52(Note1, Note2) :-
Value is Note1+8, Note2 is Value mod 12.
steppopclassical6(Note1, Note2) :-
Value is Note1+10, Note2 is Value mod 12.
steppopclassical7(Note1, Note2) :-
Value is Note1+11, Note2 is Value mod 12.
