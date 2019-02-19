# This script starts and syncs your machine with NTP servers
# on first run, and also sets up the Registry to sync with 
# the new servers, and makes it sync at a faster interval.

# https://blogs.technet.microsoft.com/heyscriptingguy/2015/05/27/powershell-time-sync-get-and-evaluate-synchronization-state/

###
# Start W32Time Service
###

try
{
    if ((Get-Service -Name W32Time).Status -ne 'Running')
    {
        Write-Verbose -Message '[Get] [Start service] [Verbose] Start service: W32Time (Windows Time)'
        Start-Service -Name W32Time
    }
}
catch
{
    $outputItem.ErrorEvents += ('[Get] [Start service] [Exception] {0}' -f $_.Exception.Message)
}


###
# Manual Sync
# Just run right now once.
###

# Time Servers
$google = "time1.google.com,time2.google.com,time3.google.com,time4.google.com"
#$ntp_us_pool = "0.us.pool.ntp.org,1.us.pool.ntp.org,2.us.pool.ntp.org,3.us.pool.ntp.org" `

$time_servers = $google

# Run sync
w32tm.exe /config /syncfromflags:manual `
    /manualpeerlist: "$google_time" `
    /reliable:yes /update

###
# Setup Automatic Sync
# Schedule sync to occur much more frequently.
###

# The 0x9 is combo of 0x8 + 0x1 flags
# https://www.pahoehoe.net/configure-w32time-ntp-on-a-standalone-windows-box/
# https://blogs.msdn.microsoft.com/w32time/2008/02/26/configuring-the-time-service-ntpserver-and-specialpollinterval/

# Time Servers
# NOTE: These use the 0x9 flag so SpecialPollInterval is used (instead of MinPoll/MaxPoll)
$google = "time1.google.com,0x9 time2.google.com,0x9 time3.google.com,0x9 time4.google.com,0x9"
$time_servers = $google
$poll_interval_seconds = 10 * 60 # 10 minutes

# TODO Should Get-ItemProp first and then access with duck typing

# Set the NTP Servers to use.
Set-ItemProperty `
    -Path "HKLM:\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" `
    -Name "NtpServer" `
    -Value $time_servers

# Set the Poll Interval to use.
# NOTE: For SpecialPollInterval to be used the 0x1 flag 
# must be set in NtpServer settings (above).
Set-ItemProperty `
    -Path "HKLM:\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient" `
    -Name "SpecialPollInterval" `
    -Value $poll_interval_seconds

