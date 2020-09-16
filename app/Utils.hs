{-# LANGUAGE OverloadedStrings   #-}

module Utils
  ( convert
  , extend
  )
where

import           Data.Aeson                    as A
import           Development.Shake

import qualified Data.HashMap.Lazy             as HML

convert :: (FromJSON a) => Value -> Action a
convert v = case fromJSON (toJSON v) of
  A.Success r   -> pure r
  A.Error   err -> fail $ "convert : json conversion failed : " ++ err

extend :: Value -> Value -> Value
extend (Object a) (Object b) = Object $ HML.union a b
extend (Object a) _          = Object a
extend _          _          = error $ "extend : cannot extend non-object value"
