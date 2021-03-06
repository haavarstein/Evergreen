Function Get-Zoom {    
    <#
        .NOTES
            Author: Trond Eirik Haavarstein
            Twitter: @xenappblog
    #>
    [OutputType([System.Management.Automation.PSObject])]
    [CmdletBinding()]
    Param()

    $url = "https://zoom.us/download"
    try {
        $web = Invoke-WebRequest -UseBasicParsing -Uri $url -ErrorAction SilentlyContinue
    }
    catch {
        Throw "Failed to connect to URL: $url with error $_."
        Break
    }
    finally {
        $str1 = $web.ToString() -split "[`r`n]" | Select-String "Version" | Select-Object -First 1
        $str2 = $str1 -replace "						</div>"
        $Version = $str2 -replace "Version "

        $PSObject = [PSCustomObject] @{
            Version     = $Version
        }
        Write-Output -InputObject $PSObject
    }
}
