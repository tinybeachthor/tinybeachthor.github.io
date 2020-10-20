{-# LANGUAGE OverloadedStrings   #-}

module Compile.Compile
  ( compileTemplate
  , markdownToHTML
  )
where

import           CMarkGFM                       ( commonmarkToNode
                                                , nodeToHtml
                                                , optUnsafe
                                                )
import           Data.Aeson                    as A
import           Data.Attoparsec.Text
import           Data.Text.Encoding             ( encodeUtf8 )
import           Data.Yaml                      ( decodeEither' )
import           Development.Shake
import           Text.Mustache                  ( Template
                                                , ast
                                                )
import           Text.Mustache.Compile          ( getPartials
                                                , localAutomaticCompile
                                                )

import qualified Data.Text                     as T

import           Compile.Highlight              ( highlightNode )
import           Utils                          ( extend )

compileTemplate :: FilePath -> Action Template
compileTemplate fp = do
  need $ pure fp
  result <- liftIO $ localAutomaticCompile fp
  case result of
    Right template -> do
      need . getPartials . ast $ template
      return template
    Left err -> fail $ show err

-- | Convert markdown into a 'Value';
--
--   The 'Value' will have a "content" key containing rendered HTML.
--   It will also include any metadata present in the markdown header.
--
markdownToHTML :: T.Text -> Action Value
markdownToHTML input = do
  (meta, content) <- splitMetadata input
  let node   = commonmarkToNode [] [] content
  let html   = nodeToHtml [optUnsafe] [] (highlightNode node)
  let output = meta `extend` A.object [("content", String html)]
  return output

splitMetadata :: T.Text -> Action (Value, T.Text)
splitMetadata input = case parseOnly parser input of
  Left  err    -> fail $ err
  Right parsed -> return parsed
 where

  separator  = (string "---" *> endOfLine)

  metaParser = do
    separator
    header <- T.pack <$> manyTill anyChar separator
    return $ case decodeEither' (encodeUtf8 header) of
      Left  _      -> Null
      Right parsed -> parsed

  parser = do
    meta    <- option Null metaParser
    content <- takeText
    return (meta, content)
