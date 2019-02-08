<# 
 .SYNOPSIS
  A Powershell module that will tell you if a date is a during a Victorian school term or not and provide additional info if required.

 .DESCRIPTION
    By default this module returns a dictonary of three elements:
        During_Term: True for during a school term or False when it's holidays.
        Start:       This is the first day of the school or if it's a holiday the first date of the holiday period.
        End:         This is the last day of the school or if it's a holiday the end of the holiday period.

    If you just want a simple true or false use the -SimpleResults option.
 .NOTE
    This module has only been tested with australian standard date formats.
 .EXAMPLE
   # return dictonary with infomation about date provided.
   Test-VICTermDates -TestDate (Get-Date "05/02/2019")

 .EXAMPLE
   # return true as date is during a school term.
   Test-VICTermDates -TestDate (Get-Date "05/02/2019") -SimpleResults

 .EXAMPLE
   # return false as date is during a school holiday.
   Test-VICTermDates -TestDate (Get-Date "20/04/2019") -SimpleResults
#>
function Test-VICTermDates{
    param(
    [DateTime]$TestDate,
    [switch]$SimpleResults,
    [switch]$Verbose
    )

    if (-not($TestDate)){
        Write-Error "TestDate must be provided"
    }

    if ($Verbose){
        $VerbosePreference = "Continue"
    }

    #https://www.education.vic.gov.au/about/department/Pages/datesterm.aspx
    $Term_dates = [ordered]@{
        "2013" = [ordered]@{
            "Term 1" = @{
                "Start" = "29/01/2013"
                "End" = "28/03/2013"}
            "Term 2" = @{
                "Start" = "15/04/2013"
                "End" = "28/06/2013"}
            "Term 3" = @{
                "Start" = "15/07/2013"
                "End" = "20/09/2013"}
            "Term 4" = @{
                "Start" = "07/10/2013"
                "End" = "20/12/2013"}
        }
        "2014" = [ordered]@{
            "Term 1" = @{
                "Start" = "28/01/2014"
                "End" = "04/04/2014"}
            "Term 2" = @{
                "Start" = "22/04/2014"
                "End" = "27/06/2014"}
            "Term 3" = @{
                "Start" = "14/07/2014"
                "End" = "19/09/2014"}
            "Term 4" = @{
                "Start" = "06/10/2014"
                "End" = "19/12/2014"}
        }
        "2015" = [ordered]@{
            "Term 1" = @{
                "Start" = "28/01/2015"
                "End" = "27/03/2015"}
            "Term 2" = @{
                "Start" = "13/04/2015"
                "End" = "26/06/2015"}
            "Term 3" = @{
                "Start" = "13/07/2015"
                "End" = "18/09/2015"}
            "Term 4" = @{
                "Start" = "05/10/2015"
                "End" = "18/12/2015"}
        }
        "2016" = [ordered]@{
            "Term 1" = @{
                "Start" = "27/01/2016"
                "End" = "24/03/2016"}
            "Term 2" = @{
                "Start" = "11/04/2016"
                "End" = "24/06/2016"}
            "Term 3" = @{
                "Start" = "11/07/2016"
                "End" = "16/09/2016"}
            "Term 4" = @{
                "Start" = "03/10/2016"
                "End" = "20/12/2016"}
        }
        "2017" = [ordered]@{
            "Term 1" = @{
                "Start" = "30/01/2017"
                "End" = "31/03/2017"}
            "Term 2" = @{
                "Start" = "18/04/2017"
                "End" = "30/06/2017"}
            "Term 3" = @{
                "Start" = "17/07/2017"
                "End" = "22/09/2017"}
            "Term 4" = @{
                "Start" = "09/10/2017"
                "End" = "22/12/2017"}
        }
        "2018" = [ordered]@{
            "Term 1" = @{
                "Start" = "29/01/2018"
                "End" = "29/03/2018"}
            "Term 2" = @{
                "Start" = "16/04/2018"
                "End" = "29/06/2018"}
            "Term 3" = @{
                "Start" = "16/07/2018"
                "End" = "21/09/2018"}
            "Term 4" = @{
                "Start" = "08/10/2018"
                "End" = "21/12/2018"}
        }
        "2019" = [ordered]@{
            "Term 1" = @{
                "Start" = "29/01/2019"
                "End" = "05/04/2019"}
            "Term 2" = @{
                "Start" = "23/04/2019"
                "End" = "28/06/2019"}
            "Term 3" = @{
                "Start" = "15/07/2019"
                "End" = "20/09/2019"}
            "Term 4" = @{
                "Start" = "07/10/2019"
                "End" = "20/12/2019"}
        }
        "2020" = [ordered]@{
            "Term 1" = @{
                "Start" = "28/01/2020"
                "End" = "27/03/2020"}
            "Term 2" = @{
                "Start" = "14/04/2020"
                "End" = "26/06/2020"}
            "Term 3" = @{
                "Start" = "13/07/2020"
                "End" = "18/09/2020"}
            "Term 4" = @{
                "Start" = "05/10/2020"
                "End" = "18/12/2020"}
        }
        "2021" = [ordered]@{
            "Term 1" = @{
                "Start" = "27/01/2021"
                "End" = "01/04/2021"}
            "Term 2" = @{
                "Start" = "19/04/2021"
                "End" = "25/06/2021"}
            "Term 3" = @{
                "Start" = "12/07/2021"
                "End" = "17/09/2021"}
            "Term 4" = @{
                "Start" = "04/10/2021"
                "End" = "17/12/2021"}
        }
        "2022" = [ordered]@{
            "Term 1" = @{
                "Start" = "28/01/2022"
                "End" = "08/04/2022"}
            "Term 2" = @{
                "Start" = "26/04/2022"
                "End" = "24/06/2022"}
            "Term 3" = @{
                "Start" = "11/07/2022"
                "End" = "16/09/2022"}
            "Term 4" = @{
                "Start" = "03/10/2022"
                "End" = "20/12/2022"}
        }
        "2023" = [ordered]@{
            "Term 1" = @{
                "Start" = "27/01/2023"
                "End" = "06/04/2023"}
            "Term 2" = @{
                "Start" = "24/04/2023"
                "End" = "23/06/2023"}
            "Term 3" = @{
                "Start" = "10/07/2023"
                "End" = "15/09/2023"}
            "Term 4" = @{
                "Start" = "02/10/2023"
                "End" = "20/12/2023"}
        }
        "2024" = [ordered]@{
            "Term 1" = @{
                "Start" = "29/01/2024"
                "End" = "28/03/2024"}
            "Term 2" = @{
                "Start" = "15/04/2024"
                "End" = "28/06/2024"}
            "Term 3" = @{
                "Start" = "15/07/2024"
                "End" = "20/09/2024"}
            "Term 4" = @{
                "Start" = "07/10/2024"
                "End" = "20/12/2024"}
        }
        "2025" = [ordered]@{
            "Term 1" = @{
                "Start" = "28/01/2025"
                "End" = "04/04/2025"}
            "Term 2" = @{
                "Start" = "22/04/2025"
                "End" = "04/07/2025"}
            "Term 3" = @{
                "Start" = "21/07/2025"
                "End" = "19/09/2025"}
            "Term 4" = @{
                "Start" = "06/10/2025"
                "End" = "19/12/2025"}
        }
    }

    $Year_Range = $Term_dates.Get_Item($TestDate.Year.ToString())
    if (-Not($Year_Range)){
        throw "$TestDate Provided Date out of range"
    }

    #get the last school day of prior year.
    $last_year_range = $Term_dates.Get_Item($TestDate.AddYears(-1).Year.ToString())
    if (-Not($last_year_range)){
        Write-Warning "last_year_range out of range setting to first day of test year"
        $prior_end_date = Get-Date "01/01/$($TestDate.Year.ToString())"
    } else {
        $prior_end_date = Get-Date "01/01/$($TestDate.AddYears(-1).Year.ToString())"
        foreach ($test_term in $last_year_range.Keys){
            Write-Verbose -Message "last day of last year testing $test_term"
            $end_date = Get-Date -Date $last_year_range.$test_term.End
            
            if ($end_date -gt $prior_end_date){
                $prior_end_date = $end_date
            }
        }

    }
    Write-Verbose -Message "the last school day of prior year was $prior_end_date"
    
    #get the fist day of next year.
    $nexy_year_range = $Term_dates.Get_Item($TestDate.AddYears(1).Year.ToString())
    if (-Not($nexy_year_range)){
        Write-Warning "next_year_range out of range setting to last day of test year"
        $next_year_start = Get-Date "31/12/$($TestDate.Year.ToString())"
    } else {
        $next_year_start = Get-Date "31/12/$($TestDate.AddYears(1).Year.ToString())"
        foreach ($test_term in $nexy_year_range.Keys){
            Write-Verbose -Message "fist day of next year testing $test_term"
            $start_date = Get-Date -Date $nexy_year_range.$test_term.Start
            
            if ($start_date -lt $next_year_start){
                $next_year_start = $start_date
            }
        }

    }
    Write-Verbose -Message "The fist day of the next year is $next_year_start"


    foreach ($test_term in $Year_Range.Keys){
        Write-Verbose -Message "Testing $test_term"
        
        $start_date = Get-Date -Date $Year_Range.$test_term.Start
        $end_date = Get-Date -Date $Year_Range.$test_term.End

        if (($TestDate -gt $prior_end_date) -and ($TestDate -lt $start_date)){
            if($SimpleResults){
                return $false
            } else {
                return [ordered]@{"During_Term" = $false; "Start" = $prior_end_date.AddDays(1); "End"= $start_date.AddDays(-1)}
            }
        } else {
            $prior_end_date = $end_date
        }

        if (($TestDate -ge $start_date) -and ($TestDate -le $end_date)){
            if($SimpleResults){
                return $true
            } else {
                return [ordered]@{"During_Term" = $true; "Start" = $start_date; "End"= $end_date}
            }
        }
    }

    if (($TestDate -gt $end_date) -and ($TestDate -lt $next_year_start)){
        if($SimpleResults){
                return $false
        } else {
            return [ordered]@{"During_Term" = $false; "Start" = $end_date.AddDays(1); "End"= $next_year_start.AddDays(-1)}
        }
    }

    Write-Error "Critical ERROR"

}
