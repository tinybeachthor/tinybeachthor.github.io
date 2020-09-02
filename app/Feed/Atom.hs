{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings     #-}

module Feed.Atom
  ( build
  ) where

import           GHC.Generics                   ( Generic )
import           Data.Aeson
import           Data.Time
import           Development.Shake
import           Development.Shake.FilePath
import           Slick

import qualified Data.Text                     as T

import Types

data AtomData =
  AtomData { title        :: String
           , domain       :: String
           , author       :: String
           , posts        :: [Post]
           , currentTime  :: String
           , atomUrl      :: String
           }
  deriving (Generic, ToJSON, Eq, Ord, Show)

build :: [Post] -> SiteMeta -> FilePath -> FilePath -> Action ()
build allPosts siteMeta templatePath outputFolder = do
  now <- liftIO getCurrentTime
  let atomData = AtomData { title       = siteTitle siteMeta
                          , domain      = baseUrl siteMeta
                          , author      = siteAuthor siteMeta
                          , posts       = mkAtomPost <$> allPosts
                          , currentTime = toIsoDate now
                          , atomUrl     = "/atom.xml"
                          }
  atomTempl <- compileTemplate' templatePath
  writeFile' (outputFolder </> "atom.xml") . T.unpack $ substitute atomTempl (toJSON atomData)
 where
  mkAtomPost :: Post -> Post
  mkAtomPost p = p { date = formatDate $ date p }

formatDate :: String -> String
formatDate humanDate = toIsoDate parsedTime
  where parsedTime = parseTimeOrError True defaultTimeLocale "%b %e, %Y" humanDate :: UTCTime

rfc3339 :: Maybe String
rfc3339 = Just "%H:%M:%SZ"

toIsoDate :: UTCTime -> String
toIsoDate = formatTime defaultTimeLocale (iso8601DateFormat rfc3339)
