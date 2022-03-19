####### ========================================== #######
# Title:  EZYiD Google Cloud Internet Access Proxy CLI
# Author: Ricky Elsum
# Language: Powershell
####### ========================================== #######


####### ========================================== #######
# Set Remote Service Port Variables
$Remote_RDP_Port = '27165'
$Remote_SSH_Port = '22'
$Remote_Postgres_Port = '5432' 
$Remote_MSSQL_Port = '1433'

# Change Local Port Variable if current port is in use or blocked by firewall
$Local_RDP_Port = '27165'
$Local_SSH_Port = '2222'
$Local_Postgres_Port = '5532'
$Local_MSSQL_Port = '1533'

####### ========================================== #######
# Set Host Variables


#1 Development Server Windows Server 2019 RDP
$host1 = 'example-windows-vm-dev' # Change to set your Google Compute Engine VM's You need to connect to. 
$zone1 = 'us-central1-a' # Change to suit the Zone your Compute Engine Resides In
$port1 = $Remote_RDP_Port

#2 Production SQL Server 2019 Windows Server 2019 RDP
$host2 = 'example-msssql-instance-1' # Change to set your Google Compute Engine VM's You need to connect to. 
$zone2 = 'us-central1-a' # Change to suit the Zone your Compute Engine Resides In
$port2 = $Remote_RDP_Port

#3 ASP.NET Webserver Windows Server 2019 RDP
$host3 = 'example-iis-windowsvm-1' # Change to set your Google Compute Engine VM's You need to connect to. 
$zone3 = 'us-central1-a' # Change to suit the Zone your Compute Engine Resides In
$port3 = $Remote_RDP_Port

#4 Postgres Notification Scheduler SSH 
$host4 = 'scheduler-dev' # Change to set your Google Compute Engine VM's You need to connect to. 
$zone4 = 'us-central1-a' # Change to suit the Zone your Compute Engine Resides In
$port4 = $Remote_SSH_Port

#5 Example Wordpress Webserver Ubuntu 20.04 SSH
$host5 = 'example-wp-vm-1' # Change to set your Google Compute Engine VM's You need to connect to. 
$zone5 = 'australia-southeast2-a'  # Change to suit the Zone your Compute Engine Resides In
$port5 = $Remote_SSH_Port

#6 EZYiD Notification Scheduler Postgres
$host6 = 'scheduler-dev' # Change to set your Google Compute Engine VM's You need to connect to
$zone6 = 'us-central1-a'  # Change to suit the Zone your Compute Engine Resides In
$port6 = $Remote_Postgres_Port

#7 EZYiD Production SQL Studio Manager MS SQL Server 2019
$host7 = 'sql-instance-2' # Change to set your Google Compute Engine VM's You need to connect to
$zone7 = 'us-central1-a' # Change to suit the Zone your Compute Engine Resides In
$port7 = $Remote_MSSQL_Port

#8 EZYiD Development SQL Studio Manager MS SQL Server 2019
$host8 = 'ezyid-dev-us' # Change to set your Google Compute Engine VM's You need to connect to
$zone8 = 'us-central1-a' # Change to suit the Zone your Compute Engine Resides In
$port8 = $Remote_MSSQL_Port

#9 EZYiD Development SQL Studio Manager MS SQL Server 2019
$host9 = 'scheduler-postgres-prod-1' # Change to set your Google Compute Engine VM's You need to connect to
$zone9 = 'us-central1-a' # Change to suit the Zone your Compute Engine Resides In
$port9 = $Remote_Postgres_Port

####### ========================================== #######
# Main menu, allowing user selection
function Show-Menu {
    param (
        [string]$Title = 'GCP IAP Choose Which to Start'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host ""
    Write-Host "1: Press '1' to Start RDP Tunnel to $host1"
    Write-Host "2: Press '2' to Start RDP Tunnel to $host2"
    Write-Host "3: Press '3' to Start RDP Tunnel to $host3"
    Write-Host "4: Press '4' to Start SSH Tunnel to $host4"
    Write-Host "5: Press '5' to Start SSH Tunnel to $host5"
    Write-Host "6: Press '6' to Start POSTGRES Tunnel to $host6"
    Write-Host "7: Press '7' to Start MS SQL Tunnel to $host7"
    Write-Host "8: Press '8' to Start MS SQL Tunnel to $host8"
    Write-Host "9: Press '9' to Start POSTGRES Tunnel to $host9"
    Write-Host "Q: Press 'Q' to quit."
}

####### ========================================== #######
# Select Functions
Function iap_dev_us_rdp{
    gcloud compute start-iap-tunnel $host1 $port1 --local-host-port=localhost:$Local_RDP_Port --zone=$zone1
}

Function iap_sqlinstance_2_rdp {
    gcloud compute start-iap-tunnel $host2 $port2 --local-host-port=localhost:$Local_RDP_Port --zone=$zone2 
}

Function iap_webserverinstance_2_rdp {
    gcloud compute start-iap-tunnel $host3 $port3 --local-host-port=localhost:$Local_RDP_Port --zone=$zone3 
}

Function iap_scheduler_dev_ssh {
    gcloud compute start-iap-tunnel $host4 $port4 --local-host-port=localhost:$Local_SSH_Port --zone=$zone4
}

Function iap_wp_1_ssh {
    gcloud compute start-iap-tunnel $host5 $port5 --local-host-port=localhost:$Local_SSH_Port --zone=$zone5
}

Function iap_dev_pgadmin {
    gcloud compute start-iap-tunnel $host6 $port6 --local-host-port=localhost:$Local_Postgres_Port --zone=$zone6
}

Function iap_sqlinstance_2_mssql {
    gcloud compute start-iap-tunnel $host7 $port7 --local-host-port=localhost:$Local_MSSQL_Port --zone=$zone7
}

Function iap_ezyid_dev_us_mssql{
    gcloud compute start-iap-tunnel $host8 $port8 --local-host-port=localhost:$Local_MSSQL_Port --zone=$zone8
}

Function iap_prod_pgadmin{
    gcloud compute start-iap-tunnel $host9 $port9 --local-host-port=localhost:$Local_Postgres_Port --zone=$zone9
}

####### ========================================== #######
# Main menu loop
do {
    Show-Menu
    $input = Read-Host "Please make a selection"
    Clear-Host
    switch ($input) {
        '1' {iap_dev_us_rdp;break}
        '2' {iap_sqlinstance_2_rdp}
        '3' {iap_webserverinstance_2_rdp}
        '4' {iap_scheduler_dev_ssh}
        '5' {iap_wp_1_ssh}
        '6' {iap_scheduler_dev_pgadmin}
        '7' {iap_sqlinstance_2_mssql}
        '8' {iap_dev_us_mssql}
        '9' {iap_prod_pgadmin}
        'q' {break} # do nothing
        default{
            Write-Host "You entered '$input'" -ForegroundColor Red
            Write-Host "Please select one of the choices from the menu." -ForegroundColor Red}
    }
    Pause
} until ($input -eq 'q')