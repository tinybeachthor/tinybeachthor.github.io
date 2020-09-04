{-# LANGUAGE NamedFieldPuns        #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Main where

import           Control.Lens
import           Control.Monad
import           Data.Aeson
import           Data.Aeson.Lens
import           Development.Shake
import           Development.Shake.Forward
import           Development.Shake.FilePath
import           Slick

import qualified Data.Text                     as T

import           Types

import qualified Feed.Atom

---Config-----------------------------------------------------------------------

siteMeta :: SiteMeta
siteMeta = SiteMeta { siteAuthor    = "Me"
                    , baseUrl       = "https://example.com"
                    , siteTitle     = "My Slick Site"
                    , twitterHandle = Just "myslickhandle"
                    , githubUser    = Just "myslickgithubuser"
                    }

outputFolder :: FilePath
outputFolder = "docs/"

---Build------------------------------------------------------------------------

-- | given a list of posts this will build a table of contents
buildIndex :: [Post] -> Action ()
buildIndex posts' = do
  indexT <- compileTemplate' "site/templates/index.html"
  let indexInfo = IndexInfo { posts = posts' }
      indexHTML = T.unpack $ substitute indexT (withSiteMeta siteMeta $ toJSON indexInfo)
  writeFile' (outputFolder </> "index.html") indexHTML

-- | Find and build all posts
buildPosts :: Action [Post]
buildPosts = do
  pPaths <- getDirectoryFiles mempty ["posts//*.md"]
  forP pPaths buildPost

-- | Load a post, process metadata, write it to output, then return the post object
-- Detects changes to either post content or template
buildPost :: FilePath -> Action Post
buildPost srcPath = cacheAction ("buildPost" :: T.Text, srcPath) $ do
  liftIO . putStrLn $ "Rebuilding post: " <> srcPath
  postContent <- readFile' srcPath
  -- load post content and metadata as JSON blob
  postData    <- markdownToHTML . T.pack $ postContent
  let postUrl     = T.pack . dropDirectory1 $ srcPath -<.> "html"
      withPostUrl = _Object . at "url" ?~ String postUrl
  -- Add additional metadata we've been able to compute
  let fullPostData = (withSiteMeta siteMeta) . withPostUrl $ postData
  template <- compileTemplate' "site/templates/post.html"
  writeFile' (outputFolder </> T.unpack postUrl) . T.unpack $ substitute template fullPostData
  convert fullPostData

-- | Copy all static files from the listed folders to their destination
copyStaticFiles :: Action ()
copyStaticFiles = do
  filepaths <- getDirectoryFiles "site" ["images//*", "css//*", "js//*"]
  void $ forP filepaths $ \filepath ->
    copyFileChanged ("site" </> filepath) (outputFolder </> filepath)

-- | Specific build rules for the Shake system
--   defines workflow to build the website
buildRules :: Action ()
buildRules = do
  allPosts <- buildPosts
  buildIndex allPosts
  Feed.Atom.build allPosts siteMeta outputFolder
  copyStaticFiles
  writeFile' (outputFolder </> ".nojekyll") mempty

main :: IO ()
main = do
  let shOpts = shakeOptions { shakeVerbosity = Chatty, shakeLintInside = ["\\"] }
  shakeArgsForward shOpts buildRules
