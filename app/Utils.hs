module Utils where

import           Data.Aeson             as A
import           Development.Shake
import           Text.Mustache
import           Text.Mustache.Compile  (getPartials)

convert :: (FromJSON a) => Value -> Action a
convert v = case fromJSON (toJSON v) of
  A.Success r   -> pure r
  A.Error   err -> fail $ "convert : json conversion failed : " ++ err

compileTemplate :: FilePath -> Action Template
compileTemplate fp = do
  need $ pure fp
  result <- liftIO $ localAutomaticCompile fp
  case result of
    Right template -> do
      need . getPartials . ast $ template
      return template
    Left err -> fail $ show err
