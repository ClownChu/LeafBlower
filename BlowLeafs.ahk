interval := 50
stepX := 3
stepY := 3 
screenOffset := 20
randomRange := 100
intervalRandomRange := randomRange / 2

SysGet, monitorArea, MonitorWorkArea
monitorAreaBottom += 48

limitLeft := monitorAreaLeft + screenOffset
limitRight := monitorAreaRight - screenOffset
limitTop := monitorAreaTop + screenOffset
limitBottom := monitorAreaBottom - screenOffset

eachStepX := limitRight / stepX
eachStepY := limitBottom / stepY

^q::
   WinActivate "Leaf Blower Revolution"
   Loop {
      RandClick2Area(limitLeft, limitRight, limitTop, limitBottom)
      Sleep, 100
   }
   Return

^w::
   WinActivate "Leaf Blower Revolution"
   Loop {
      x := limitLeft
      y := limitTop + eachStepY
      While (x < limitRight) {
         randomX := GetRandomValueInRange(x, randomRange, limitLeft, limitRight)
         randomY := GetRandomValueInRange(y, randomRange, limitTop, limitBottom)

         Click %randomX%, %randomY%
         ExecuteSleep(interval, intervalRandomRange)

         x := x + eachStepX 
         if (x > limitRight) {
            x := limitRight
         }
      }

      y := limitBottom - eachStepY
      While (x > limitLeft) {
         randomX := GetRandomValueInRange(x, randomRange, limitLeft, limitRight)
         randomY := GetRandomValueInRange(y, randomRange, limitTop, limitBottom)

         Click %randomX%, %randomY%
         ExecuteSleep(interval, intervalRandomRange)

         x := x - eachStepX 
         if (x < limitLeft) {
            x := limitLeft
         }
      }
      
      y := limitTop + (eachStepY * (stepY / 2))
      While (x < limitRight) {
         randomX := GetRandomValueInRange(x, randomRange, limitLeft, limitRight)
         randomY := GetRandomValueInRange(y, randomRange, limitTop, limitBottom)

         Click %randomX%, %randomY%
         ExecuteSleep(interval, intervalRandomRange)
         
         x := x + eachStepX 
         if (x > limitRight) {
            x := limitRight
         }
      }

   }
   Return

^e::
   WinActivate "Leaf Blower Revolution"
   Loop {
      x := 100
      While (x < 1900) {
         Click %x%, 540
         Sleep, %interval%    
         x += step 
         if (x > 1900) {
            x = 1900
         }
      }

      While (x > 100) {
         Click %x%, 540
         Sleep, %interval%    
         x -= step 
         if (x < 100) {
            x = 100
         }
      }
   }
   Return

GetRandomValueInRange(value, randomRange, minLimit, maxLimit) {  
   minValue := value - randomRange
   maxValue := value + randomRange

   Random, randomValue, %minValue%, %maxValue%
   randomValue := InLimits(randomValue, minLimit, maxLimit)

   Return randomValue
}

ExecuteSleep(interval, randomRange) {
   intervalRandomRange := randomRange / 2
   randomInterval := GetRandomValueInRange(interval, intervalRandomRange, 0, 1000)
   Sleep, %randomInterval%  
}

RandClick2Area(x1,x2,y1,y2) {  
   Random, x, %x1%,%x2%
   Random, y, %y1%,%y2%
   Click %x%, %y%
}

InLimits(value, minLimit, maxLimit) {
   if (value < minLimit) {
      value := minLimit
   }
   if (value > maxLimit) {
      value := maxLimit
   }

   Return %value%
}

^Esc::ExitApp
^a::Pause    ; Pause script with Ctrl+A
^s::Reload   ; Reload script with Ctrl+S