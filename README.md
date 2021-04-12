# polyscript
Polyglot shell script (sh, bat/batch, powershell)

I was slightly obsessed with polyglot files the last week; [polyshell](https://github.com/llamasoft/polyshell) impressed me, but it bugged me that the BAT version printed "gibberish" on its first line. Could it be possible to get `@ECHO OFF` working on the first line? After a couple of dead ends, I was able to make it work! See the [source](polyscript.sh) file.

![Polyscript on Windows](https://github.com/tingstad/polyscript/blob/main/polyscript.png)

The challenge is that the first character has to be `@`, so PowerShell's `try` cannot be set up (it doesn't have `||`). We also need to execute `ECHO OFF` in Batch of course, and everything has to be valid syntax in all three languages, naturally.

The trick is to use PowerShell's [hash table](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-5.1) syntax; `@{key=value}`. Output and errors are redirected to `null` (both Shell and Cmd will complain about unknown command), and I added a couple of `||` to reset the return code/errorlevel.

For the rest of the file, I wanted to have some common code, and some interpreter specific code. I also wanted to try using less `echo` and `<<HEREDOC` than most scripts, just for fun. I ended up using `if`, which exists in all languages.

Tested on PowerShell 2.0 and 7.1, Windows Cmd 6.1, Bash 3.2 and 5.0, and Dash.

## Explanation

Each language doesn't care what's inside a string or comment, let's replace those with `_`:

```
     @{a="\"} >$null # " 2>/dev/null || true #" >NUL 2>&1 || TYPE NUL & ECHO OFF
     ···········································································
PS   @{a="_"} >$null #__________________________________________________________
Sh   @{a="_____________" 2>/dev/null || true #__________________________________
Bat  @{a="_"} >$null _ "______________________" >NUL 2>&1 || TYPE NUL & ECHO OFF

```

## Links

* [Polyshell](https://github.com/llamasoft/polyshell): Similar to this repo
* [polyglot.bat](https://gist.github.com/prail/24acc95908e581722c0e9df5795180f6): Bash/Bat file. Inspirational `GOTO`.
* [Batsh](https://github.com/batsh-dev-team/Batsh): A language that compiles to Bash and Windows Batch
* [Hyperpolygot](https://hyperpolyglot.org/shell): Side-by-side command line interpreters reference
* [SS64](https://ss64.com/): Command line reference
* [printimage.c](https://gist.github.com/jart/7428b2b955dfd6eff7b6d31e00414508): Bash/C file, I like `/*bin/echo '` :)
* [script.clj](https://gist.github.com/ericnormand/6bb4562c4bc578ef223182e3bb1e72c5) Clojure shell script
