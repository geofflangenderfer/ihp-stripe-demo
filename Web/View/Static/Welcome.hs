module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
    <main>
      <p>Welcome to the Stripe sample for starting a new fixed price subscription.</p>

      <p><a href="/NewUser">Start Demo</a></p>
    </main>
|]
