--------------------------------------------------------------------------------
---- Imports

import System.Exit (exitSuccess)
import System.IO (Handle)

import XMonad
import XMonad.Actions.Promote (promote)
import XMonad.Actions.RotSlaves (rotAllDown, rotSlavesDown)
import XMonad.Hooks.DynamicLog (
  PP(..),
  dynamicLogWithPP,
  shorten,
  wrap,
  xmobarAction,
  xmobarColor
  )
import XMonad.Hooks.ManageDocks (ToggleStruts(..), avoidStruts, docks)
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.Renamed (Rename(Replace), renamed)
import XMonad.Layout.Spacing (
  Border(..),
  decScreenSpacing,
  decWindowSpacing,
  incScreenSpacing,
  incWindowSpacing,
  spacingRaw
  )
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (hPutStrLn, safeSpawnProg, spawnPipe)

import qualified XMonad.StackSet as W

--------------------------------------------------------------------------------
---- Constants

myTerminal :: String
myTerminal = "alacritty"

myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

--------------------------------------------------------------------------------
---- Keybindings

myKeys :: [(String, X ())]
myKeys = [
  -- XMonad
  ("M-S-r", spawn "xmonad --recompile; xmonad --restart"),
  ("M-S-q", io exitSuccess),                -- quit xmonad

  -- Programs
  ("M-<Return>", spawn myTerminal),
  ("M-<Space>", spawn "rofi -show combi"),
  ("M-b", safeSpawnProg "google-chrome-stable"),

  -- Layout
  ("M-y", refresh),                         -- resize viewed windows to the correct size
  ("M-r", setLayout $ Layout myLayoutHook), -- reset to the default layout configuration
  ("M-n", sendMessage NextLayout),          -- rotate to the next layout
  ("M-f", sendMessage ToggleStruts),        -- toggle xmobar display
  ("M-,", sendMessage $ IncMasterN (-1)),   -- decrement the number of windows in the master area
  ("M-.", sendMessage $ IncMasterN 1),      -- increment the number of windows in the master area
  ("M-d", decWindowSpacing 4),              -- shrink window gaps
  ("M-i", incWindowSpacing 4),              -- expand window gaps
  ("M-S-d", decScreenSpacing 4),            -- shrink screen gaps
  ("M-S-i", incScreenSpacing 4),            -- expand screen gaps

  -- Windows
  ("M-q", kill),                            -- kill focused client
  ("M-t", withFocused $ windows . W.sink),  -- push window back into tiling
  ("M-m", windows W.focusMaster),           -- move focus to the master window
  ("M-j", windows W.focusDown),             -- move focus to the next window
  ("M-k", windows W.focusUp),               -- move focus to the prev window
  ("M-h", sendMessage Shrink),              -- shrink the master area
  ("M-l", sendMessage Expand),              -- expand the master area
  ("M-S-m", windows W.swapMaster),          -- swap the focused window and the master window
  ("M-S-j", windows W.swapDown),            -- swap focused window with next window
  ("M-S-k", windows W.swapUp),              -- swap focused window with prev window
  ("M-<Backspace>", promote),               -- move focused window to master, others maintain order
  ("M-S-<Tab>", rotSlavesDown),             -- rotate all windows except master and keep focus
  ("M-C-<Tab>", rotAllDown),                -- rotate all the windows in the current stack

  -- Audio
  ("<XF86AudioMute>", spawn "amixer set Master toggle"),
  ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute"),
  ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute"),
  ("S-<XF86AudioLowerVolume>", spawn "amixer set Master 1%- unmute"),
  ("S-<XF86AudioRaiseVolume>", spawn "amixer set Master 1%+ unmute")
  ] ++ [
  ("M-" ++ s ++ i, windows $ action ws) |
    (ws, i) <- zip myWorkspaces $ show <$> [1 .. ],
    (s, action) <- [("", W.greedyView), ("S-", W.shift)]
  ]

--------------------------------------------------------------------------------
---- Hooks

myLayoutHook = avoidStruts $ tiled ||| threeCol ||| full ||| stack
  where
    mySpacing = spacingRaw False (Border 0 0 0 0) True (Border 0 0 0 0) True
    tiled = renamed [Replace "tiled"] $
      mySpacing $
      Tall 1 0.03 0.5
    threeCol = renamed [Replace "threeCol"] $
      limitWindows 3 $
      mySpacing $
      Mirror $
      Tall 3 0.03 0.5
    full = renamed [Replace "full"] $
      mySpacing $
      Full
    stack = renamed [Replace "stack"] $
      mySpacing $
      Mirror $
      Tall 1 0.03 0.5

myManageHook :: ManageHook
myManageHook = composeAll [
  className =? "Nm-connection-editor" --> doFloat,
  title =? "Event Tester" --> doFloat
  ]

myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP def {
  ppCurrent = xmobarColor "#268bd2" "" . wrap "" "*",
  ppHidden = xmobarColor "#859900" "" . wrap "" "-" . clickable,
  ppHiddenNoWindows = xmobarColor "#93a1a1" "" . clickable,
  ppUrgent = xmobarColor "#dc322f" "" . wrap "" "#" . clickable,
  ppSep = " » ",
  ppTitle = xmobarColor "#eee8d5" "" . shorten 80,
  ppLayout = xmobarColor "#cb4b16" "",
  ppOrder = \(ws:l:t:ex) -> [logo] ++ [ws, l] ++ ex ++ [t],
  ppExtras = [windowCountLogger],
  ppOutput = hPutStrLn h
  } where
    clickable ws = maybe ws (\x -> xmobarAction ("xdotool key super+" ++ show
      x) "1" ws) $ lookup ws (zip myWorkspaces [1 .. ])
    logo = xmobarColor "#6c71c4" "" "\xe61f xmonad"
    windowCount = show . length . W.index . windowset
    windowCountLogger = Just . xmobarColor "#d33682" "" . windowCount <$> get

--------------------------------------------------------------------------------
---- Main

main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ docks def {
    normalBorderColor = "#93a1a1",
    focusedBorderColor = "#268bd2",
    terminal = myTerminal,
    layoutHook = myLayoutHook,
    manageHook = myManageHook,
    workspaces = myWorkspaces,
    modMask = mod4Mask,
    borderWidth = 5,
    logHook = myLogHook xmproc,
    focusFollowsMouse = True,
    clickJustFocuses = False
    } `additionalKeysP` myKeys
