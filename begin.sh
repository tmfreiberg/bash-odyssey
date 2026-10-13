#!/bin/sh
# NOSTOS -- deals the story out of canon/ into play/.
#
#   ./begin.sh              start a new voyage
#   ./begin.sh --update     add newly written islands, refresh the scrolls,
#                           leave everything you have done alone
#   ./begin.sh --refresh X  put island X back the way it was found
#   ./begin.sh --restart    throw the whole voyage away and deal again

set -eu

cd "$(dirname "$0")"

# Some things in this story are older than the voyage. cp gives every
# file the date it was copied, so the ages have to be put back by hand.
# If touch fails, the game still works; only the ls -lt lesson in
# Ithaca loses its oldest file, so say so and carry on.
age_the_world() {
    touch -d "20 years ago" play/ithaca/hall/argos.dog &&
    touch -d "20 years ago" play/ithaca/penelope_bed.txt &&
    touch -d "30 years ago" play/ithaca/orchard/boar_hunt.txt ||
    echo "Note: could not backdate three files in play/ithaca;" \
         "the ls -lt lesson there will find nothing old." >&2
}


if [ ! -d canon ]; then
    echo "Error: no canon/ directory here." >&2
    echo "Run this script from inside the bash-odyssey folder." >&2
    exit 1
fi

case "${1:-}" in

--update)
    [ -d play ] || { echo "No game in play/ yet. Run ./begin.sh"; exit 1; }
    added=""
    for d in canon/*/; do
        name=$(basename "$d")
        [ "$name" = "ship" ] && continue
        if [ ! -e "play/$name" ]; then
            cp -R "$d" play/
            added="$added $name"
        fi
    done
    cp -R canon/scrolls/. play/scrolls/
    cp -R canon/start_here.txt play/
    age_the_world
    if [ -n "$added" ]; then
        echo "New islands:$added"
    else
        echo "No new islands."
    fi
    echo "Scrolls brought up to date. Your ship and your log are untouched."
    ;;

--refresh)
    [ -d play ] || { echo "No game in play/ yet. Run ./begin.sh"; exit 1; }
    [ -n "${2:-}" ] || { echo "Which island? e.g. ./begin.sh --refresh cyclops"; exit 1; }
    # A bare episode name only: a path such as ../canon would make the
    # rm -rf below reach outside play/, and ship/ holds the player's log.
    case "$2" in
        */*|.*|ship)
            echo "Give an island by name, such as cyclops: not a path, and not ship." >&2
            exit 1 ;;
    esac
    [ -d "canon/$2" ] || { echo "No island called $2 in canon/."; exit 1; }
    printf 'This puts play/%s back the way it was found. Type yes: ' "$2"
    read -r answer
    [ "$answer" = "yes" ] || { echo "Nothing changed."; exit 0; }
    rm -rf "play/$2"
    cp -R "canon/$2" play/
    age_the_world
    echo "play/$2 restored."
    ;;

--restart)
    if [ -d play ]; then
        printf 'This deletes play/ and everything in it. Type yes: '
        read -r answer
        [ "$answer" = "yes" ] || { echo "Nothing changed."; exit 0; }
        rm -rf play
    fi
    cp -R canon play
    age_the_world
    echo "A new voyage is waiting in play/."
    ;;

"")
    if [ -d play ]; then
        echo "You already have a game in play/."
        echo
        echo "  ./begin.sh --update      add new islands, keep your voyage"
        echo "  ./begin.sh --restart     throw it away and start again"
        exit 1
    fi
    cp -R canon play
    age_the_world
    cat <<'EOF'

    NOSTOS

    Your ships are waiting in play/.

        cd play
        less start_here.txt

EOF
    ;;

*)
    echo "Unknown option: $1" >&2
    echo "Try: ./begin.sh [--update|--refresh ISLAND|--restart]" >&2
    exit 1
    ;;
esac
