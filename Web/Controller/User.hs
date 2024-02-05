module Web.Controller.User where

-- import StripeAPI.Common (runWithConfiguration)
-- import StripeAPI.Configuration (defaultConfiguration)
-- import StripeAPI.Operations.PostCustomers (postCustomers, PostCustomersResponse200, mkPostCustomersRequestBody)
-- import StripeAPI.SecuritySchemes (basicAuthenticationSecurityScheme, BasicAuthenticationData, basicAuthenticationDataUsername, basicAuthenticationDataPassword)
-- import StripeAPI.Types.Customer.Customer
import Web.Controller.Prelude
import Web.View.User.Index
import Web.View.User.New
import Web.View.User.Edit
import Web.View.User.Show
import qualified Data.Text as T
import qualified Network.HTTP.Simple as HS
import qualified StripeAPI as Stripe
import qualified StripeAPI.Types.NotificationEventData.Extra as Stripe
import Control.Monad.Trans.Except (ExceptT, throwE, runExceptT)
import IHP.ControllerPrelude
import qualified Data.Text.IO as TIO

instance Controller UserController where
    action UsersAction = do
        user <- query @User |> fetch
        render IndexView { .. }

    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    action ShowUserAction { userId } = do
        user <- fetch userId
        render ShowView { .. }

    action EditUserAction { userId } = do
        user <- fetch userId
        render EditView { .. }

    action UpdateUserAction { userId } = do
        user <- fetch userId
        user
            |> buildUser
            |> ifValid \case
                Left user -> render EditView { .. }
                Right user -> do
                    user <- user |> updateRecord
                    setSuccessMessage "User updated"
                    redirectTo EditUserAction { .. }

    action CreateUserAction = do
        let user = newRecord @User
        result <- createStripeCustomer
        case result of
            Nothing -> render NewView { .. }
            Just customerId -> do
                putStrLn $ "stripe customer id: " ++ customerId
                let userWithCustomerId = user |> set #stripeCustomerId customerId

                userWithCustomerId
                    |> buildUser
                    |> ifValid \case
                        Left user -> render NewView { .. }
                        Right user -> do
                            user <- user |> createRecord
                            setSuccessMessage "User created"
                            redirectTo $ NewSubscriptionAction user.id

    action DeleteUserAction { userId } = do
        user <- fetch userId
        deleteRecord user
        setSuccessMessage "User deleted"
        redirectTo UsersAction

buildUser user = user
    |> fill @'["firstName", "lastName", "email"]

--createStripeCustomer :: IO (Either Text Text)
createStripeCustomer :: (?context::ControllerContext) => IO (Maybe Text)
createStripeCustomer = do
    let body = Stripe.mkPostCustomersRequestBody { Stripe.postCustomersRequestBodyName = Just $ (param "firstName") ++ " " ++ (param "lastName")
        , Stripe.postCustomersRequestBodyEmail = Just (param "email")
        }

    let config = Stripe.basicAuthenticationSecurityScheme Stripe.BasicAuthenticationData { basicAuthenticationDataUsername = "sk_test_51MPCmeIa2YCAcFeYz8ij4I14wzfDqJv8UsMAflU79yP9BA89vQENF5A76D30UQ6eznP3mgXg1PanDB5Md9LfXcBP00EsSThdQq",
            basicAuthenticationDataPassword = ""
          }

    let conf = Stripe.defaultConfiguration { Stripe.configSecurityScheme = config}

    --resp <- Stripe.runWithConfiguration conf $ Stripe.postCustomers (Just body)
    resp <- liftIO $ Stripe.runWithConfiguration conf $ Stripe.postCustomers (Just body)

    -- print resp
    case HS.getResponseBody resp of
        Stripe.PostCustomersResponse200 customer -> pure $ Just (Stripe.customerId customer)
        Stripe.PostCustomersResponseError errorString -> do
            putStrLn $ show errorString
            pure Nothing
        Stripe.PostCustomersResponseDefault stripeError -> do
            let code = Stripe.apiErrorsCode (Stripe.errorError stripeError)
            let message = Stripe.apiErrorsMessage (Stripe.errorError stripeError)
            case code of
                Just actual -> TIO.putStrLn $ "error code: " ++ actual
                Nothing -> putStrLn "no error code"
            case message of
                Just actual -> TIO.putStrLn $ "error message: " ++ actual
                Nothing -> putStrLn "no error message"
            pure Nothing

{-

curl https://api.stripe.com/v1/customers \
  -u "sk_test_51MPCmeIa2YCAcFeYz8ij4I14wzfDqJv8UsMAflU79yP9BA89vQENF5A76D30UQ6eznP3mgXg1PanDB5Md9LfXcBP00EsSThdQq:" \
  -d name="Jenny Rosen" \
  --data-urlencode email="jennyrosen@example.com"

-}
