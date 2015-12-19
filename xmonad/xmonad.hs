mport XMonad
 
 main = xmonad defaultConfig
     { terminal    = "terminator"
     , modMask     = mod4Mask
     , borderWidth = 3
     }
