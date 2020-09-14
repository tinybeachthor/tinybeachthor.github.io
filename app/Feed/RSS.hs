{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}

module Feed.RSS
  ( build
  ) where

import           GHC.Generics                   ( Generic )
import           Data.Aeson
import           Data.Time
import           Development.Shake
import           Development.Shake.FilePath
import           Text.Mustache.Compile          ( embedSingleTemplate )
import           Text.Mustache.Render           ( substitute )
import           Text.Mustache.Types            ( Template )

import qualified Data.Text                     as T

import Types

data RSSData =
  RSSData { title        :: String
          , description  :: String
          , domain       :: String
          , posts        :: [Post]
          , currentTime  :: String
          , rssUrl       :: String
          }
  deriving (Generic, ToJSON, Eq, Ord, Show)

rssTemplate :: Template
rssTemplate = $(embedSingleTemplate "app/Feed/rss.xml")

build :: [Post] -> SiteMeta -> FilePath -> Action ()
build allPosts siteMeta outputFolder = do
  now <- liftIO getCurrentTime
  let rssData = RSSData { title       = siteTitle siteMeta
                        , description = siteDescription siteMeta
                        , domain      = baseUrl siteMeta
                        , posts       = mkAtomPost <$> allPosts
                        , currentTime = toIsoDate now
                        , rssUrl      = "/rss.xml"
                        }
  let rendered = substitute rssTemplate (toJSON rssData)
  writeFile' (outputFolder </> "rss.xml") . T.unpack $ rendered
 where
  mkAtomPost :: Post -> Post
  mkAtomPost p = p { date = formatDate $ date p }

formatDate :: String -> String
formatDate humanDate = toIsoDate parsedTime
  where parsedTime = parseTimeOrError True defaultTimeLocale "%b %e, %Y" humanDate :: UTCTime

toIsoDate :: UTCTime -> String
toIsoDate = formatTime defaultTimeLocale rfc822

-- | Use numeric timezone offset to avoid issues with UTC/UT
rfc822 :: String
rfc822 = "%a, %d %b %Y %H:%M:%S %z"
