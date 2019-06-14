# Music-Composer
Music Composer can (optionally mind read to) create songs.  Currently set to generate song elements randomly, not mind read them, so doesn't require precautions to run.

Install and load by typing ['mindreadtestmusiccomposer'].

Requires asc2mid (http://www.archduke.org/midi/, compile with a C compiler before running, call application "asc2mid").

Run with sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1),writeln(sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1)).

Example output:

Dix ey lifts the chec ker.
All er forms the es sen tial.
The wri ter moves to Don er.
The chec ker finds Skye e.

Count l goes to the tran sla tor.
Count ye reads about one.
The dra wer needs Don ur.
Wilb an lifts Wilb an.

Luc l nur tures the tran sla tor.
Ac ae makes the coun ter.
Duk ye reads about Duk er.
Wilb an forms Wilb an.

Black an forms Ac ald.
Adr e finds Don ey.
Duk ye lifts Whistl ur.
Wilb an forms Don ey.

sectest0([n,v1,i1,v2,c,t2,s,s,s],[[v1,[Dix,ey,lifts,the,chec,ker],[All,er,forms,the,es,sen,tial],[the,wri,ter,moves,to,Don,er],[the,chec,ker,finds,Skye,e]],[v2,[Count,l,goes,to,the,tran,sla,tor],[Count,ye,reads,about,one],[the,dra,wer,needs,Don,ur],[Wilb,an,lifts,Wilb,an]],[c,[Luc,l,nur,tures,the,tran,sla,tor],[Ac,ae,makes,the,coun,ter],[Duk,ye,reads,about,Duk,er],[Wilb,an,forms,Wilb,an]],[s,[Black,an,forms,Ac,ald],[Adr,e,finds,Don,ey],[Duk,ye,lifts,Whistl,ur],[Wilb,an,forms,Don,ey]]],[[n,[E,D]],[n,[G,A#,A]],[v,[A,D,F]],[v,[A#,D#,F]],[i,[F,B,E]],[i,[A,D,E]],[c,[E,D#,A]],[c,[D]],[t,[D,G,C]],[t,[F,B,E]],[s,[E,B,F]],[s,[A#,C,F]]],[[[n,[E,G,B]],[n,[G,B,D]],[n,[D,F,A]]],[[n,[G,B,D]],[n,[A#,D,F]],[n,[A,C,E]]],[[v,[A,C,E]],[v,[G,B,D]],[v,[F,A,C]]],[[v,[A#,D,F]],[v,[D#,G,A]],[v,[F,A,C]]],[[i,[F,A,C]],[i,[A#,D,F]],[i,[E,G,B]]],[[i,[A,C,E]],[i,[E,G,B]]],[[c,[E,G,B]],[c,[A#,D,F]],[c,[A,C,E]]],[[c,[D,F,A]]],[[t,[D,F,A]],[t,[G,B,D]],[t,[C,E,G]]],[[t,[F,A,C]],[t,[E,G,B]]],[[s,[E,G,B]],[s,[D#,G,A]],[s,[F,A,C]]],[[s,[A#,D,F]],[s,[C,E,G]],[s,[F,A,C]]]],[[[n,[82,Lead 3 (calliope)],1],[v1,[82,Lead 3 (calliope)],0],[i1,[82,Lead 3 (calliope)],1],[v2,[82,Lead 3 (calliope)],0],[c,[82,Lead 3 (calliope)],0],[t2,[82,Lead 3 (calliope)],0],[s,[82,Lead 3 (calliope)],1],[s,[82,Lead 3 (calliope)],1],[s,[82,Lead 3 (calliope)],0]],[[n,[9,Glockenspiel],1],[v1,[9,Glockenspiel],1],[i1,[9,Glockenspiel],0],[v2,[9,Glockenspiel],0],[c,[9,Glockenspiel],0],[t2,[9,Glockenspiel],1],[s,[9,Glockenspiel],1],[s,[9,Glockenspiel],1],[s,[9,Glockenspiel],1]],[[n,[8,Celesta],0],[v1,[8,Celesta],0],[i1,[8,Celesta],0],[v2,[8,Celesta],1],[c,[8,Celesta],1],[t2,[8,Celesta],0],[s,[8,Celesta],0],[s,[8,Celesta],0],[s,[8,Celesta],1]]],[[[n,[75,Pan Flute],1],[v1,[75,Pan Flute],1],[i1,[75,Pan Flute],1],[v2,[75,Pan Flute],1],[c,[75,Pan Flute],0],[t2,[75,Pan Flute],1],[s,[75,Pan Flute],1],[s,[75,Pan Flute],1],[s,[75,Pan Flute],1]],[[n,[80,Lead 1 (square)],1],[v1,[80,Lead 1 (square)],0],[i1,[80,Lead 1 (square)],0],[v2,[80,Lead 1 (square)],0],[c,[80,Lead 1 (square)],0],[t2,[80,Lead 1 (square)],0],[s,[80,Lead 1 (square)],0],[s,[80,Lead 1 (square)],0],[s,[80,Lead 1 (square)],1]]],[0,Acoustic Grand Piano]

Caution: follow instructions in https://github.com/luciangreen/listprologinterpreter/blob/master/Instructions_for_Using_texttobr(2).pl.txt when using texttobr, texttobr2 or mind reader to avoid medical problems.
