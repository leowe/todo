import System.Environment
import System.Directory
import System.IO
import Data.List

dispatch :: [(String, [String] -> IO ())]
dispatch = [ ("add", add)
           , ("view", view)
           , ("remove", remove)
           , ("prioritize", prioritize)
<<<<<<< HEAD
           , ("help", help)
=======
>>>>>>> 9d197da79c26282947a53286c4f0dec595c78c97
           ]

main = do
    (command:args) <- getArgs
    let (Just action) = lookup command dispatch
    action args

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO ()
view [fileName] = do
      contents <- readFile fileName
      let todoTasks = lines contents
          numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
      putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [fileName, numberString] = do
    handle <- openFile fileName ReadMode
    (tempName, tempHandle) <- openTempFile "." "temp"
    contents <- hGetContents handle
    let number = read numberString
        todoTasks = lines contents
        newTodoItems = delete (todoTasks !! number) todoTasks
    hPutStr tempHandle $ unlines newTodoItems
    hClose handle
    hClose tempHandle
    removeFile fileName
    renameFile tempName fileName

prioritize :: [String] -> IO ()
prioritize [fileName, numberString] = do
    handle <- openFile fileName ReadMode
    (tempName, tempHandle) <- openTempFile "." "temp"
    contents <- hGetContents handle
    let number = read numberString
        todoTasks = lines contents
        todoTask = todoTasks !! number
        newTodoItems = todoTask : (delete todoTask todoTasks)
    hPutStr tempHandle $ unlines newTodoItems
    hClose handle
    hClose tempHandle
    removeFile fileName
    renameFile tempName fileName
<<<<<<< HEAD

help :: [String] -> IO ()
help []  = do print $ map fst dispatch
              print "args ordering: filename rest_of_args"  

=======
>>>>>>> 9d197da79c26282947a53286c4f0dec595c78c97
