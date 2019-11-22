when stripe events customer_subscription_deleted as subscription
  customer = stripe retrieve_customer id:subscription["customer"]

  psql update table:"users" values:{"subscribed":false} where:{"email":customer["email"]}

  mailgun send to:customer["email"]
               from:"hello@example.com"
               subject:"Subscription Cancelled"
               text:"Your subscription has been cancelled due to a failed payment."
