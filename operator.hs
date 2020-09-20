import System.Process
import System.Environment
import System.Exit

data Shell a = Shell a deriving (Show)


instance Functor Shell where
  fmap f (Shell a) = Shell (f a)

instance Applicative Shell where
  pure = Shell
  (Shell f) <*> shellItem = fmap f shellItem

instance Monad Shell where
  return = Shell
  Shell x >>= f = f x

  

toProc :: Shell String -> CreateProcess
toProc (Shell a) = shell a

readShell :: Shell String -> IO String
readShell s = do
  (exitCode, sout, serr) <- readCreateProcessWithExitCode (toProc s) ""
  case serr == "" of
    True -> return sout
    False -> return serr

showHome :: Shell String
showHome = Shell "ls"

hostname = Shell "hostname"

install :: String -> Shell String
install package = Shell ("sudo apt-get install -y "++package)

delete :: String -> Shell String
delete package = Shell ("sudo apt-get remove -y "++package)

ssh :: String -> String -> Shell String
ssh user host = Shell ("ssh "++user++"@"++host)

shconcat :: Shell String -> Shell String -> Shell String
shconcat (Shell a) (Shell b) = Shell (a++" "++b)



main = getArgs >>= parse >>= putStr . tac

tac  = unlines . reverse . lines

parse ["-h"] = usage   >> exit
parse ["-v"] = version >> exit
parse []     = getContents
parse fs     = concat `fmap` mapM readFile fs

usage   = putStrLn "Usage: tac [-vh] [file ..]"
version = putStrLn "Haskell tac 0.1"
exit    = exitWith ExitSuccess
die     = exitWith (ExitFailure 1)
