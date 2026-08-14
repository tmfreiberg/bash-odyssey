# bash-odyssey

*Nostos* — a text adventure that teaches the Unix command line.

Troy has fallen. You are Odysseus, and you are going home to Ithaca.
It should take a few weeks. It is going to take ten years.

There is no game engine here. The story is a directory of text files,
and you play it by moving around and reading them with real commands.
When six men die at Ismarus, you delete six files. When the Cyclops
asks your name, you rename one. Everything you learn works on a real
machine, because it *is* a real machine.

Thirteen episodes. Twenty-six commands.

## Requirements

Linux, macOS, or Windows with **Git Bash** (which ships with
[Git for Windows](https://gitforwindows.org/)). Nothing else to
install, and nothing to run but the shell you already have.

### Windows: use Git Bash, not CMD or PowerShell

This will not run in the black `C:\>` window. Git Bash is a different
shell that comes with Git for Windows.

The easiest way in: right-click the folder in File Explorer and choose
**"Open Git Bash here"** — on Windows 11 you may need **"Show more
options"** first.

You are in the right shell when the prompt ends in a `$` and looks
something like this:

```
you@YOURPC MINGW64 ~/bash-odyssey
$
```

If it looks like `C:\Users\you\bash-odyssey>` instead, you are in CMD
and nothing here will work. Note that paths in Git Bash use forward
slashes, and your `C:` drive appears as `/c/`.

One command behaves differently on Windows: `chmod` can take away
permission to write a file, but not permission to read one. The scroll
that teaches it says so, and shows you how to check for yourself.

## Start

```
git clone https://github.com/thfreiberg/bash-odyssey.git
cd bash-odyssey
chmod +x begin.sh
./begin.sh
cd play
```

To read a file, type `less` followed by its name, then press `q` to
quit:

```
less start_here.txt
```

That is the only command you get for free. The rest are in `scrolls/`,
and the story tells you when you need them.

The `./` in `./begin.sh` is not decoration — it means "the script in
this directory". You will find out why in due course.

## Starting over, and other housekeeping

`canon/` is the original story and is never modified. `play/` is your
copy of it, made by `begin.sh` with a single `cp -R`. Everything you
do happens in `play/`, and nothing you do there is undoable, which is
the point.

```
./begin.sh --restart         throw the voyage away, deal a fresh one
./begin.sh --refresh circe   put one island back the way you found it
./begin.sh --update          pick up new islands without losing your game
```

`--refresh` is for replaying a single episode you liked. `--update` is
for the case where you have pulled a newer version of this repo
mid-voyage: it copies over anything that did not exist when you
started, refreshes the scrolls, and leaves your ship, your crew, and
your log exactly as they are.

## What it covers

This is a small slice of the basics — roughly what *The Linux Command
Line* by William Shotts covers in its early chapters, which is
[free to read online](https://linuxcommand.org/tlcl.php) and is the
book to go to next. The first few episodes follow its running order
fairly closely; after that the story decides, so `find` turns up long
before Shotts reaches it and `alias` waits until the very end, where
it belongs for other reasons.

| Episode | Commands |
|---|---|
| Ismarus | `pwd` `ls` `less` `cd` `mv` `cp` `rm` `cat` `>` `>>` |
| The Lotus-Eaters | `grep` |
| The Cyclops | `ls -a` |
| Aeolus | wildcards — `*` `?` `[]` `[!]` |
| The Laestrygonians | `ls -R` `\|` `wc` `rm -r` `rmdir` |
| Circe | `mkdir` `echo` |
| The Underworld | `head` `tail` `sort` |
| The Sirens | regular expressions, `grep -n -c -v -E` |
| Scylla and Charybdis | `find` |
| Thrinacia | `chmod` `cp -R` |
| Calypso | `history` `!n`, brace expansion, `touch` |
| Phaeacia | `tee` |
| Ithaca | `ls -lt` `diff` `diff -r` `alias` |

## A note on the text

The story is Homer's, and Homer has been out of copyright for about
twenty-seven centuries.

The prose is not Homer's. It was written with Claude, over a long
back-and-forth of drafting, argument, and correction, then checked
against the poem. None of it is adapted from, or derived from, any
translation — not Fagles, not Lattimore, not Wilson, not Butler, none
of them. Nothing was consulted while writing but the events of the
narrative, which belong to nobody.

Where the *Odyssey* is silent — the names of ordinary crewmen, what a
man thinks about on a hillside — this fills the gap and tries not to
contradict anything. Fourteen of the twenty men on the roster are
invented, and they are written thin on purpose. You will understand
why on the first night.

## Licence

Two licences, one for each half of the thing. The scripts — `begin.sh`
and the bow — are MIT. The writing is
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/): use it,
change it, teach with it, sell it, as long as you say where it came
from.

See [LICENSE](LICENSE) for both, plus a note on why Homer needs no
licence at all.