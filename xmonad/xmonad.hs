 import XMonad
 
 main = xmonad defaultConfig
     { terminal    = "terminal"
     , modMask     = mod4Mask
     , borderWidth = 3
     }
