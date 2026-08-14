#!/bin/sh
# The bow of Iphitus. It will not string for a man it does not know.

cd "$(dirname "$0")/../.." 2>/dev/null || true

echo
echo "  You take it out of the case. The horn has not cracked."
echo "  Twenty years in a store room. Somebody oiled it."
echo

found=""
[ -f ithaca/beggar/.nobody ] && found="ithaca/beggar/.nobody"
[ -f ship/crew/odysseus.txt ] && found="ship/crew/odysseus.txt"
[ -f cyclops/cave/outis.txt ] && found="cyclops/cave/outis.txt"

if [ -z "$found" ]; then
    echo "  Nothing. The horn will not come round."
    echo
    echo "  There is no name anywhere on this island for this bow"
    echo "  to belong to. You gave it away in a cave a long time"
    echo "  ago, or you left it somewhere, or you removed it."
    echo
    echo "  Find it. Then come back:"
    echo
    echo "      find . -name '*odysseus*' -o -name '*outis*' -o -name '.nobody'"
    echo
    exit 1
fi

echo "  It comes round in your hands without effort, the way a"
echo "  singer bends a new string over the peg of a lyre."
echo
echo "  You put the string on. You test it with your thumb."
echo "  It sings under your hand like a swallow."
echo
echo "  ( the bow answers to: $found )"
echo
echo "  Zeus thunders outside, once, in a clear sky."
echo
echo "  The arrow goes through all twelve axe heads without"
echo "  touching one of them."
echo
echo "  Then you say, to your son, quietly, without getting up:"
echo "      the guests would like their dinner."
echo
exit 0
