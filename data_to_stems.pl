:-include('../listprologinterpreter/la_files.pl').
:-include('../listprologinterpreter/la_maths.pl').
:-include('../listprologinterpreter/la_strings.pl').
:-include('../listprologinterpreter/la_strings_string.pl').

data_to_stems :-

	directory_files("data_files/",F),
	delete_invisibles_etc(F,G),

	findall([Filex1,Header,Footer,Instruments],(member(Filex1,G),
	string_concat("data_files/",Filex1,Filex),
		phrase_from_file_s(string(File_codes), Filex),
		%string_codes(File_string,File_codes),
		%atom_to_term(String02b,Data_file,[])

	%A=`b i `,
%trace,
	ba(File_codes, Header,Footer,Middle),
	%string_codes(Middle2,Middle),
	%trace,writeln1(Middle2),
		% retrieve data to make stem files
%length(B,6),
%foldr(B,Middle,_)
%trace,
	%writeln1(split_on_instrument(Middle,[],Instruments)),
	%trace,
	split_on_instrument(Middle,[],Instruments)		%,
		%writeln(	split_on_instrument(Middle,[],Instruments))
		%
		),String00),

%writeln(String00),
	findall(_,(member([File,Header,Footer,Instruments],String00),

	length(Instruments,Length),
	numbers(Length,1,[],Ns),
		
	findall(_,(member(N,Ns),get_item_n(Instruments,N,Instrument),
	foldr(string_concat,[Header,Instrument,Footer],"",File1),
	%trace,
	File=File2,
	%string_concat(File2,".txt",File),
	foldr(string_concat,["stems/",File2,"-","stem",N,".txt"],"",File_name),
	save_file_s(File_name,File1)),_)),_),!.

ba(File_codes, Header,Footer,Middle) :-
%trace,

	A=`BA    1   CR         0   TR  1   CH  1   Instrument `,

	append(Header2,D2,File_codes),
	string_codes(Header,Header2),
	append(A,D,D2),
%trace,	
	foldr(append,[A,D],[],D4),
	reverse(D4,File_codes_reversed),
	append(Footer1,D3,File_codes_reversed),
	append(`\n`,_D1,D3),
	reverse(Footer1,Footer2),
	string_codes(Footer,Footer2),

	foldr(append,[%`\n`,
	D3],[],E),
	reverse(E,Middle),
	!.

split_on_instrument(Middle,Instruments1,Instruments2) :-
	A=`Instrument`,
	%writeln(Middle),
	%trace,
	
	%A=[i],
	append(B,C22,Middle),
	append(A,C12,C22),
	%trace,
	%writeln(here1),
		
	(not((append(_B11,C11,C12),append(A,_C31,C11)))->
	(string_codes(Middle1,Middle),
	append(Instruments1,[Middle1],Instruments2));
%split_on_instrument(Middle,Instruments1,Instruments2) :-
	(%A=`Instrument `,
	%trace,
	%append(_B10,C2,Middle),
	%append(A,C,C2),
	%trace,
	append(B1,C3,C12),
	append(A,C1,C3),
	
	
	%writeln(here2),
	%trace,
	%reverse(B1,B_reversed),
	%append(Start_of_instrument1,D3,B_reversed),
	append(D33,Start_of_instrument1,B1),
	reverse(D33,D3),
	
	reverse(D3,D31),
	
	
	%writeln(here3),
	
	append(`\n`,_D1,D3),
	append(End_of_instrument1,D22,C1),
	
	foldr(append,[B,A,D31],[],D32),
	
	append(`\n`,D21,D22),
	%trace,
	End_of_instrument1=End_of_instrument,
	%reverse(End_of_instrument1,End_of_instrument),
	%reverse(D21,D2),
	D21=D2,

	%writeln(here4),
	%trace,
	reverse(Start_of_instrument1,Start_of_instrument2),
	append(B41,C4,Start_of_instrument2),
	append(`\n`,C41,C4),
	reverse(B41,B412),
	reverse(C4,C42),
	reverse(C41,C412),


	reverse(Start_of_instrument1,Start_of_instrument),
	

	foldr(append,[B412,A,C1%Start_of_instrument1,A,C1
	],[],Instrument1),
	Instrument1=Instrument2,
	%*/
	D34=D32,

	foldr(append,[D34,C42],[],D441),

	string_codes(D44,D441),

	append(Instruments1,[D44],Instruments31),
	%flatten(Instruments31,Instruments32),
	/*
	writeln([b412,B412]),
	writeln([c42,C42]),
	writeln([c412,C412]),
	writeln([b41,B41]),
	writeln([c4,C4]),
	writeln([c41,C41]),
	writeln([d3,D3]),
	writeln([b,B]),
	writeln([c22,C22]),
	writeln([c12,C12]),
	writeln(C12),
	writeln([c1,C1]),
	writeln([b1,B1]),
	writeln([d32,D32]),
	writeln([start_of_instrument1,Start_of_instrument1]),
	writeln([end_of_instrument1,End_of_instrument1]),
	%trace,
	%append()
	writeln(split_on_instrument(Instrument1,Instruments31,Instruments2)),
	*/
	split_on_instrument(Instrument1,Instruments31,Instruments2))),!.

stems_to_mid :-

	check_asc2mid,
	
	directory_files("stems/",F),
	delete_invisibles_etc(F,G),

	findall(_,(
	
	member(File,G),
	
	string_concat(File1,".txt",File),
	
	foldr(string_concat,["./asc2mid stems/",File," > mid/",File1,".mid"],Command),
	
	shell1_s(Command)

	),_),!.
