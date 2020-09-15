module Utils where

import           Data.Aeson             as A
import           Development.Shake

convert :: (FromJSON a) => Value -> Action a
convert v = case fromJSON (toJSON v) of
              A.Success r   -> pure r
              A.Error   err -> fail $ "convert : json conversion failed : " ++ err
