function Write-AsciiArtBanner {
    param (
        [string]$Text
    )
    $windowWidth = $Host.UI.RawUI.WindowSize.Width
    $bannerLine = "=" * $windowWidth
    $padding = ($windowWidth - $Text.Length) / 2
    $leftPadding = [int]$padding
    $rightPadding = [int]($windowWidth - $Text.Length - $leftPadding)

    Write-Host $bannerLine -ForegroundColor Red
    Write-Host ("{0}{1}{2}" -f (" " * $leftPadding), $Text, (" " * $rightPadding)) -ForegroundColor Red
    Write-Host $bannerLine -ForegroundColor Red
    Write-Host ""
}

function Write-AsciiArtNumber {
    param (
        [int]$Number
    )

    $numberStr = $Number.ToString()
    $asciiDigits = @{
        '0' = @(
            " 0000 ",
            "00  00",
            "00  00",
            "00  00",
            " 0000 "
        )
        '1' = @(
            "1111  ",
            "  11  ",
            "  11  ",
            "  11  ",
            "111111"
        )
        '2' = @(
            " 2222 ",
            "22  22",
            "   22 ",
            "  22  ",
            "222222"
        )
        '3' = @(
            " 3333 ",
            "33  33",
            "   333",
            "33  33",
            " 3333 "
        )
        '4' = @(
            "44  44",
            "44  44",
            "444444",
            "    44",
            "    44"
        )
        '5' = @(
            "555555",
            "55    ",
            "55555 ",
            "    55",
            "55555 "
        )
        '6' = @(
            " 6666 ",
            "66    ",
            "66666 ",
            "66  66",
            " 6666 "
        )
        '7' = @(
            "777777",
            "   77 ",
            "  77  ",
            " 77   ",
            "77    "
        )
        '8' = @(
            " 8888 ",
            "88  88",
            " 8888 ",
            "88  88",
            " 8888 "
        )
        '9' = @(
            " 9999 ",
            "99  99",
            " 99999",
            "    99",
            " 9999 "
        )
    }
    $outputLines = @("", "", "", "", "")
    foreach ($char_digit in $numberStr.ToCharArray()) {
        $charKey = $char_digit.ToString()
        if ($asciiDigits.ContainsKey($charKey)) {
            $digitArt = $asciiDigits[$charKey]
            for ($i = 0; $i -lt $digitArt.Length; $i++) {
                $outputLines[$i] += $digitArt[$i] + "   "
            }
        } else {
            for ($i = 0; $i -lt $outputLines.Length; $i++) {
                $outputLines[$i] += "?????   "
            }
        }
    }

    Write-Host "Your random number is:" -ForegroundColor Red
    foreach ($line in $outputLines) {
        Write-Host $line -ForegroundColor Magenta
    }
    Write-Host ""
}
Clear-Host
Write-AsciiArtBanner -Text "RANDOM NUMBER GENERATOR"
$minNumber = $null
$maxNumber = $null
$minInput = $null
$maxInput = $null
while ($minNumber -eq $null -or -not ($minInput -match "^\d+$")) {
    $minInput = Read-Host "Enter the first (minimum) whole number"
    if ($minInput -match "^\d+$") {
        $minNumber = [int]$minInput
    } else {
        Write-Host "Invalid input. Please enter a whole number." -ForegroundColor Pink
    }
}
while ($maxNumber -eq $null -or -not ($maxInput -match "^\d+$") -or $maxNumber -lt $minNumber) {
    $maxInput = Read-Host "Enter the second (maximum) whole number (must be >= $minNumber)"
    if ($maxInput -match "^\d+$") {
        $tempMax = [int]$maxInput
        if ($tempMax -ge $minNumber) {
            $maxNumber = $tempMax
        } else {
            Write-Host "Maximum number must be greater than or equal to the minimum number ($minNumber)." -ForegroundColor Pink
            $maxInput = $null
        }
    } else {
        Write-Host "Invalid input. Please enter a whole number." -ForegroundColor Pink
    }
}
$randomNumber = Get-Random -Minimum $minNumber -Maximum ($maxNumber + 1)
Write-Host ""
Write-AsciiArtNumber -Number $randomNumber

Write-Host "======================================================================" -ForegroundColor Red
Write-Host "Done!" -ForegroundColor Green
