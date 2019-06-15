# Music-Composer
Music Composer can (optionally mind read to) create songs.  Currently set to generate song elements randomly, not mind read them, so doesn't require precautions to run.

Install and load by typing ['mindreadtestmusiccomposer'].

Requires asc2mid (http://www.archduke.org/midi/, compile with a C compiler before running, call application "asc2mid").

Run with sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1),writeln(sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1)).

Example output:

Black l loves the gram mar.
Count er reads about Brae ard.
Duk ie feels Brae ard.
The tes ter is Skye ae.

Black ye forms the tran sla tor.
Whistl ice makes the tes ter.
The tran sla tor is Nei ey.
The wri ter lifts Ac ur.

Adr ard nur tures the o ther.
Le ard makes the tes ter.
Luc an writes about Brae ard.
One finds Brae ard.

Adr l has the com bi ner.
Dix l is Don l.
Brae ard makes Duk l.
The spel ler goes to Brae ard.

sectest0([n,v1,i1,v2,c,t2,s,c,o],[[v1,[Black,l,loves,the,gram,mar],[Count,er,reads,about,Brae,ard],[Duk,ie,feels,Brae,ard],[the,tes,ter,is,Skye,ae]],[v2,[Black,ye,forms,the,tran,sla,tor],[Whistl,ice,makes,the,tes,ter],[the,tran,sla,tor,is,Nei,ey],[the,wri,ter,lifts,Ac,ur]],[c,[Adr,ard,nur,tures,the,o,ther],[Le,ard,makes,the,tes,ter],[Luc,an,writes,about,Brae,ard],[one,finds,Brae,ard]],[s,[Adr,l,has,the,com,bi,ner],[Dix,l,is,Don,l],[Brae,ard,makes,Duk,l],[the,spel,ler,goes,to,Brae,ard]]],[[n,[A,D,E]],[n,[A,G,C]],[v,[C,B]],[v,[E]],[i,[E,G,D]],[i,[G]],[c,[G]],[c,[C,D,E]],[t,[E,D,G]],[t,[C,G,F]],[s,[F,B,A]],[s,[D,A]],[o,[A,C,G]],[o,[C,D,F]]],[[[n,[A,C,E]],[n,[E,G,B]]],[[n,[A,C,E]],[n,[G,B,D]],[n,[C,E,G]]],[[v,[C,E,G]],[v,[F#,A,C]],[v,[B,D,F]]],[[v,[E,G,B]]],[[i,[E,G,B]],[i,[D#,G,A]],[i,[D,F,A]]],[[i,[G,B,D]]],[[c,[G,B,D]]],[[c,[C,E,G]],[c,[B,D,F]],[c,[E,G,B]]],[[t,[E,G,B]],[t,[A,C,E]],[t,[G,B,D]]],[[t,[C,E,G]],[t,[F,A,C]]],[[s,[F,A,C]],[s,[A#,D,F]],[s,[A,C,E]]],[[s,[D,F,A]],[s,[E,G,B]],[s,[A,C,E]]],[[o,[A,C,E]],[o,[C,E,G]],[o,[G,B,D]]],[[o,[C,E,G]],[o,[A#,D,F]],[o,[F,A,C]]]],[[[n,[78,Whistle],1],[v1,[78,Whistle],0],[i1,[78,Whistle],0],[v2,[78,Whistle],1],[c,[78,Whistle],0],[t2,[78,Whistle],1],[s,[78,Whistle],0],[c,[78,Whistle],0],[o,[78,Whistle],0]],[[n,[105,Banjo],0],[v1,[105,Banjo],1],[i1,[105,Banjo],1],[v2,[105,Banjo],1],[c,[105,Banjo],0],[t2,[105,Banjo],0],[s,[105,Banjo],1],[c,[105,Banjo],0],[o,[105,Banjo],0]],[[n,[113,Agogo],0],[v1,[113,Agogo],1],[i1,[113,Agogo],1],[v2,[113,Agogo],0],[c,[113,Agogo],0],[t2,[113,Agogo],1],[s,[113,Agogo],1],[c,[113,Agogo],0],[o,[113,Agogo],1]]],[[[n,[45,Pizzicato Strings],0],[v1,[45,Pizzicato Strings],0],[i1,[45,Pizzicato Strings],0],[v2,[45,Pizzicato Strings],0],[c,[45,Pizzicato Strings],1],[t2,[45,Pizzicato Strings],0],[s,[45,Pizzicato Strings],0],[c,[45,Pizzicato Strings],1],[o,[45,Pizzicato Strings],0]],[[n,[58,Tuba],1],[v1,[58,Tuba],0],[i1,[58,Tuba],1],[v2,[58,Tuba],0],[c,[58,Tuba],0],[t2,[58,Tuba],1],[s,[58,Tuba],1],[c,[58,Tuba],0],[o,[58,Tuba],0]],[[n,[38,Synth Bass 1],1],[v1,[38,Synth Bass 1],1],[i1,[38,Synth Bass 1],0],[v2,[38,Synth Bass 1],1],[c,[38,Synth Bass 1],1],[t2,[38,Synth Bass 1],0],[s,[38,Synth Bass 1],0],[c,[38,Synth Bass 1],1],[o,[38,Synth Bass 1],0]]],[0,Acoustic Grand Piano]
Caution: follow instructions in https://github.com/luciangreen/listprologinterpreter/blob/master/Instructions_for_Using_texttobr(2).pl.txt when using texttobr, texttobr2 or mind reader to avoid medical problems.
