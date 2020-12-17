{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Types where

import           GHC.Generics                   ( Generic )
import           Data.Aeson
import           Data.Time                      ( UTCTime
                                                , parseTimeOrError
                                                , defaultTimeLocale
                                                )
import           Development.Shake.Classes      ( Binary )

import qualified Data.HashMap.Lazy             as HML

-- | Data for the site
data SiteMeta =
    SiteMeta { siteAuthor      :: String
             , baseUrl         :: String -- e.g. https://example.ca
             , siteTitle       :: String
             , siteDescription :: String
             , authorEmail     :: Maybe String
             , twitterHandle   :: Maybe String -- Without @
             , githubUser      :: Maybe String
             }
    deriving (Generic, Eq, Ord, Show, ToJSON)

withSiteMeta :: SiteMeta -> Value -> Value
withSiteMeta siteMeta (Object obj) = Object $ HML.union obj siteMetaObj
  where Object siteMetaObj = toJSON siteMeta
withSiteMeta _ _ = error "only add site meta to objects"

-- | Data for the index page
data IndexInfo =
  IndexInfo
    { posts :: [Post]
    }
  deriving (Generic, Show, FromJSON, ToJSON)

type Tag = String

-- | Data for a blog post
data Post =
    Post { title       :: String
         , content     :: String
         , url         :: String
         , date        :: String
         , tags        :: [Tag]
         , description :: String
         , image       :: Maybe String
         }
    deriving (Generic, Eq, Show, FromJSON, ToJSON, Binary)

instance Ord Post where
  a <= b = (parseHumanTime . date $ a) <= (parseHumanTime . date $ b)
   where
    parseHumanTime :: String -> UTCTime
    parseHumanTime = parseTimeOrError True defaultTimeLocale "%b %e, %Y"
