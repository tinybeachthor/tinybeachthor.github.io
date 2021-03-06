{-# LANGUAGE OverloadedStrings   #-}

module Compile.Embed
  ( embedNode
  )
where

import           CMarkGFM
import           Data.Char (isAlpha, isNumber)
import           Data.Maybe                     ( fromJust )

import qualified Data.Text                     as T

embedNode :: Node -> Node
embedNode (Node pos type_ ns) = Node pos (transformNode type_) (map embedNode ns)

transformNode :: NodeType -> NodeType
transformNode img@(IMAGE url title)
  | youtuPrefix   `T.isPrefixOf` url = renderYoutu   url title
  | youtubePrefix `T.isPrefixOf` url = renderYoutube url title
  | otherwise                        = img
transformNode n = n

youtuPrefix :: T.Text
youtuPrefix = "https://youtu.be/"

renderYoutu :: Url -> Title -> NodeType
renderYoutu url _ = HTML_INLINE formatted
  where
    v = (T.replace "t=" "start=") . fromJust . (T.stripPrefix youtuPrefix) $ url
    formatted = "<div class='video-container'><iframe src='https://www.youtube.com/embed/" <> v <> "'></iframe></div>"

youtubePrefix :: T.Text
youtubePrefix = "https://www.youtube.com/watch?v="

renderYoutube :: Url -> Title -> NodeType
renderYoutube url _ = HTML_INLINE formatted
  where
    v = fromJust $ T.stripPrefix youtubePrefix url
    formatted = "<div class='video-container'><iframe src='https://www.youtube.com/embed/" <> v <> "'></iframe></div>"
