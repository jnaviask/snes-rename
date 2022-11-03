#!/bin/bash
extract-songs() {
  for f in ./*.rsm
  do
      mkdir "${f%.rsn}"
      unrar e "$f" "${f%.rsn}/"
  done
}

rename-folders() {
  for D in ./*
  do
    if [ -d "${D}" ]; then
      files=($D/*.spc)
      f="${files[0]}"
      sng=$(java -jar spctag/spctag.jar "$f" | grep "Game title" | sed 's/Game title\: //')
      rootdn=$(dirname ${D})
      echo "${rootdn}/${sng}"
      mv "${D}" "${rootdn}/${sng}"
    fi
  done
}

rename-songs() {
  for f in ./**/*.spc
  do
    dn=$(dirname $f)
    fn=$(basename $f .spc)
    nn=$(echo "$fn" | sed -e 's/.*-//')
    sng=$(java -jar spctag/spctag.jar -v "$f" | grep "Song title" | sed 's/Song title\: //')
    newf="${dn}/${nn} - ${sng}.spc"
    echo "${newf}"
    mv "$f" "${newf}"
  done
}

extract-songs()
rename-folders()
rename-songs()
