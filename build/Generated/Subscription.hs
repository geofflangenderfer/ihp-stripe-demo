-- This file is auto generated and will be overriden regulary. Please edit `Application/Schema.sql` to change the Types\n"
{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, InstanceSigs, MultiParamTypeClasses, TypeFamilies, DataKinds, TypeOperators, UndecidableInstances, ConstraintKinds, StandaloneDeriving  #-}
{-# OPTIONS_GHC -Wno-unused-imports -Wno-dodgy-imports -Wno-unused-matches #-}
module Generated.Subscription where
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
instance InputValue Subscription where inputValue = IHP.ModelSupport.recordToInputValue


instance FromRow Subscription where
    fromRow = do
        id <- field
        userId <- field
        updatedAt <- field
        createdAt <- field
        plan <- field
        price <- field
        let theRecord = Subscription id userId updatedAt createdAt plan price def { originalDatabaseRecord = Just (Data.Dynamic.toDyn theRecord) }
        pure theRecord


type instance GetModelName (Subscription' _) = "Subscription"

instance CanCreate Subscription where
    create :: (?modelContext :: ModelContext) => Subscription -> IO Subscription
    create model = do
        List.head <$> sqlQuery "INSERT INTO subscriptions (id, user_id, updated_at, created_at, plan, price) VALUES (?, ?, ?, ?, ?, ?) RETURNING id, user_id, updated_at, created_at, plan, price" ((fieldWithDefault #id model, model.userId, fieldWithDefault #updatedAt model, fieldWithDefault #createdAt model, model.plan, model.price))
    createMany [] = pure []
    createMany models = do
        sqlQuery (Query $ "INSERT INTO subscriptions (id, user_id, updated_at, created_at, plan, price) VALUES " <> (ByteString.intercalate ", " (List.map (\_ -> "(?, ?, ?, ?, ?, ?)") models)) <> " RETURNING id, user_id, updated_at, created_at, plan, price") (List.concat $ List.map (\model -> [toField (fieldWithDefault #id model), toField (model.userId), toField (fieldWithDefault #updatedAt model), toField (fieldWithDefault #createdAt model), toField (model.plan), toField (model.price)]) models)

instance CanUpdate Subscription where
    updateRecord model = do
        List.head <$> sqlQuery "UPDATE subscriptions SET id = ?, user_id = ?, updated_at = ?, created_at = ?, plan = ?, price = ? WHERE id = ? RETURNING id, user_id, updated_at, created_at, plan, price" ((fieldWithUpdate #id model, fieldWithUpdate #userId model, fieldWithUpdate #updatedAt model, fieldWithUpdate #createdAt model, fieldWithUpdate #plan model, fieldWithUpdate #price model, model.id))

instance Record Subscription where
    {-# INLINE newRecord #-}
    newRecord = Subscription def def def def def def  def


instance QueryBuilder.FilterPrimaryKey "subscriptions" where
    filterWhereId id builder =
        builder |> QueryBuilder.filterWhere (#id, id)
    {-# INLINE filterWhereId #-}


instance SetField "id" (Subscription' userId) (Id' "subscriptions") where
    {-# INLINE setField #-}
    setField newValue (Subscription id userId updatedAt createdAt plan price meta) =
        Subscription newValue userId updatedAt createdAt plan price (meta { touchedFields = "id" : touchedFields meta })
instance SetField "userId" (Subscription' userId) userId where
    {-# INLINE setField #-}
    setField newValue (Subscription id userId updatedAt createdAt plan price meta) =
        Subscription id newValue updatedAt createdAt plan price (meta { touchedFields = "userId" : touchedFields meta })
instance SetField "updatedAt" (Subscription' userId) UTCTime where
    {-# INLINE setField #-}
    setField newValue (Subscription id userId updatedAt createdAt plan price meta) =
        Subscription id userId newValue createdAt plan price (meta { touchedFields = "updatedAt" : touchedFields meta })
instance SetField "createdAt" (Subscription' userId) UTCTime where
    {-# INLINE setField #-}
    setField newValue (Subscription id userId updatedAt createdAt plan price meta) =
        Subscription id userId updatedAt newValue plan price (meta { touchedFields = "createdAt" : touchedFields meta })
instance SetField "plan" (Subscription' userId) Text where
    {-# INLINE setField #-}
    setField newValue (Subscription id userId updatedAt createdAt plan price meta) =
        Subscription id userId updatedAt createdAt newValue price (meta { touchedFields = "plan" : touchedFields meta })
instance SetField "price" (Subscription' userId) Text where
    {-# INLINE setField #-}
    setField newValue (Subscription id userId updatedAt createdAt plan price meta) =
        Subscription id userId updatedAt createdAt plan newValue (meta { touchedFields = "price" : touchedFields meta })
instance SetField "meta" (Subscription' userId) MetaBag where
    {-# INLINE setField #-}
    setField newValue (Subscription id userId updatedAt createdAt plan price meta) =
        Subscription id userId updatedAt createdAt plan price newValue
instance UpdateField "id" (Subscription' userId) (Subscription' userId) (Id' "subscriptions") (Id' "subscriptions") where
    {-# INLINE updateField #-}
    updateField newValue (Subscription id userId updatedAt createdAt plan price meta) = Subscription newValue userId updatedAt createdAt plan price (meta { touchedFields = "id" : touchedFields meta })
instance UpdateField "userId" (Subscription' userId) (Subscription' userId') userId userId' where
    {-# INLINE updateField #-}
    updateField newValue (Subscription id userId updatedAt createdAt plan price meta) = Subscription id newValue updatedAt createdAt plan price (meta { touchedFields = "userId" : touchedFields meta })
instance UpdateField "updatedAt" (Subscription' userId) (Subscription' userId) UTCTime UTCTime where
    {-# INLINE updateField #-}
    updateField newValue (Subscription id userId updatedAt createdAt plan price meta) = Subscription id userId newValue createdAt plan price (meta { touchedFields = "updatedAt" : touchedFields meta })
instance UpdateField "createdAt" (Subscription' userId) (Subscription' userId) UTCTime UTCTime where
    {-# INLINE updateField #-}
    updateField newValue (Subscription id userId updatedAt createdAt plan price meta) = Subscription id userId updatedAt newValue plan price (meta { touchedFields = "createdAt" : touchedFields meta })
instance UpdateField "plan" (Subscription' userId) (Subscription' userId) Text Text where
    {-# INLINE updateField #-}
    updateField newValue (Subscription id userId updatedAt createdAt plan price meta) = Subscription id userId updatedAt createdAt newValue price (meta { touchedFields = "plan" : touchedFields meta })
instance UpdateField "price" (Subscription' userId) (Subscription' userId) Text Text where
    {-# INLINE updateField #-}
    updateField newValue (Subscription id userId updatedAt createdAt plan price meta) = Subscription id userId updatedAt createdAt plan newValue (meta { touchedFields = "price" : touchedFields meta })
instance UpdateField "meta" (Subscription' userId) (Subscription' userId) MetaBag MetaBag where
    {-# INLINE updateField #-}
    updateField newValue (Subscription id userId updatedAt createdAt plan price meta) = Subscription id userId updatedAt createdAt plan price newValue


