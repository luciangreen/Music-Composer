# Music Composer

Music Composer can help automate writing pop songs in three modes.  It outputs the lyrics text file, the asc2mid text file and a MIDI music file.

1. Manual entry of form, lyrics, melody, harmony, instruments, parts that the melody plays in and parts that the harmony plays in.

2. Random generation of the creative choices.

3. Mind reading mode.

# Getting Started

Please read the following instructions on how to install the project on your computer for writing music.

# Prerequisites

* Please download and install SWI-Prolog for your machine at `https://www.swi-prolog.org/build/`.

* Requires asc2mid (http://www.archduke.org/midi/, compile with a C compiler before running.
```
gcc asc2mid.c -o asc2mid
```
* Call application "asc2mid").

* Optional: Search for and download backdated version 6.0.5 of GarageBand and AlterEgo singing voice synthesis plug-in for old GarageBand for Mac or on Windows (https://www.plogue.com/downloads.html).

# 1. Install manually

Download <a href="http://github.com/luciangreen/Music-Composer/">this repository</a>, the <a href="https://github.com/luciangreen/listprologinterpreter">List Prolog Interpreter Repository</a> and the <a href="https://github.com/luciangreen/mindreader">Mind Reader Repository</a>.

# 2. Or Install from List Prolog Package Manager (LPPM)

* Download the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>:

```
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
['lppm'].
lppm_install("luciangreen","Music-Composer")
halt
```

# Running

* In Shell:
`cd Music-Composer`
`swipl`

* Enter the following to manually enter creative choices:
`['mindreadtestmusiccomposer-unusual-4-userinput'].`    

* Enter the following to randomly generate 3-note progressions:
`['mindreadtestmusiccomposer-unusual-3'].`    

* Enter the following to randomly generate 4-note progressions:
`['mindreadtestmusiccomposer-unusual-4'].`    

* Before running texttobr-based mind reader, think of two radio buttons put on recordings, put through with prayer, nut and bolt, quantum box prayer 1, 1, 0.5 cm and 1, 1, 0.5 cm.

* Follow instructions in https://github.com/luciangreen/listprologinterpreter/blob/master/Instructions_for_Using_texttobr(2).pl.txt when using texttobr, texttobr2 or mind reader to avoid medical problems.

* Please follow instructions in <a href="https://github.com/luciangreen/mindreader/blob/master/init.txt">init.txt</a> to initialise any new mind-reading algorithms.

* Enter the following to mind read songs with 4-note progressions:
`['mindreadtestmusiccomposer-unusual-4-mr'].`    

* Enter the following to *detailedly* mind read songs with 4-note progressions:
`['mindreadtestmusiccomposer-unusual-4-mr-tree.pl'].`

* Running the algorithm
To generate the song:
`sectest0(Form1,Lyrics,Melody,Harmony,MelodyParts,HarmonyParts,Vocalstubinstrument,Song1).`

To output the possible chord progressions from one note to another:
`versechorussoloprogression1451('C','D',Progression),writeln1(Progression).`
`versechorussoloprogression1564('C','D',Progression),writeln1(Progression).`
`versechorussoloprogression1645('C','D',Progression),writeln1(Progression).`
`classicalcomposition('C','D',Progression),writeln1(Progression).`
`popclassicalcomposition('C','D',Progression),writeln1(Progression).`

# Rescuing Format Files with asc2mid

If the file `song***.txt` is produced but the `.mid` file is not, you may use asc2mid to produce the `.mid` file. In Shell:

```
./asc2mid song***.txt > song***.mid
```

# Note on Mind Reader

Mind Reader is currently not configured to display screens and accurately mind read decisions.  It detects vague, not exact thoughts.

* If necessary, repeat the "arem" mantra all the time while the mind reading computation is running to ensure the best results.

# Versioning

We will use SemVer for versioning.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the LICENSE.md file for details
