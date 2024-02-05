-- This file is auto generated and will be overriden regulary. Please edit `Application/Schema.sql` to change the Types\n"
{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, InstanceSigs, MultiParamTypeClasses, TypeFamilies, DataKinds, TypeOperators, UndecidableInstances, ConstraintKinds, StandaloneDeriving  #-}
{-# OPTIONS_GHC -Wno-unused-imports -Wno-dodgy-imports -Wno-unused-matches #-}
module Generated.ActualTypes (module Generated.ActualTypes, module Generated.Enums) where
import IHP.HaskellSupport
import IHP.ModelSupport
import CorePrelude hiding (id)
import Data.Time.Clock
import Data.Time.LocalTime
import qualified Data.Time.Calendar
import qualified Data.List as List
import qualified Data.ByteString as ByteString
import qualified Net.IP
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.FromField hiding (Field, name)
import Database.PostgreSQL.Simple.ToField hiding (Field)
import qualified IHP.Controller.Param
import GHC.TypeLits
import Data.UUID (UUID)
import Data.Default
import qualified IHP.QueryBuilder as QueryBuilder
import qualified Data.Proxy
import GHC.Records
import Data.Data
import qualified Data.String.Conversions
import qualified Data.Text.Encoding
import qualified Data.Aeson
import Database.PostgreSQL.Simple.Types (Query (Query), Binary ( .. ))
import qualified Database.PostgreSQL.Simple.Types
import IHP.Job.Types
import IHP.Job.Queue ()
import qualified Control.DeepSeq as DeepSeq
import qualified Data.Dynamic
import Data.Scientific
import Generated.Enums
data User' subscriptions = User {id :: (Id' "users"), stripeCustomerId :: Text, createdAt :: UTCTime, updatedAt :: UTCTime, subscriptionId :: (Maybe UUID), firstName :: Text, lastName :: Text, email :: Text, subscriptions :: subscriptions, meta :: MetaBag} deriving (Eq, Show)

type instance PrimaryKey "users" = UUID
type instance Include "subscriptions" (User' subscriptions) = User' [Subscription]

type User = User' (QueryBuilder.QueryBuilder "subscriptions")

type instance GetTableName (User' _) = "users"
type instance GetModelByTableName "users" = User

instance Default (Id' "users") where def = Id def

instance () => Table (User' subscriptions) where
    tableName = "users"
    tableNameByteString = Data.Text.Encoding.encodeUtf8 "users"
    columnNames = ["id","stripe_customer_id","created_at","updated_at","subscription_id","first_name","last_name","email"]
    primaryKeyCondition User { id } = [("id", toField id)]
    {-# INLINABLE primaryKeyCondition #-}



data Subscription' userId = Subscription {id :: (Id' "subscriptions"), userId :: userId, updatedAt :: UTCTime, createdAt :: UTCTime, plan :: Text, price :: Text, priceId :: Text, meta :: MetaBag} deriving (Eq, Show)

type instance PrimaryKey "subscriptions" = UUID
type instance Include "userId" (Subscription' userId) = Subscription' (GetModelById userId)

type Subscription = Subscription' (Id' "users")

type instance GetTableName (Subscription' _) = "subscriptions"
type instance GetModelByTableName "subscriptions" = Subscription

instance Default (Id' "subscriptions") where def = Id def

instance () => Table (Subscription' userId) where
    tableName = "subscriptions"
    tableNameByteString = Data.Text.Encoding.encodeUtf8 "subscriptions"
    columnNames = ["id","user_id","updated_at","created_at","plan","price","price_id"]
    primaryKeyCondition Subscription { id } = [("id", toField id)]
    {-# INLINABLE primaryKeyCondition #-}


