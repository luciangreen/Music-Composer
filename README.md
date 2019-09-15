# Music Composer

Music Composer can help automate writing pop songs in three modes.  It outputs the lyrics text file, the asc2mid text file and a MIDI music file.

1. Mind Reading Mode (currently untested and switched off because it can be done using option 2).

2. Manually entering the creative choices.

3. Randomly generating form, lyrics, melody, harmony, parts that the melody plays in, parts that the harmony plays in and the vocal stub instrument.

# Getting Started

Please read the following instructions on how to install the project on your computer for writing code.

# Prerequisites

Please download and install SWI-Prolog for your machine at https://www.swi-prolog.org/build/.

Please download Lucian Green's List Prolog Interpreter Repository at https://github.com/luciangreen/listprologinterpreter.

Requires asc2mid (http://www.archduke.org/midi/, compile with a C compiler before running, call application "asc2mid").

Optional: Search for and download backdated version 6.0.5 of GarageBand and AlterEgo singing voice synthesis plug-in for old GarageBand for Mac or on Windows (https://www.plogue.com/downloads.html).

# Installing

* Download the repository to your machine.
In the SWI-Prolog environment, enter the following to manually enter creative choices:
`['mindreadtestmusiccomposer-unusual-4-userinput'].`    

* Enter the following to randomly generate 3-note progressions:
`['mindreadtestmusiccomposer-unusual-3'].`    

* Enter the following to randomly generate 4-note progressions:
`['mindreadtestmusiccomposer-unusual-4'].`    

* Running the algorithm
To generate the song:
`sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1).`

To output the possible chord progressions from one note to another:
`versechorussoloprogression1451('C','D',Progression).`
`versechorussoloprogression1564('C','D',Progression).`
`versechorussoloprogression1645('C','D',Progression).`
`classicalcomposition('C','D',Progression).`
`popclassicalcomposition('C','D',Progression).`

# Versioning

We will use SemVer for versioning.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the LICENSE.md file for details
