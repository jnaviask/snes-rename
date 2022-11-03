# Introduction

[SNESmusic](http://snesmusic.org/v2/) is a resource containing over 1000 original SNES soundtracks, in original SPC format.

On downloading these files, you might notice that SPC is an [arcane format](http://www.vgmpf.com/Wiki/index.php?title=SPC). The files come in archives named like `abr.rsn`, containing filenames like `abr-01.spc`.

The intent of this project is to create a series of BASH scripts, using the excellent [SPCTag](https://github.com/ullenius/spctag) util, to rename the files and folders into a human-readable form.

# Usage

As a prerequisite, you must have `unrar` and `Java` installed on your machine. My Java version is `openjdk 18.0.2 2022-07-19`, but other versions will likely work as well.

1. Grab the rsn file collection, either from the [SNESmusic torrent](http://snesmusic.org/v2/torrent.php), or from [archive.org](https://archive.org/details/OriginalMusicFilesOf1519SNESGames). If using the latter, extract the contents.
2. Place all `.rsn` files in this folder.
3. Run `chmod +x ./snes-rename.bash && ./snes-rename.bash` and wait. It will take quite a while to process, as it reads tag data from every file to produce new titles. **Note that this operation is destructive, as it edits filenames in place!**
4. Grab an [SPC player](http://snesmusic.org/v2/players.php) and enjoy!

# Technical Details

The [snes-readme.bash](snes-readme.bash) file contains 3 brief scripts.

1. `extract-songs` simply extracts the contents of all the .rsn files using `unrar`.
2. `rename-folders` reads the tag data of the first `.spc` file in each folder to produce a new directory name.
3. `rename-songs` reads the tag data of every `.spc` file to produce new song titles, maintaining the track number from the original filename.

To only run a subset of these scripts, comment out the function calls at the end of the file as needed.

# Additional Notes

The `rename-songs` script could likely be optimized by using a batch call to `spctag` rather than re-running it on every file name. If you feel like tackling this challenge, submit a PR!

Broader configurability would also be nice (specifying a file or folder name, verbose or not verbose, locations for `spctag`, etc), but I'm lazy and didn't want to write an argument structure. Again, feel free to submit a PR!
