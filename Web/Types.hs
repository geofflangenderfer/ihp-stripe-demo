module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data UserController
    = UsersAction
    | NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)

data SubscriptionController
    = SubscriptionsAction
    | NewSubscriptionAction
    | ShowSubscriptionAction { subscriptionId :: !(Id Subscription) }
    | CreateSubscriptionAction
    | EditSubscriptionAction { subscriptionId :: !(Id Subscription) }
    | UpdateSubscriptionAction { subscriptionId :: !(Id Subscription) }
    | DeleteSubscriptionAction { subscriptionId :: !(Id Subscription) }
    deriving (Eq, Show, Data)
