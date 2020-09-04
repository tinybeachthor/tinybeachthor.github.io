{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}

module Feed.Atom
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

data AtomData =
  AtomData { title        :: String
           , domain       :: String
           , author       :: String
           , posts        :: [Post]
           , currentTime  :: String
           , atomUrl      :: String
           }
  deriving (Generic, ToJSON, Eq, Ord, Show)

atomTemplate :: Template
atomTemplate = $(embedSingleTemplate "app/Feed/atom.xml")

build :: [Post] -> SiteMeta -> FilePath -> Action ()
build allPosts siteMeta outputFolder = do
  now <- liftIO getCurrentTime
  let atomData = AtomData { title       = siteTitle siteMeta
                          , domain      = baseUrl siteMeta
                          , author      = siteAuthor siteMeta
                          , posts       = mkAtomPost <$> allPosts
                          , currentTime = toIsoDate now
                          , atomUrl     = "/atom.xml"
                          }
  let rendered = substitute atomTemplate (toJSON atomData)
  writeFile' (outputFolder </> "atom.xml") . T.unpack $ rendered
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
