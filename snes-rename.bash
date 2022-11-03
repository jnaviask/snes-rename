#!/bin/bash
extract-songs() {
  for f in ./*.rsn
  do
      mkdir "${f%.rsn}"
      unrar e "$f" "${f%.rsn}/"
      rm -f "$f"
  done
}

rename-folders() {
  for D in ./*
  do
    if [ -d "${D}" ]; then
      files=($D/*.spc)
      f="${files[0]}"

      # Ensure we only rename folders containing music
      if [[ "$f" ]]; then
        # final substitution fixes games like "Ranma 1/2", which are invalid file names
        sng=$(java -jar spctag/spctag.jar "$f" | grep "Game title" | sed 's/Game title\: //' | sed 's/\//_/g')
        rootdn=$(dirname ${D})
        echo "${rootdn}/${sng}"
        mv "${D}" "${rootdn}/${sng}"
      fi
    fi
  done
}

rename-songs() {
  for f in ./**/*.spc
  do
    dn=$(dirname "$f")
    fn=$(basename "$f" ".spc")
    sng=$(java -jar spctag/spctag.jar -v "$f" | grep "Song title" | sed 's/Song title\: //')

    # Ensure we don't clobber already renamed files
    if [[ $fn != *$sng* ]]; then
      nn=$(echo "$fn" | sed -e 's/.*-//')
      if [[ "$nn" ]]; then
        newf="${dn}/${nn} - ${sng}.spc"
        echo "${newf}"
        mv "$f" "${newf}"
      else
        # handle names without track numbers, like "Unused"
        newf="${dn}/${sng}.spc"
        echo "${newf}"
        mv "$f" "${newf}"
      fi
    fi
  done
}

#extract-songs
#rename-folders
rename-songs
