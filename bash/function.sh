function findInWorkbench() {
  esc=$(printf '\033');
  day=${2:-*};
  [[ $day = "today" ]] && day=`date +%Y-%m-%d`;
  fgrep -i $1 ~/.mysql/workbench/sql_history/$day | sed "s/\(.\+\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\)\)\?.\+timestamp='\([0-9:~\.]\+\)'>\(.\+\)<\/ENTRY>/${esc}[0;35m\2 \3${esc}[0m \4/" | sed "s/&#x0A;/ /g;s/&apos;/'/g;s/&lt;/</g;s/&gt;/>/g;s/\s\s\+/ /g";
}

function manSymfony() {
  env=${1:-dev}
  commandName=`app/console --env=$env | fzf --preview 'script -efq -c "app/console --env='$env' --help \`echo {} | sed \"s/^ \+\([^ ]\+\) .\+$/\1/\"\`"' | sed 's/^ \+\([^ ]\+\) .\+$/\1/'`
  echo -n "app/console $commandName --env=$env " | xclip -sel clip
  app/console --env="$env" "$commandName" --help
}

function runSymfony() {
  app/console "$@" `app/console | fzf | sed 's/^ \+\([^ ]\+\) .\+$/\1/'`
}

function Utrack() {
  what=$(tail -n 500 ~/.local/share/utt/utt.log | grep -v hello | grep -v "^$" | sed 's/^\([0-9: -]\+\) //'|  tac | awk '!x[$0]++' | fzf --no-sort --print-query)
  if [ $(echo "$what" | wc -l) -gt 1 ]; then
    what=$(echo "$what" | tail -n 1)
  else
    what=$(echo "$what" | head -n 1)
  fi

  if [ -z "$what" ]; then
    return
  fi

  echo "$what"
  utt add "$what"
}
