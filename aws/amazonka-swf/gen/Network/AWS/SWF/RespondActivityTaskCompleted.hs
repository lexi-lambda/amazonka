{-# LANGUAGE DataKinds                   #-}
{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving  #-}
{-# LANGUAGE LambdaCase                  #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.SWF.RespondActivityTaskCompleted
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Used by workers to tell the service that the ActivityTask identified by the
-- taskToken completed successfully with a result (if provided). The result
-- appears in the ActivityTaskCompleted event in the workflow history. If the
-- requested task does not complete successfully, use
-- RespondActivityTaskFailed instead. If the worker finds that the task is
-- canceled through the canceled flag returned by RecordActivityTaskHeartbeat,
-- it should cancel the task, clean up and then call
-- RespondActivityTaskCanceled. A task is considered open from the time that
-- it is scheduled until it is closed. Therefore a task is reported as open
-- while a worker is processing it. A task is closed after it has been
-- specified in a call to RespondActivityTaskCompleted,
-- RespondActivityTaskCanceled, RespondActivityTaskFailed, or the task has
-- timed out. Access Control You can use IAM policies to control this action's
-- access to Amazon SWF resources as follows: Use a Resource element with the
-- domain name to limit the action to only specified domains. Use an Action
-- element to allow or deny permission to call this action. You cannot use an
-- IAM policy to constrain this action's parameters. If the caller does not
-- have sufficient permissions to invoke the action, or the parameter values
-- fall outside the specified constraints, the action fails by throwing
-- OperationNotPermitted. For details and example IAM policies, see Using IAM
-- to Manage Access to Amazon SWF Workflows.
--
-- <http://docs.aws.amazon.com/amazonswf/latest/apireference/API_RespondActivityTaskCompleted.html>
module Network.AWS.SWF.RespondActivityTaskCompleted
    (
    -- * Request
      RespondActivityTaskCompleted
    -- ** Request constructor
    , respondActivityTaskCompleted
    -- ** Request lenses
    , ratcResult
    , ratcTaskToken

    -- * Response
    , RespondActivityTaskCompletedResponse
    -- ** Response constructor
    , respondActivityTaskCompletedResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.SWF.Types
import qualified GHC.Exts

data RespondActivityTaskCompleted = RespondActivityTaskCompleted
    { _ratcResult    :: Maybe Text
    , _ratcTaskToken :: Text
    } deriving (Eq, Ord, Show)

-- | 'RespondActivityTaskCompleted' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ratcResult' @::@ 'Maybe' 'Text'
--
-- * 'ratcTaskToken' @::@ 'Text'
--
respondActivityTaskCompleted :: Text -- ^ 'ratcTaskToken'
                             -> RespondActivityTaskCompleted
respondActivityTaskCompleted p1 = RespondActivityTaskCompleted
    { _ratcTaskToken = p1
    , _ratcResult    = Nothing
    }

-- | The result of the activity task. It is a free form string that is
-- implementation specific.
ratcResult :: Lens' RespondActivityTaskCompleted (Maybe Text)
ratcResult = lens _ratcResult (\s a -> s { _ratcResult = a })

-- | The taskToken of the ActivityTask. The taskToken is generated by the
-- service and should be treated as an opaque value. If the task is passed
-- to another process, its taskToken must also be passed. This enables it to
-- provide its progress and respond with results.
ratcTaskToken :: Lens' RespondActivityTaskCompleted Text
ratcTaskToken = lens _ratcTaskToken (\s a -> s { _ratcTaskToken = a })

data RespondActivityTaskCompletedResponse = RespondActivityTaskCompletedResponse
    deriving (Eq, Ord, Show, Generic)

-- | 'RespondActivityTaskCompletedResponse' constructor.
respondActivityTaskCompletedResponse :: RespondActivityTaskCompletedResponse
respondActivityTaskCompletedResponse = RespondActivityTaskCompletedResponse

instance ToPath RespondActivityTaskCompleted where
    toPath = const "/"

instance ToQuery RespondActivityTaskCompleted where
    toQuery = const mempty

instance ToHeaders RespondActivityTaskCompleted

instance ToJSON RespondActivityTaskCompleted where
    toJSON RespondActivityTaskCompleted{..} = object
        [ "taskToken" .= _ratcTaskToken
        , "result"    .= _ratcResult
        ]

instance AWSRequest RespondActivityTaskCompleted where
    type Sv RespondActivityTaskCompleted = SWF
    type Rs RespondActivityTaskCompleted = RespondActivityTaskCompletedResponse

    request  = post "RespondActivityTaskCompleted"
    response = nullResponse RespondActivityTaskCompletedResponse
