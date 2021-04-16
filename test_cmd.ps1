copy polyscript.sh polyscript.bat
$expect = "Hello
I AM A BATCH SCRIPT
Bye
"
$output = cmd.exe /c polyscript.bat | Out-String
if ($output -ne $expect) {
    Write-Output "> Expected:
$($output)
> to equal:
$($expect)"
    exit 1
}
