Import-Module .\VICTermDates.psm1 -Force


$tests = @{
    "01/01/2012" = "ERROR"
    "01/01/2026" = "ERROR"
    
    "01/01/2019" = $false
    "28/01/2019" = $false
    "29/01/2019" = $true
    "05/02/2019" = $true
    "05/04/2019" = $true
    "06/04/2019" = $false

    "01/01/2015" = $false
    "28/01/2015" = $true
    "29/01/2015" = $true
    "05/02/2015" = $true
    "05/04/2015" = $false
    "06/04/2015" = $false
    "20/04/2015" = $true

    "25/12/2019" = $false
    "20/12/2019" = $true
    "21/12/2019" = $false
    "27/01/2020" = $false
    "28/01/2020" = $true
}

foreach ($test in $tests.Keys){
    try{
        $test_results = Test-VICTermDates -TestDate (Get-Date $test) -SimpleResults
    } catch {
        if ($tests.$test -eq "ERROR"){
            Write-Host -ForegroundColor Green "$test Sucsess (ERROR)"
            continue
        } else {
            Write-Host -ForegroundColor Red "$test is in error 1"
            break
        }
    }

    if ($tests.$test -eq $test_results) {
        Write-Host -ForegroundColor Green "$test Sucsess"
    } else {
        Write-Host -ForegroundColor Red "$test is in error 2"
        break
    }
}

break