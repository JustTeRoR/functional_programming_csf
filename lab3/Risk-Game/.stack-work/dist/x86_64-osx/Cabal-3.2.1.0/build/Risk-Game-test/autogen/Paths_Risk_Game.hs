{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Risk_Game (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab3/Risk-Game/.stack-work/install/x86_64-osx/6a16a950a1a1e454b4592904d0121ee4e55057a804efc2a0d268086aed5dc85d/8.10.4/bin"
libdir     = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab3/Risk-Game/.stack-work/install/x86_64-osx/6a16a950a1a1e454b4592904d0121ee4e55057a804efc2a0d268086aed5dc85d/8.10.4/lib/x86_64-osx-ghc-8.10.4/Risk-Game-0.1.0.0-2rbT3MMpxG31yZkJdh4D7S-Risk-Game-test"
dynlibdir  = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab3/Risk-Game/.stack-work/install/x86_64-osx/6a16a950a1a1e454b4592904d0121ee4e55057a804efc2a0d268086aed5dc85d/8.10.4/lib/x86_64-osx-ghc-8.10.4"
datadir    = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab3/Risk-Game/.stack-work/install/x86_64-osx/6a16a950a1a1e454b4592904d0121ee4e55057a804efc2a0d268086aed5dc85d/8.10.4/share/x86_64-osx-ghc-8.10.4/Risk-Game-0.1.0.0"
libexecdir = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab3/Risk-Game/.stack-work/install/x86_64-osx/6a16a950a1a1e454b4592904d0121ee4e55057a804efc2a0d268086aed5dc85d/8.10.4/libexec/x86_64-osx-ghc-8.10.4/Risk-Game-0.1.0.0"
sysconfdir = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab3/Risk-Game/.stack-work/install/x86_64-osx/6a16a950a1a1e454b4592904d0121ee4e55057a804efc2a0d268086aed5dc85d/8.10.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Risk_Game_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Risk_Game_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Risk_Game_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Risk_Game_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Risk_Game_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Risk_Game_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
