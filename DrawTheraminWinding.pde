public void windTheramin() {
  if (windUp) {
   if (brightnessAdjustment >= windUpTo) {
     brightnessAdjustment = windUpTo;
     windUp = false;
   } else {
     //if(brightnessAdjustment < windUpTo) {
       brightnessAdjustment += 2; //(int) brightnessAdjustment * .15;  
     //} 
   }
 }
  
 if (windDown) {
   if (brightnessAdjustment <= 5) {
     brightnessAdjustment = 0;
     windDown = false;
   } else {
     if(brightnessAdjustment > 0) {
       brightnessAdjustment -= 2; //(int) brightnessAdjustment * .15;  
     } else {
       brightnessAdjustment += 2; //(int) brightnessAdjustment * .15; 
     }
   }
 } 
}