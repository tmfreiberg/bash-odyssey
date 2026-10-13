#!/bin/sh
# Checks that the story under canon/ holds together: every path a story
# file tells the player to use exists (or is one the player creates),
# nothing outside play/ is named without ../, minor characters who may
# already be dead are not named later, and every file ends in a newline
# and is stored with LF endings. Run from the repository root:
#
#     sh .github/check-story.sh
#
# Exits 1 on the first kind of problem it reports, after listing them.

set -eu
cd "$(dirname "$0")/.."

status=0
fail() { echo "FAIL: $1"; status=1; }

# Paths the story asks the player to create; they are absent from canon/
# by design. Add to this list when new text asks for a new file.
player_made='
circe/house/sty
circe/oath.txt
ithaca/beggar
ithaca/beggar/.nobody
ithaca/my_bed.txt
lotus/inland/eaters/elpenor.txt
lotus/inland/eaters/perimedes.txt
lotus/inland/eaters/polites.txt
ogygia/oath.txt
ogygia/raft
ogygia/raft/plank_
phaeacia/gifts
phaeacia/hall/told.txt
ship/crew/somebody.txt
ship/crew/telemachus.txt
ship/hold/maron_wine.jar
thrinacia/herd_as_found
thrinacia/oath_sworn.txt
underworld/trench_offering.txt
'

# 1. Every path in a story command resolves from the top of play/.
#    Paths reached with ../ (canon/, begin.sh) are outside play/ and are
#    checked by step 2 instead.
missing=$(
    cd canon &&
    grep -rhE '^    (less|cat|ls|head|tail|sort|wc|diff|bash|grep|find|mv|cp|rm|touch|mkdir|chmod) ' \
        --include='*.txt' --exclude-dir=scrolls . |
    grep -oE '(\.\./)?[a-z_]+/[A-Za-z0-9_./-]*[A-Za-z0-9_]' | grep -v '^\.\./' | sort -u |
    while read -r p; do
        [ -e "$p" ] && continue
        printf '%s\n' "$player_made" | grep -qxF "$p" || echo "$p"
    done
)
[ -z "$missing" ] || fail "story points at paths that do not exist:
$missing"

# 2. canon/ and begin.sh sit outside play/, so a story file names them
#    with ../ in front.
outside=$(grep -rnE '^ {4}(.*[ =])?(\./)?(canon|begin\.sh)( |/|$)' \
    --include='*.txt' --exclude-dir=scrolls canon || true)
[ -z "$outside" ] || fail "names canon/ or begin.sh without ../ (the player is in play/):
$outside"

# 3. The fourteen invented crewmen may have died at Ismarus, so no later
#    file may name them. Their own files and the scrolls are exempt.
strangers=$(grep -rliwE 'agathon|bianor|halios|hyrtios|kritos|ktesios|laodes|nomion|orsilochos|pheres|phrontis|talthios|thoas|xenon' canon |
    grep -vE '^canon/(ship/crew|scrolls)/' || true)
[ -z "$strangers" ] || fail "names a crewman who may already be dead:
$strangers"

# 4. Every tracked text file ends in a newline.
# shellcheck disable=SC2016  # the inner script is single-quoted on purpose
nonl=$(git ls-files -z | xargs -0 sh -c '
    for f; do [ -s "$f" ] && [ "$(tail -c1 "$f" | od -An -tx1 | tr -d " ")" != 0a ] && echo "$f"; done
    ' sh || true)
[ -z "$nonl" ] || fail "files without a final newline:
$nonl"

# 5. Everything is stored with LF endings.
crlf=$(git ls-files --eol | grep -v '^i/lf' || true)
[ -z "$crlf" ] || fail "files not stored with LF endings:
$crlf"

[ "$status" -eq 0 ] && echo "story checks passed"
exit "$status"
