# Music Composer

Music Composer can help automate writing pop songs in three modes.  It outputs the lyrics text file, the asc2mid text file and a MIDI music file.

1. Manual entry of form, lyrics, melody, harmony, instruments, parts that the melody plays in and parts that the harmony plays in.

2. Random generation of the creative choices.

3. Mind reading mode.

# Getting Started

Please read the following instructions on how to install the project on your computer for writing music.

# Prerequisites

Please download and install SWI-Prolog for your machine at https://www.swi-prolog.org/build/.

Please download Lucian Green's List Prolog Interpreter Repository at https://github.com/luciangreen/listprologinterpreter.

Requires asc2mid (http://www.archduke.org/midi/, compile with a C compiler before running, call application "asc2mid").

Optional: Search for and download backdated version 6.0.5 of GarageBand and AlterEgo singing voice synthesis plug-in for old GarageBand for Mac or on Windows (https://www.plogue.com/downloads.html).


# Installation from List Prolog Package Manager (LPPM)

* Optionally, you can install from LPPM by installing <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a> for your machine, downloading the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>, loading LPPM with `['lppm'].` then installing the package by running `lppm_install("luciangreen","Music-Composer").`.  Requires additional part below.

# Installing

* Download the repository to your machine.
In the SWI-Prolog environment, enter the following to manually enter creative choices:
`['mindreadtestmusiccomposer-unusual-4-userinput'].`    

* Enter the following to randomly generate 3-note progressions:
`['mindreadtestmusiccomposer-unusual-3'].`    

* Enter the following to randomly generate 4-note progressions:
`['mindreadtestmusiccomposer-unusual-4'].`    

* Before running texttobr-based mind reader, think of two radio buttons put on recordings, put through with prayer, nut and bolt, quantum box prayer 1, 1, 0.5 cm and 1, 1, 0.5 cm.

* Follow instructions in https://github.com/luciangreen/listprologinterpreter/blob/master/Instructions_for_Using_texttobr(2).pl.txt when using texttobr, texttobr2 or mind reader to avoid medical problems.

* Please follow instructions in init.txt to initialise any new mind-reading algorithms.

* Enter the following to mind read songs with 4-note progressions:
`['mindreadtestmusiccomposer-unusual-4-mr'].`    

* Running the algorithm
To generate the song:
`sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1).`

To output the possible chord progressions from one note to another:
`versechorussoloprogression1451('C','D',Progression).`
`versechorussoloprogression1564('C','D',Progression).`
`versechorussoloprogression1645('C','D',Progression).`
`classicalcomposition('C','D',Progression).`
`popclassicalcomposition('C','D',Progression).`

# Note on Mind Reader

Mind Reader is currently not configured to display screens and accurately mind read decisions.  It detects vague, not exact thoughts.

* If necessary, repeat the "arem" mantra all the time while the mind reading computation is running to ensure the best results.

# Versioning

We will use SemVer for versioning.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the LICENSE.md file for details
