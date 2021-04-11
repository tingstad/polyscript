#!/usr/bin/env bash
set -eEu -o pipefail

run_tests() (
    { #Shell
        output="$(./polyscript.sh 2>&1)"
        assert_equal "$output" "$(cat <<-EOF
			Hello
			I AM A SHELL SCRIPT
			Bye
			EOF
        )"
    }
)

assert_equal() {
    [ "$1" == "$2" ] || {
        printf "> Expected:\n%s\n> to equal:\n%s\n" "$1" "$2" >&2
        exit 1
    }
}

run_tests

echo OK

