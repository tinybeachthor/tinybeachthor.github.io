{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Types where

import           GHC.Generics                   ( Generic )
import           Data.Aeson
import           Development.Shake.Classes      ( Binary )

import qualified Data.HashMap.Lazy             as HML

-- | Data for the site
data SiteMeta =
    SiteMeta { siteAuthor    :: String
             , baseUrl       :: String -- e.g. https://example.ca
             , siteTitle     :: String
             , twitterHandle :: Maybe String -- Without @
             , githubUser    :: Maybe String
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
    } deriving (Generic, Show, FromJSON, ToJSON)

type Tag = String

-- | Data for a blog post
data Post =
    Post { title       :: String
         , author      :: String
         , content     :: String
         , url         :: String
         , date        :: String
         , tags        :: [Tag]
         , description :: String
         , image       :: Maybe String
         }
    deriving (Generic, Eq, Ord, Show, FromJSON, ToJSON, Binary)

-- | Data for atom feed
data AtomData =
  AtomData { title        :: String
           , domain       :: String
           , author       :: String
           , posts        :: [Post]
           , currentTime  :: String
           , atomUrl      :: String } deriving (Generic, ToJSON, Eq, Ord, Show)

