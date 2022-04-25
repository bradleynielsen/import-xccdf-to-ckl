#init


$scriptRootPath     = $PSScriptRoot
#get list of ckl files

$cklFiles   = Get-ChildItem "$scriptRootPath\ckl"
$xccdfFiles = Get-ChildItem "$scriptRootPath\xccdf"


foreach ($cklFile in $cklFiles){

    
    
    
    
    


    if([System.IO.Path]::GetExtension($cklFile) -eq ".ckl" ){


        #get xml data for ckl            
        [xml]$cklXmlDocument = get-content $cklFile.FullName



        #get CKL host information
        $cklHOST_NAME = $cklXmlDocument.CHECKLIST.ASSET.HOST_NAME    
        $cklHOST_IP   = $cklXmlDocument.CHECKLIST.ASSET.HOST_IP    
        
        # get the CKL title
        $STIG_INFO = $cklXmlDocument.CHECKLIST.STIGS.iSTIG.STIG_INFO  # STIG_INFO has an element called "title" that is the name of the STIG
        foreach ($SI_DATA in $STIG_INFO) {
            clv cklTitle
            foreach ($item in $SI_DATA.SI_DATA){
                if($item.SID_NAME -eq "title"){
                    $cklTitle = $item.SID_DATA
                    break #exit after the title is found
                }
            }
        }    

        $cklVulns = $cklXmlDocument.CHECKLIST.STIGS.iSTIG.VULN

        #loop over xccdf files
        foreach ($xccdfFile in $xccdfFiles){
            # process only if the file is xml... 
            if([System.IO.Path]::GetExtension($xccdfFile) -eq ".xml" ){       
                [xml]$xccdfXmlDocument = get-content $xccdfFile.FullName  # load the xccdf xml data
                
                #get xccdf host information
                $xccdfStigTitle   = ([xml]$xccdfXmlDocument).Benchmark.title                             # get the STIG title
                $xccdfHostName    = ([xml]$xccdfXmlDocument).Benchmark.TestResult.target                 # get the Hostname
                $xccdfIpAddress   = (([xml]$xccdfXmlDocument).Benchmark.TestResult.'target-address')[0]  # get the IP address
                
                                                                                                    
                #get MAC address from multiple net connections (use first MAC)                 
                $xccdfTargetFacts = ([xml]$xccdfXmlDocument).Benchmark.TestResult.'target-facts'  # Target facts contain multiple network adapters with mac address
                #loop over all target facts found
                foreach ($targetFact in $xccdfTargetFacts.fact ){
                    if ($targetFact.name -eq "urn:scap:fact:asset:identifier:mac"){
                        $xccdfMAC = $targetFact.'#text'
                        break #exit after the first mac is found
                    }
                }
                
                #get xccdf results object
                $ruleResultObject = $xccdfXmlDocument.Benchmark.TestResult.'rule-result'




                if($xccdfStigTitle -eq $cklTitle -and $xccdfHostName -eq $cklHOST_NAME ){ # match the title and host
                    "Matching XCCDF found for CKL"
                    foreach($xccdfVuln in $ruleResultObject){          # loop over the xccdf vulns objects

                        $xccdfRule   = ($xccdfVuln.idref) -replace "xccdf_mil.disa.stig_rule_", ""  # get the xccdf rule number
                        $xccdfResult = ($xccdfVuln.result)                                          # get the xccdf rule result 
                        
                        
                        
                        #loop over the cklVulns

                        foreach($vuln in $cklVulns){
                            #get the vuln data

                            $STIG_DATA = $vuln.STIG_DATA
                            $Vuln_Num  = $STIG_DATA[0].ATTRIBUTE_DATA
                            $Rule_ID   = $STIG_DATA[3].ATTRIBUTE_DATA




                                                       
                        }
                        





                    } 
                }
            }
        }
    }
}





    





