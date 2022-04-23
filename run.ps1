#init


$scriptRootPath     = $PSScriptRoot
#get list of ckl files

$cklFiles = Get-ChildItem "$scriptRootPath\ckl"


    foreach ($file in $cklFiles){
        #check if file is CKL
        if([System.IO.Path]::GetExtension($file) -eq ".ckl" ){
            
            [xml]$xmlDocument = get-content $file.FullName
            #get host information
            $HOST_NAME = ([xml]$xmlDocument | Select-Xml -XPath 'CHECKLIST/ASSET/HOST_NAME').Node.innerxml 
            $HOST_IP   = ([xml]$xmlDocument | Select-Xml -XPath 'CHECKLIST/ASSET/HOST_IP').Node.innerxml 
            $HOST_MAC  = ([xml]$xmlDocument | Select-Xml -XPath 'CHECKLIST/ASSET/HOST_MAC').Node.innerxml 
            $HOST_FQDN = ([xml]$xmlDocument | Select-Xml -XPath 'CHECKLIST/ASSET/HOST_FQDN').Node.innerxml 
            
            $HOST_NAME
            $HOST_IP 
            $HOST_MAC 
            $HOST_FQDN 






        }

        
        
    
    
    }



    













#for each ckl file, find the respective xccdf


<#


             $filePath = $file.FullName
             $filePath 
             Select-Xml -Path $filePath -XPath \\CHECKLIST



#>