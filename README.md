## Task 3 Secure Data Management

### Event Log Collection

#I used `Get-WinEvent` to collect recent security events:

```powershell
Get-WinEvent -LogName Security -MaxEvents 20 > logs.txt


#Redirect WinEvent log output into a .txt file (artifact collection)
'Get-WinEvent -LogName Security -MaxEvents 20 > logs.txt'

#Copy or move results into evidence folder:
'Copy-Item logs.txt evidence\'

#Export permissions to a txt file
icacls evidence > 3-Evidence-ACL.txt

#Change working directory to project folder
mkdir evidence\data2.txt 

#Retrieved 20 most recent security log events writing them to logs.txt . This was inside my evidence folder
Get-Content evidence\logs.txt | Select-String -Pattern "Credential"

#Add string to data2.txt to give an example of sensitive content
icacls evidence\data2.txt

#Displays permission for folder
icacls evidence\data2.txt /save permissions2.txt

#Save access control list of data2.txt to permission2.txt
icacls evidence /save evidence_permissions.txt

 #Saves the ACL of the  folder to evidence_permissions.txt.
icacls data.txt /grant coleg:R

#Grant myself permission of data.txt
icacls evidence\data2.txt /grant coleg:R

## Secure Data Management
### Event Log Collection

I used `Get-WinEvent` to collect recent security events:
```powershell
Get-WinEvent -LogName Security -MaxEvents 20 > logs.txt

#Managing ACLs is important to protect evidence files from unauthorized access points
#The commands above show the collection of logs from a suspect. Logs were filtered and saved. File permissions were changed to keep evidenced intact.


##Task 4: Manage Permissions

#How to verify permissions:
icacls evidence\data2.txt

#Save to Permission file:
icacls evidence\data2.txt /save permissoion.txt

#Grant access to read only:
icacls evidence\data2.txt /grant:r coleg:R

#Set yourself to become the owner of this file
icacls evidence\data2.txt /setownwer coleg

#Managing permission is a important part of keeping files confidential and your evidencde accurrate.


## Task 5 Powershell Scripting:

#Navigate to correct location:
PS C:\Documents> cd c:\documents\df-mod-3-sdm

#Create backup folder:
PS C:\Documents\df-mod-3-sdm> New-Item -Path .\backup -ItemType Directory

#Copy your evidence file to a backup folder:
PS C:\Documents\df-mod-3-sdm> Copy-Item -Path .\evidence\data2.txt -Destination .\backup\data2_backup.txt -Force

#Remove the permission of inheritance:
PS C:\Documents\df-mod-3-sdm> icacls .\backup\data2_backup.txt /inheritance:r

processed file: .\backup\data2_backup.txt

#Grant read only permission:
PS C:\Documents\df-mod-3-sdm> icacls .\backup\data2_backup.txt /grant:r coleg

#Set yourself as the owner
PS C:\Documents\df-mod-3-sdm> icacls .\backup\data2_backup.txt /setowner coleg