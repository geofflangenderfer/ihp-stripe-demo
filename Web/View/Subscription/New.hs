module Web.View.Subscription.New where
import Web.View.Prelude

data NewView = NewView { subscription :: Subscription }

instance View NewView where
    html NewView { .. } = [hsx|

        {breadcrumb}
        <h1>New Subscription</h1>
        <h1>userId: {subscription.userId}</h1>
        <div>
            <span>
                $99/month
                {renderSimplePlan subscription}
            </span>
            <span>
                $199/month
                {renderPremiumPlan subscription}
            </span>
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Subscriptions" SubscriptionsAction
                , breadcrumbText "New Subscription"
                ]

renderSimplePlan subscription = formFor subscription [hsx|
    <input type="hidden" id="plan" name="plan" value="monthly" />
    <input type="hidden" id="price" name="price" value="99" />
    <input type="hidden" id="priceId" name="priceId" value="price_1OfO4xIa2YCAcFeYix02c5Jq" />
    <input type="hidden" id="userId" name="userId" value={subscription.userId} />
    {submitButton}
|]
renderPremiumPlan subscription = formFor subscription [hsx|
    <input type="hidden" id="plan" name="plan" value="monthly" />
    <input type="hidden" id="price" name="price" value="199" />
    <input type="hidden" id="priceId" name="priceId" value="price_1OfO4xIa2YCAcFeYcYkh8N4d" />
    <input type="hidden" id="userId" name="userId" value={subscription.userId} />
    {submitButton}
|]
