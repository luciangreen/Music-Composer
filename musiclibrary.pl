notestonames(Progression1, Progression2) :-
clean(Progression1, Progression2).
flag1(Items, Flag, Progression) :-
flag2(Items, Flag, [], Progression), !.
flag1([], b, []) :- !.
flag2([], a, Progression, Progression) :- !.
flag2([[a,Progression1]|Items], _, Progression2, Progression3) :-
append(Progression2, [Progression1], Progression4),
flag2(Items, _, Progression4, Progression3).
flag2([[b,_]|Items], _, Progression2, Progression3) :-
flag2(Items, _, Progression2, Progression3).
clean(Items1, Items2) :-
clean1(Items1,[],Items2).
clean1([],I,I).
clean1(Items,I1,F1) :-
allnumbers(Items,[],Names),append(I1,[Names],F1),!.
clean1([Item|Items],I1,F1) :-
clean1(Item, I1, F2),
clean1(Items, F2, F1).
allnumbers([],Names,Names).
allnumbers([Item|Items],Names1,Names2):-
number(Item),note(Item,Name),append(Names1,[Name],Names3),allnumbers(Items,Names3,Names2).

note0(0,'C').
note0(1,'D').
note0(2,'E').
note0(3,'F').
note0(4,'G').
note0(5,'A').
note0(6,'B').

note(0,'C').
note(1,'C#').
note(2,'D').
note(3,'D#').
note(4,'E').
note(5,'F').
note(6,'F#').
note(7,'G').
note(8,'G#').
note(9,'A').
note(10,'A#').
note(11,'B').


