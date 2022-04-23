#init


$scriptRootPath     = $PSScriptRoot
#get list of ckl files

$cklFiles = Get-ChildItem "$scriptRootPath\ckl"


    foreach ($file in $cklFiles){
        #check if file is CKL
        if([System.IO.Path]::GetExtension($file) -eq ".ckl" ){
            
            [xml]$xmlDocument = get-content $file.FullName

            ([xml]$xmlDocument | Select-Xml -XPath 'CHECKLIST/ASSET/HOST_IP').Node.innerxml 
            
             






        }

        
        
    
    
    }



    













#for each ckl file, find the respective xccdf


<#


             $filePath = $file.FullName
             $filePath 
             Select-Xml -Path $filePath -XPath \\CHECKLIST



#>