-- | Based upon:
--   https://github.com/neongreen/cmark-highlight
--   Copyright (c) 2016, Artyom
--   BSD 3-Clause

{-# LANGUAGE ViewPatterns   #-}
{-# LANGUAGE OverloadedStrings   #-}

module Highlight
  ( highlightNode
  )
where

import           Data.Maybe                     ( fromJust )
import           Data.Text                      ( Text )
import           CMarkGFM
import           Skylighting
import           Text.Blaze.Html.Renderer.Text

import qualified Data.Text                     as T
import qualified Data.Text.Lazy                as TL

{- |
Highlight a document by replacing code blocks with raw HTML blocks.

By default, the rest of the attribute line (i.e. all words after the first word after @~~~@ or @```@) get added as classes to the container block of the code.
-}
highlightNode :: Node -> Node
highlightNode = highlightNodeWith (\_ _ x -> x)

{- |
The function is given code block's language (i.e. the 1st word of the attribute line after @~~~@ or @```@) and the rest of the attribute line.

If you don't want the classes to be derived from the attribute line, make the function set 'containerClasses' to @[]@.
-}
highlightNodeWith :: (Text -> Text -> FormatOptions -> FormatOptions) -> Node -> Node
highlightNodeWith f (Node pos (CODE_BLOCK info code) ns) = Node pos
                                                                (HTML_BLOCK formatted)
                                                                (map (highlightNodeWith f) ns)
 where

  (codeLang, T.drop 1 -> codeInfo) = T.break (== ' ') (T.strip info)

  syntax                           = case lookupSyntax codeLang defaultSyntaxMap of
    Nothing -> fromJust $ lookupSyntax "Default" defaultSyntaxMap
    Just sn -> sn
  config      = TokenizerConfig { traceOutput = False, syntaxMap = defaultSyntaxMap }

  sourceLines = case tokenize config syntax code of
    Left  e  -> error $ e
    Right ls -> ls

  opts      = defaultFormatOpts { containerClasses = (T.words codeInfo) }

  formatted = TL.toStrict . renderHtml $ formatHtmlBlock (f codeLang codeInfo opts) sourceLines

highlightNodeWith f (Node pos type_ ns) = Node pos type_ (map (highlightNodeWith f) ns)
