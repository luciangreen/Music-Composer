# Music-Composer
Music Composer can (optionally mind read to) create songs.  Currently set to generate song elements randomly, not mind read them.  Requires precautions to run because runs texttobr to give song elements As.

Install and load by typing ['mindreadtestmusiccomposer-unusual-3']. for 3-note progressions and
['mindreadtestmusiccomposer-unusual-4']. for 4-note progressions.

Requires asc2mid (http://www.archduke.org/midi/, compile with a C compiler before running, call application "asc2mid").

Optional: Search for and download backdated version 6.0.5 of GarageBand and AlterEgo singing voice synthesis plug-in for old GarageBand for Mac or on Windows (https://www.plogue.com/downloads.html).

* Note: see bottom of page (new version's run command is there with install instructions).

Run with sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1),writeln(sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1)).

Takes no input and outputs text and MIDI music files.  Please don't close the window after running, to save the lyrics.

Caution: follow instructions in https://github.com/luciangreen/listprologinterpreter/blob/master/Instructions_for_Using_texttobr(2).pl.txt when using texttobr, texttobr2 or mind reader to avoid medical problems.

* ['mindreadtestmusiccomposer-unusual']. - run with sectest(2). for e.g 2 songs in unusual (not same parts for same sections).
This version requires my List Prolog GitHub Repository.  This version is a more recent version than mindreadtestmusiccomposer.
Includes texttobr2'ing out music notes and lyrics files, so you may need to comment this part out.