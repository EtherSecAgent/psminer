
 
 #Mainmenu function. Contains the screen output for the menu and waits for and handles user input.  
 function mainmenu{  
 cls  
 echo "---------------------------------------------------------"  
 echo ""  
 echo "    PSM0002"                
 echo "    1. Start Mining"
 echo "    2. Stop  Mining              "  
 echo "    3. Add CCminer Config"
 echo "    4. Remove CCminer Config"
 echo "    5. List Miner Configs"
 echo "    66. Exit"
 echo ""  
 echo ""  
 echo "---------------------------------------------------------"  
 $answer = read-host "Please Make a Selection" 
 if ($answer -eq 1){startfunction}
 if ($answer -eq 2){stopfunction}
 if ($answer -eq 3){addfunction}
 if ($answer -eq 4){removefunction}   
 if ($answer -eq 5){listfunction}
 if ($answer -eq 66){exit}       
 else {write-host -ForegroundColor Red "Invalid Option, looping back to menu in 5s"  
       sleep 5  
       mainmenu  
      }
      }  



 #startfunction function.   
 function startfunction{  
 cls  
 echo "---------------------------------------------------------"  
 echo ""  
 echo "     Enter Config Name"                  
 echo ""  
 echo "---------------------------------------------------------"  
 $name = Read-Host -Prompt 'Enter Config' ;

 cls

 $launch = get-content .\psminer\configs\$name.cfg ; Invoke-Expression  $launch  ;
  
      }
      
 #stopfunction function.   
 Function stopfunction {
while ($true) {
    cls
    if ((Get-Process -Name ccminer-x64 -ErrorAction SilentlyContinue) -eq $null) 
    {

        Write-Host -ForegroundColor Red "CC-Miner not Running, nothing to close" ;
        Sleep 3
        mainmenu
    }
    else {write-host -ForegroundColor Green "Closing Miner"
    Stop-Process -Name ccminer-x64 -Confirm 
             
          
         }
         }
         Write-Host -ForegroundColor Cyan "Looping back to Main Menu"
         Sleep 4
         mainmenu
         }      


 #addfunction function.   
 function addfunction{  
 cls  
 echo "---------------------------------------------------------"  
 echo ""  
 echo "     Enter ccminer coin mining config syntax"                  
 echo ""  
 echo "---------------------------------------------------------"  
 $configsyn = Read-Host -Prompt 'Enter Syntax'
 sleep 1
 cls  
 echo "---------------------------------------------------------"  
 echo ""  
 echo "     Give config name"
 echo ""
 echo "   Example 'CoinName-PoolName'"
 echo "   Example 'Bitcoin-CoinPool'"                
 echo ""  
 echo "---------------------------------------------------------"  
 $configname = Read-Host -Prompt 'Enter Name'
 New-Item -ItemType File -Path .\psminer\configs\$configname.cfg ;
 Add-Content .\psminer\configs\$configname.cfg $configsyn
 sleep 1
 Write-Host -ForegroundColor Green "$configname config added"
 sleep 3
 mainmenu
 
  } 


#removefunction remove 
function removefunction {
 cls  
 echo "---------------------------------------------------------"  
 echo ""  
 echo "     Enter Name of Miner Config"                  
 echo ""  
 echo "---------------------------------------------------------"  
 $name = Read-Host -Prompt 'Enter name'

 if ((Get-Childitem .\psminer\configs\$name.cfg -ErrorAction SilentlyContinue) -eq $null)
  {Write-Host -ForegroundColor Red "Config not found, please try again"
  sleep 4
  mainmenu

  }
  
  else {Remove-Item -Path .\psminer\configs\$name.cfg -Confirm ;
   Write-Host "Going back to main menu"
   Sleep 3
   mainmenu

  }

  }
 
 #listfunction function
 function listfunction{
 Get-ChildItem .\psminer\configs
 echo "---------------------------------------------------------"  
 echo "     Main Menu 1, Repeat 2"                   
 echo "---------------------------------------------------------"  
 $answer = Read-Host -Prompt 'Enter Option'

 if ($answer -eq 1){mainmenu}
 if ($answer -eq 2){listfunction}

 else {write-host -ForegroundColor Red "Invalid Option, looping back to menu in 5s"
      sleep 5
      mainmenu
     
     }
     }


 #start
mainmenu
 
