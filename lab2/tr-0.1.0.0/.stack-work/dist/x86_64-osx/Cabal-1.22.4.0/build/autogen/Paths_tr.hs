module Paths_tr (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab2/tr-0.1.0.0/.stack-work/install/x86_64-osx/c5172af33f472de486d6411348636991e8f8f7fcf39302b0d932ca78621d0508/7.10.2/bin"
libdir     = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab2/tr-0.1.0.0/.stack-work/install/x86_64-osx/c5172af33f472de486d6411348636991e8f8f7fcf39302b0d932ca78621d0508/7.10.2/lib/x86_64-osx-ghc-7.10.2/tr-0.1.0.0-HFaWPnaeoE2K0NoMoEaoZ8"
datadir    = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab2/tr-0.1.0.0/.stack-work/install/x86_64-osx/c5172af33f472de486d6411348636991e8f8f7fcf39302b0d932ca78621d0508/7.10.2/share/x86_64-osx-ghc-7.10.2/tr-0.1.0.0"
libexecdir = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab2/tr-0.1.0.0/.stack-work/install/x86_64-osx/c5172af33f472de486d6411348636991e8f8f7fcf39302b0d932ca78621d0508/7.10.2/libexec"
sysconfdir = "/Users/just_terror/VSU/4 course (2 sem)/Functional_Programming/lab2/tr-0.1.0.0/.stack-work/install/x86_64-osx/c5172af33f472de486d6411348636991e8f8f7fcf39302b0d932ca78621d0508/7.10.2/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "tr_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "tr_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "tr_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "tr_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "tr_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
