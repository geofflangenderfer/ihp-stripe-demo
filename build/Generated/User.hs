-- This file is auto generated and will be overriden regulary. Please edit `Application/Schema.sql` to change the Types\n"
{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, InstanceSigs, MultiParamTypeClasses, TypeFamilies, DataKinds, TypeOperators, UndecidableInstances, ConstraintKinds, StandaloneDeriving  #-}
{-# OPTIONS_GHC -Wno-unused-imports -Wno-dodgy-imports -Wno-unused-matches #-}
module Generated.User where
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
import Generated.ActualTypes
instance InputValue User where inputValue = IHP.ModelSupport.recordToInputValue


instance FromRow User where
    fromRow = do
        id <- field
        stripeCustomerId <- field
        createdAt <- field
        updatedAt <- field
        subscriptionId <- field
        firstName <- field
        lastName <- field
        email <- field
        let theRecord = User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email (QueryBuilder.filterWhere (#userId, id) (QueryBuilder.query @Subscription)) def { originalDatabaseRecord = Just (Data.Dynamic.toDyn theRecord) }
        pure theRecord


type instance GetModelName (User' _) = "User"

instance CanCreate User where
    create :: (?modelContext :: ModelContext) => User -> IO User
    create model = do
        List.head <$> sqlQuery "INSERT INTO users (id, stripe_customer_id, created_at, updated_at, subscription_id, first_name, last_name, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING id, stripe_customer_id, created_at, updated_at, subscription_id, first_name, last_name, email" ((fieldWithDefault #id model, model.stripeCustomerId, fieldWithDefault #createdAt model, fieldWithDefault #updatedAt model, model.subscriptionId, model.firstName, model.lastName, model.email))
    createMany [] = pure []
    createMany models = do
        sqlQuery (Query $ "INSERT INTO users (id, stripe_customer_id, created_at, updated_at, subscription_id, first_name, last_name, email) VALUES " <> (ByteString.intercalate ", " (List.map (\_ -> "(?, ?, ?, ?, ?, ?, ?, ?)") models)) <> " RETURNING id, stripe_customer_id, created_at, updated_at, subscription_id, first_name, last_name, email") (List.concat $ List.map (\model -> [toField (fieldWithDefault #id model), toField (model.stripeCustomerId), toField (fieldWithDefault #createdAt model), toField (fieldWithDefault #updatedAt model), toField (model.subscriptionId), toField (model.firstName), toField (model.lastName), toField (model.email)]) models)

instance CanUpdate User where
    updateRecord model = do
        List.head <$> sqlQuery "UPDATE users SET id = ?, stripe_customer_id = ?, created_at = ?, updated_at = ?, subscription_id = ?, first_name = ?, last_name = ?, email = ? WHERE id = ? RETURNING id, stripe_customer_id, created_at, updated_at, subscription_id, first_name, last_name, email" ((fieldWithUpdate #id model, fieldWithUpdate #stripeCustomerId model, fieldWithUpdate #createdAt model, fieldWithUpdate #updatedAt model, fieldWithUpdate #subscriptionId model, fieldWithUpdate #firstName model, fieldWithUpdate #lastName model, fieldWithUpdate #email model) :. (Only (model.id)))

instance Record User where
    {-# INLINE newRecord #-}
    newRecord = User def def def def def def def def def def


instance QueryBuilder.FilterPrimaryKey "users" where
    filterWhereId id builder =
        builder |> QueryBuilder.filterWhere (#id, id)
    {-# INLINE filterWhereId #-}


instance SetField "id" (User' subscriptions) (Id' "users") where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User newValue stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions (meta { touchedFields = "id" : touchedFields meta })
instance SetField "stripeCustomerId" (User' subscriptions) Text where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User id newValue createdAt updatedAt subscriptionId firstName lastName email subscriptions (meta { touchedFields = "stripeCustomerId" : touchedFields meta })
instance SetField "createdAt" (User' subscriptions) UTCTime where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User id stripeCustomerId newValue updatedAt subscriptionId firstName lastName email subscriptions (meta { touchedFields = "createdAt" : touchedFields meta })
instance SetField "updatedAt" (User' subscriptions) UTCTime where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User id stripeCustomerId createdAt newValue subscriptionId firstName lastName email subscriptions (meta { touchedFields = "updatedAt" : touchedFields meta })
instance SetField "subscriptionId" (User' subscriptions) (Maybe UUID) where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User id stripeCustomerId createdAt updatedAt newValue firstName lastName email subscriptions (meta { touchedFields = "subscriptionId" : touchedFields meta })
instance SetField "firstName" (User' subscriptions) Text where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User id stripeCustomerId createdAt updatedAt subscriptionId newValue lastName email subscriptions (meta { touchedFields = "firstName" : touchedFields meta })
instance SetField "lastName" (User' subscriptions) Text where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User id stripeCustomerId createdAt updatedAt subscriptionId firstName newValue email subscriptions (meta { touchedFields = "lastName" : touchedFields meta })
instance SetField "email" (User' subscriptions) Text where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName newValue subscriptions (meta { touchedFields = "email" : touchedFields meta })
instance SetField "subscriptions" (User' subscriptions) subscriptions where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email newValue (meta { touchedFields = "subscriptions" : touchedFields meta })
instance SetField "meta" (User' subscriptions) MetaBag where
    {-# INLINE setField #-}
    setField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) =
        User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions newValue
instance UpdateField "id" (User' subscriptions) (User' subscriptions) (Id' "users") (Id' "users") where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User newValue stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions (meta { touchedFields = "id" : touchedFields meta })
instance UpdateField "stripeCustomerId" (User' subscriptions) (User' subscriptions) Text Text where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User id newValue createdAt updatedAt subscriptionId firstName lastName email subscriptions (meta { touchedFields = "stripeCustomerId" : touchedFields meta })
instance UpdateField "createdAt" (User' subscriptions) (User' subscriptions) UTCTime UTCTime where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User id stripeCustomerId newValue updatedAt subscriptionId firstName lastName email subscriptions (meta { touchedFields = "createdAt" : touchedFields meta })
instance UpdateField "updatedAt" (User' subscriptions) (User' subscriptions) UTCTime UTCTime where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User id stripeCustomerId createdAt newValue subscriptionId firstName lastName email subscriptions (meta { touchedFields = "updatedAt" : touchedFields meta })
instance UpdateField "subscriptionId" (User' subscriptions) (User' subscriptions) (Maybe UUID) (Maybe UUID) where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User id stripeCustomerId createdAt updatedAt newValue firstName lastName email subscriptions (meta { touchedFields = "subscriptionId" : touchedFields meta })
instance UpdateField "firstName" (User' subscriptions) (User' subscriptions) Text Text where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User id stripeCustomerId createdAt updatedAt subscriptionId newValue lastName email subscriptions (meta { touchedFields = "firstName" : touchedFields meta })
instance UpdateField "lastName" (User' subscriptions) (User' subscriptions) Text Text where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User id stripeCustomerId createdAt updatedAt subscriptionId firstName newValue email subscriptions (meta { touchedFields = "lastName" : touchedFields meta })
instance UpdateField "email" (User' subscriptions) (User' subscriptions) Text Text where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName newValue subscriptions (meta { touchedFields = "email" : touchedFields meta })
instance UpdateField "subscriptions" (User' subscriptions) (User' subscriptions') subscriptions subscriptions' where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email newValue (meta { touchedFields = "subscriptions" : touchedFields meta })
instance UpdateField "meta" (User' subscriptions) (User' subscriptions) MetaBag MetaBag where
    {-# INLINE updateField #-}
    updateField newValue (User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions meta) = User id stripeCustomerId createdAt updatedAt subscriptionId firstName lastName email subscriptions newValue


