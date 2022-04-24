#init


$scriptRootPath     = $PSScriptRoot
#get list of ckl files

$cklFiles   = Get-ChildItem "$scriptRootPath\ckl"
$xccdfFiles = Get-ChildItem "$scriptRootPath\xccdf"


foreach ($cklFile in $cklFiles){

    
    
    
    
    


    if([System.IO.Path]::GetExtension($cklFile) -eq ".ckl" ){
    #region CKL data

        #get xml data for ckl            
        [xml]$cklXmlDocument = get-content $cklFile.FullName

        #get CKL information

        $cklHOST_NAME = $cklXmlDocument.CHECKLIST.ASSET.HOST_NAME    
        $cklHOST_IP   = $cklXmlDocument.CHECKLIST.ASSET.HOST_IP    
        $STIG_INFO    = $cklXmlDocument.CHECKLIST.STIGS.iSTIG.STIG_INFO    
        
        # get the CKL title
        foreach ($SI_DATA in $STIG_INFO) {
            clv cklTitle
            foreach ($item in $SI_DATA.SI_DATA){
                if($item.SID_NAME -eq "title"){
                    $cklTitle = $item.SID_DATA
                    break
                }
            }
        }    
        
    #endregion CKL data



        #loop over xccdf files
        foreach ($xccdfFile in $xccdfFiles){

            if([System.IO.Path]::GetExtension($xccdfFile) -eq ".xml" ){       # if the file is xml... 

                
                
                [xml]$xccdfXmlDocument = get-content $xccdfFile.FullName      # load the xccdf xml data
                
                #get xccdf information
                $xccdfStigTitle   = ([xml]$xccdfXmlDocument).Benchmark.title                             # get the STIG title
                $xccdfHostName    = ([xml]$xccdfXmlDocument).Benchmark.TestResult.target                 # get the Hostname
                $xccdfIpAddress   = (([xml]$xccdfXmlDocument).Benchmark.TestResult.'target-address')[0]  # get the IP address
                $xccdfTargetFacts = ([xml]$xccdfXmlDocument).Benchmark.TestResult.'target-facts'         # Target facts contain multiple network adapters with mac address
                                                                                                    
                #get MAC address from multiple net connections (use first MAC)                 
                foreach ($targetFact in $xccdfTargetFacts.fact ){
                    if ($targetFact.name -eq "urn:scap:fact:asset:identifier:mac"){
                        $xccdfMAC = $targetFact.'#text'
                        break
                    }
                }
                
                #get xccdf results object
                $ruleResultObject = $xccdfXmlDocument.Benchmark.TestResult.'rule-result'




                if($xccdfStigTitle -eq $cklTitle){ # match the title

                    foreach($xccdfVuln in  $xccdfTargetFacts){          # loop over the xccdf vuln
                    } 
                }
            }
        }
    }
}





    





