{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.CodeDeploy.ListDeploymentGroups
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Lists the deployment groups for an application registered with the
-- applicable IAM user or AWS account.
--
-- <http://docs.aws.amazon.com/codedeploy/latest/APIReference/API_ListDeploymentGroups.html>
module Network.AWS.CodeDeploy.ListDeploymentGroups
    (
    -- * Request
      ListDeploymentGroups
    -- ** Request constructor
    , listDeploymentGroups
    -- ** Request lenses
    , ldgNextToken
    , ldgApplicationName

    -- * Response
    , ListDeploymentGroupsResponse
    -- ** Response constructor
    , listDeploymentGroupsResponse
    -- ** Response lenses
    , ldgrsNextToken
    , ldgrsApplicationName
    , ldgrsDeploymentGroups
    , ldgrsStatus
    ) where

import           Network.AWS.CodeDeploy.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Represents the input of a list deployment groups operation.
--
-- /See:/ 'listDeploymentGroups' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ldgNextToken'
--
-- * 'ldgApplicationName'
data ListDeploymentGroups = ListDeploymentGroups'
    { _ldgNextToken       :: !(Maybe Text)
    , _ldgApplicationName :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'ListDeploymentGroups' smart constructor.
listDeploymentGroups :: Text -> ListDeploymentGroups
listDeploymentGroups pApplicationName_ =
    ListDeploymentGroups'
    { _ldgNextToken = Nothing
    , _ldgApplicationName = pApplicationName_
    }

-- | An identifier that was returned from the previous list deployment groups
-- call, which can be used to return the next set of deployment groups in
-- the list.
ldgNextToken :: Lens' ListDeploymentGroups (Maybe Text)
ldgNextToken = lens _ldgNextToken (\ s a -> s{_ldgNextToken = a});

-- | The name of an existing AWS CodeDeploy application associated with the
-- applicable IAM user or AWS account.
ldgApplicationName :: Lens' ListDeploymentGroups Text
ldgApplicationName = lens _ldgApplicationName (\ s a -> s{_ldgApplicationName = a});

instance AWSRequest ListDeploymentGroups where
        type Sv ListDeploymentGroups = CodeDeploy
        type Rs ListDeploymentGroups =
             ListDeploymentGroupsResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ListDeploymentGroupsResponse' <$>
                   (x .?> "nextToken") <*> (x .?> "applicationName") <*>
                     (x .?> "deploymentGroups" .!@ mempty)
                     <*> (pure (fromEnum s)))

instance ToHeaders ListDeploymentGroups where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("CodeDeploy_20141006.ListDeploymentGroups" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ListDeploymentGroups where
        toJSON ListDeploymentGroups'{..}
          = object
              ["nextToken" .= _ldgNextToken,
               "applicationName" .= _ldgApplicationName]

instance ToPath ListDeploymentGroups where
        toPath = const "/"

instance ToQuery ListDeploymentGroups where
        toQuery = const mempty

-- | Represents the output of a list deployment groups operation.
--
-- /See:/ 'listDeploymentGroupsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ldgrsNextToken'
--
-- * 'ldgrsApplicationName'
--
-- * 'ldgrsDeploymentGroups'
--
-- * 'ldgrsStatus'
data ListDeploymentGroupsResponse = ListDeploymentGroupsResponse'
    { _ldgrsNextToken        :: !(Maybe Text)
    , _ldgrsApplicationName  :: !(Maybe Text)
    , _ldgrsDeploymentGroups :: !(Maybe [Text])
    , _ldgrsStatus           :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'ListDeploymentGroupsResponse' smart constructor.
listDeploymentGroupsResponse :: Int -> ListDeploymentGroupsResponse
listDeploymentGroupsResponse pStatus_ =
    ListDeploymentGroupsResponse'
    { _ldgrsNextToken = Nothing
    , _ldgrsApplicationName = Nothing
    , _ldgrsDeploymentGroups = Nothing
    , _ldgrsStatus = pStatus_
    }

-- | If the amount of information that is returned is significantly large, an
-- identifier will also be returned, which can be used in a subsequent list
-- deployment groups call to return the next set of deployment groups in
-- the list.
ldgrsNextToken :: Lens' ListDeploymentGroupsResponse (Maybe Text)
ldgrsNextToken = lens _ldgrsNextToken (\ s a -> s{_ldgrsNextToken = a});

-- | The application name.
ldgrsApplicationName :: Lens' ListDeploymentGroupsResponse (Maybe Text)
ldgrsApplicationName = lens _ldgrsApplicationName (\ s a -> s{_ldgrsApplicationName = a});

-- | A list of corresponding deployment group names.
ldgrsDeploymentGroups :: Lens' ListDeploymentGroupsResponse [Text]
ldgrsDeploymentGroups = lens _ldgrsDeploymentGroups (\ s a -> s{_ldgrsDeploymentGroups = a}) . _Default . _Coerce;

-- | FIXME: Undocumented member.
ldgrsStatus :: Lens' ListDeploymentGroupsResponse Int
ldgrsStatus = lens _ldgrsStatus (\ s a -> s{_ldgrsStatus = a});
