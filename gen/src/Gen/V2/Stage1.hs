{-# LANGUAGE BangPatterns               #-}
{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TemplateHaskell            #-}

-- Module      : Gen.V2.Stage1
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Gen.V2.Stage1 where

import Control.Error
import Control.Monad
import Data.HashMap.Strict (HashMap)
import Data.Jason
import Data.Jason.Types
import Data.Monoid
import Data.Text           (Text)
import Gen.V2.Log
import Gen.V2.TH
import Gen.V2.Types

data Metadata = Metadata
    { _mServiceFullName     :: Text
    , _mServiceAbbreviation :: Maybe Text
    , _mApiVersion          :: Text
    , _mEndpointPrefix      :: Text
    , _mGlobalEndpoint      :: Maybe Text
    , _mSignatureVersion    :: !Signature
    , _mXmlNamespace        :: Maybe Text
    , _mTargetPrefix        :: Maybe Text
    , _mJsonVersion         :: Maybe Text
    , _mTimestampFormat     :: Maybe Timestamp
    , _mChecksumFormat      :: Maybe Checksum
    , _mProtocol            :: !Protocol
    } deriving (Eq, Show)

classy stage1 ''Metadata

data HTTP = HTTP
    { _hMethod     :: !Method
    , _hRequestUri :: Text
    } deriving (Eq, Show)

record stage1 ''HTTP

data Ref = Ref
    { _rShape         :: Text
    , _rDocumentation :: Maybe Text
    , _rResultWrapper :: Maybe Text
    } deriving (Eq, Show)

record stage1 ''Ref

data Error = Error
    { _eShape         :: Text
    , _eDocumentation :: Maybe Text
    , _eException     :: !Bool
    } deriving (Eq, Show)

record stage1 ''Error

data Operation = Operation
    { _oName          :: Text
    , _oDocumentation :: Maybe Text
    , _oHttp          :: HTTP
    , _oInput         :: Maybe Ref
    , _oOutput        :: Maybe Ref
    , _oErrors        :: Maybe [Error]
    } deriving (Eq, Show)

record stage1 ''Operation

data Shape = Shape
    deriving (Eq, Show)

record stage1 ''Shape

data Pager  = Pager
data Waiter = Waiter

data Stage1 = Stage1
    { _s1Metadata      :: Metadata
    , _s1Documentation :: Maybe Text
    , _s1Operations    :: HashMap Text Value
    , _s1Shapes        :: HashMap Text Value
    , _s1Pagination    :: HashMap Text Value
    , _a1Waiters       :: HashMap Text Value
    } deriving (Eq, Show)

record stage1 ''Stage1

instance HasMetadata Stage1 where
    metadata = s1Metadata

decodeS1 :: Model S1 -> Script Stage1
decodeS1 Model{..} = do
    say "Decode Model" _mPath
    hoistEither (parseEither parseJSON (Object _mModel))
