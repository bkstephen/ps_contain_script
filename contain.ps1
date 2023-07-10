Update-MpSignature

Get-NetAdapter | format-list

$reply = Read-Host -Prompt "Continue with disabling all internet access?[y/n]"
if ( $reply -eq 'y' ) { 
    Disable-NetAdapter -Name "*" -Confirm:$false
    Write-Host "Network access disabled"
}

$reply = Read-Host -Prompt "Continue with full malware scan?[y/n]"
if ( $reply -eq 'y' ) { 
    Start-MpScan -ScanType FullScan
    Remove-MpThreat
}

$reply = Read-Host -Prompt "Continue with safemode offline mode malware scan?[y/n]"
if ( $reply -eq 'y' ) { 
    Start-MpWDOScan
}

$reply = Read-Host -Prompt "Restore from restore point?[y/n]"
# revert with "bcdedit /deletevalue {current} safeboot"
if ( $reply -eq 'y' ) { 
    Get-ComputerRestorePoint
    Restore-Computer
}

$reply = Read-Host -Prompt "Restart in safemode?[y/n]"
# revert with "bcdedit /deletevalue {current} safeboot"
if ( $reply -eq 'y' ) { 
    bcdedit /set {current} safeboot minimal 
    shutdown /r
}

$reply = Read-Host -Prompt "Wipe everything?[y/n]"
# revert with "bcdedit /deletevalue {current} safeboot"
if ( $reply -eq 'y' ) { 
    systemreset -factoryreset
}

# Other commands:
# Get-ComputerRestorePoint
# Restore-Computer -RestorePoint 255
