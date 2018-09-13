#-----Script Info---------------------------------------------------------------------------------------------
# Name:Azure-Tools.psm1
# Author: Einar Stenberg
# Date: 19.11.14
# Version: 2
# Job/Tasks:
#--------------------------------------------------------------------------------------------------------------


#-----Changelog------------------------------------------------------------------------------------------------
#v1. Script created ES
#v2. Added function Enable-ReturnPath
#
#
#--------------------------------------------------------------------------------------------------------------





#-----Functions---------------------------------------------------------------------------------------------

Function Connect-Azure {
<#
.SYNOPSIS
Requests credentials and creates a session with Azure
.DESCRIPTION
Requests credentials and creates a session with Azure instance to be used with session terminator cmdlets
Part of Azure-Tools by ES
.EXAMPLE
Import-PSSession (Connect-Azure)
Enter-PSSession (Connect-azure)
#>


$LiveCred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic -AllowRedirection
Write-Output $Session
}


Function Enable-ReturnPath {
<#
.SYNOPSIS
Sets ReportToOriginatorEnabled on a office365 DL group
.DESCRIPTION
Sets ReportToOriginatorEnabled on a office365 DL group
Set to 1 (TRUE) to fix so that return-path is not left empty when mail goes through O365 DL's
Defaults to true if not specified
To be used when already connected to o365 azure!
Part of Azure-Tools by ES
.EXAMPLE
Enable-ReturnPath mail.list@example.com
Enable-ReturnPath -dlinput mail.list@example.com
Enable-ReturnPath -dlinput mail.list@example.com -enabled 1

Sets ReportToOriginatorEnabled to True for mail.list@example.com
.EXAMPLE
Enable-ReturnPath mail.list@example.com -enabled 0
Enable-ReturnPath -dlinput mail.list@example.com -enabled 0

Sets ReportToOriginatorEnabled to False for mail.list@example.com
.PARAMETER DlInput
input for DL name og address
.PARAMETER Enabled
Set to 0 to disable or 1 to enable (defaults to 1 if not entered)
#>

Param(
[Parameter(Mandatory=$true,Position=0)]
$DlInput,
[bool]$Enabled = $TRUE
)

write-host $DlInput 

Set-DistributionGroup $DlInput -ReportToOriginatorEnabled $Enabled
Get-DistributionGroup $DlInput | fl ReportToOriginatorEnabled

}

