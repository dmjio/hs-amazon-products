{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8 as Char8
import           Data.Text                  as T
import           Network.HTTP.Conduit
import           System.Environment

import           Amazon

main :: IO ()
main = do
        conf <- getSandbox
        print $ amazonAccessId conf

getSandbox :: IO AmazonConf
getSandbox = do
    accessId     <- getEnv "AWS_ACCESS_ID"
    accessSecret <- getEnv "AWS_ACCESS_SECRET"
    associateTag <- getEnv "AWS_ASSOCIATE_TAG"
    manager      <- newManager conduitManagerSettings
    return $ liveConf manager (T.pack accessId) (Char8.pack accessSecret) (T.pack associateTag)
