#! bash

FILE=/dev/urandom
SLEEP_TIME=1
MODIFIED_TEXT=false
MODIFIED_FILE=false
TEXT=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -s|--sleep-time)
      SLEEP_TIME=$2
      shift 2
      ;;
    --startup)
      # TODO: echo this on sytemd / shell startup
      # Can use bashrc or systemd(latest need root priviled)
      SET_ON_STARTUP=true
      ;;
    -f|--file)
      MODIFIED_FILE=true
      FILE=$2
      shift 2
      ;;
    --anonymous)
      PREDEFINED_TEXT="We are Anonymous. We are Legion. We do not forgive. We do not forget. Expect us."
      PREDEFINED_TEXT_SET=true
      shift 1
      ;;
    --anonymous2)
      PREDEFINED_TEXT="We share the collective idea of ANONYMOUS worldwide; we are the people. We believe in non-violent, peaceful civil disobedience."
      PREDEFINED_TEXT_SET=true
      shift 1
      ;;
    --anonymous3)
      PREDEFINED_TEXT="The corrupt fear us. The honest support us. The heroic join us."
      PREDEFINED_TEXT_SET=true
      shift 1
      ;;
    *)
      TEXT+="$1 "
      MODIFIED_TEXT=true
      shift 1
      ;;
  esac
done

if [[ $# -eq 2 ]]; then
  SLEEP_TIME=$2
fi

function espeak_prank() {

  sleep $2

  if $MODIFIED_FILE; then
    espeak < $FILE &> /dev/null
  elif [[ $MODIFIED_TEXT || $PREDEFINED_TEXT_SET ]] ; then
    if $PREDEFINED_TEXT_SET; then
      echo $PREDEFINED_TEXT | espeak &> /dev/null
    fi
    echo $TEXT | espeak &> /dev/null
  else 
    espeak < $FILE &> /dev/null
  fi
}

# For testing
# sleep 5 && killall espeak & echo ""

espeak_prank $FILE $SLEEP_TIME &
