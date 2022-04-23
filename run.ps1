#init


$scriptRootPath     = $PSScriptRoot
#get list of ckl files

$cklFiles   = Get-ChildItem "$scriptRootPath\ckl"
$xccdfFiles = Get-ChildItem "$scriptRootPath\xccdf"


foreach ($cklFile in $cklFiles){
    #check if file is CKL
    if([System.IO.Path]::GetExtension($cklFile) -eq ".ckl" ){
        #get xml data for ckl            
        [xml]$cklXmlDocument = get-content $cklFile.FullName

        #get host information
        $cklHOST_NAME = ([xml]$cklXmlDocument | Select-Xml -XPath 'CHECKLIST/ASSET/HOST_NAME').Node.innerxml 
        $cklHOST_IP   = ([xml]$cklXmlDocument | Select-Xml -XPath 'CHECKLIST/ASSET/HOST_IP').Node.innerxml 
        $cklHOST_MAC  = ([xml]$cklXmlDocument | Select-Xml -XPath 'CHECKLIST/ASSET/HOST_MAC').Node.innerxml 
        $cklHOST_FQDN = ([xml]$cklXmlDocument | Select-Xml -XPath 'CHECKLIST/ASSET/HOST_FQDN').Node.innerxml 
        
        #"getting ckl for $cklHOST_IP"
            


        #find the matching xccdf file


        foreach ($xccdfFile in $xccdfFiles){
            if([System.IO.Path]::GetExtension($xccdfFile) -eq ".xml" ){
                #"getting xccdf"




                [xml]$xccdfXmlDocument = get-content $xccdfFile.FullName
                #$xpath = "/Benchmark/'status date'"
                $xpath = "/Benchmark"
                
                


                [xml]$xccdfXmlDocument | Select-Xml -XPath $xpath | select-object -expandProperty Node


                ([xml]$xccdfXmlDocument | Select-Xml -XPath $xpath   ).Node.InnerText








                
                #([xml]$xccdfXmlDocument | Select-Xml -XPath $xpath) | Select-Object -ExpandProperty *

                

                
                
            
            
            
            }
            

        
        
        }


        


    }
    
}





    





