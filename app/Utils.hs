{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings   #-}

module Utils
  ( convert
  , compileTemplate
  , markdownToHTML
  )
where

import           CMarkGFM                       ( commonmarkToHtml )
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

import qualified Data.HashMap.Lazy             as HML
import qualified Data.Text                     as T

convert :: (FromJSON a) => Value -> Action a
convert v = case fromJSON (toJSON v) of
  A.Success r   -> pure r
  A.Error   err -> fail $ "convert : json conversion failed : " ++ err

extend :: Value -> Value -> Value
extend (Object a) (Object b) = Object $ HML.union a b
extend (Object a) _          = Object a
extend _          _          = error $ "extend : cannot extend non-object value"

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
  let html   = commonmarkToHtml [] [] content
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
