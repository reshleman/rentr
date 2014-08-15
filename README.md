# Rentr

Rentr is a sample [Airbnb](http://www.airbnb.com)-style app for listing and reserving a room, apartment, or house.

This app was written with @nnarh and @charlesmassry as a team project for @thisismetis.

## Stripe Credentials

In order to use [Stripe](http://www.stripe.com) for payments, you will need to set ENV variables with your [Stripe credentials](https://dashboard.stripe.com/account/apikeys).

For the development and test environments, you can set these variables in the `.env` file in the project root.

A `.env.sample` file is provided for guidance:

```
# To get Stripe API keys, visit:
# https://dashboard.stripe.com/account/apikeys

STRIPE_SECRET_KEY: sk_test_bar
STRIPE_PUBLISHABLE_KEY: pk_test_foo
```

## Seed Data

This app provides default seed data for property types (apartment, house, boat, tipi, etc.) and room types (entire home/apartment, private room, shared room).

You may modify the seed data by editing `db/seeds.rb`; alternatively, you may manually add your own types in Rails console.

Consider using Wikipedia's exhaustive [List of House Types](http://en.wikipedia.org/wiki/List_of_house_types) as a source for additional property types.

### Seeding the Database

Create the database if you haven't already done so:

```
rake db:create
```

Run the migrations:

```
rake db:migrate
```

Then, load the seed data:

```
rake db:seed
```

If you make changes to `db/seeds.rb`, you can safely re-run `rake db:seed` without duplicating property types or room types in your database.
