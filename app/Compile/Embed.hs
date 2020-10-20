{-# LANGUAGE OverloadedStrings   #-}

module Compile.Embed
  ( embedNode
  )
where

import           CMarkGFM
import           Data.Maybe                     ( fromJust )

import qualified Data.Text                     as T

embedNode :: Node -> Node
embedNode (Node pos type_ ns) = Node pos (transformNode type_) (map embedNode ns)

transformNode :: NodeType -> NodeType
transformNode img@(IMAGE url title) =
  if youtubePrefix `T.isPrefixOf` url
     then renderYoutube url title
     else img
transformNode n = n

youtubePrefix :: T.Text
youtubePrefix = "https://www.youtube.com/watch?v="

renderYoutube :: Url -> Title -> NodeType
renderYoutube url _ = HTML_INLINE formatted
  where
    v = fromJust $ T.stripPrefix youtubePrefix url
    formatted = "<div class='video-container'><iframe src='https://www.youtube.com/embed/" <> v <> "'></iframe></div>"
