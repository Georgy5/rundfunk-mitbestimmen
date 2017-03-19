# rundfunk-mitbestimmen

[![Join the chat at https://gitter.im/rundfunk-mitbestimmen/Lobby](https://badges.gitter.im/rundfunk-mitbestimmen/Lobby.svg)](https://gitter.im/rundfunk-mitbestimmen/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build
Status](https://travis-ci.org/roschaefer/rundfunk-mitbestimmen.svg?branch=master)](https://travis-ci.org/roschaefer/rundfunk-mitbestimmen)

Since 2013, every household in Germany has to pay fees for public
broadcasting without any legal opt-out.

We think this is a great example for a "cultural flatrate", a system where
every citizen must pay a certain amount on a regular basis and the money gets
re-distributed to authors of creative content e.g. music, films, books,
podcasts, newspapers, software etc. Only question: Who should decide who
gets how much and for what?

Well, we let **YOU** decide!

That's right, who could decide better about the quality of content than
the consumer?

In Germany, certain broadcasting councils have the exclusive rights to
determine our TV and radio programme and to govern the mind-boggling amount of
*€8,000,000,000* every year.

We want to change that: With this app you can make your voice heard and propose
on which shows your €17.50 per month should be spent.


## Live App

Visit [rundfunk-mitbestimmen.de](http://rundfunk-mitbestimmen.de/)

## Structure

This repository serves as meta-repository for both frontend and backend. We
track user requirements and general documentation here. It contains acceptance
tests as they need to be run against the entire stack.

## Process explanation

The backend is responsible to store the data. Who wants to pay for which
broadcast and how much? Users are related to broadcasts via `selections` in the
database. The `response` on the selection model can be either `negative`,
`neutral` and `positive` and indicates whether a user wants to give money to a
broadcast. If the `response` is positive, the `amount` further specifies how
much to pay for a broadcast. So, the sum of all amounts per user must not exceed
the monthly fee of 17,50€ per month.

![ER diagram](/documentation/images/er.png)

The frontend should be as easy to use as possible. The user can
login and register, fetch a set of not yet voted broadcasts, decide about
broadcasts, assign money and see the public statistics. Most of these
actions will send requests to the backend. The app should keep the required user
action to a minimum. E.g. on the invoice page, amounts are evenly distributed
with the option to set the amount explicitly.

![Process diagram](/documentation/images/process.png)

## Installation

This repository contains three important folders:

1. [frontend](https://github.com/roschaefer/rundfunk-mitbestimmen/tree/master/frontend) (EmberJS)
2. [backend](https://github.com/roschaefer/rundfunk-mitbestimmen/tree/master/backend) (Ruby on Rails)
3. [features](https://github.com/roschaefer/rundfunk-mitbestimmen/tree/master/features) (Cucumber/Capybara)

Make sure that you have a recent version of [npm](https://www.npmjs.com/) and
[ruby](https://www.ruby-lang.org/en/) installed before you proceed. E.g. we have
the following versions:

```sh
npm --version
# 4.0.2
ruby --version
# ruby 2.4.0p0 (2016-12-24 revision 57164) [x86_64-linux]
```

Clone the repository:
```sh
git clone https://github.com/roschaefer/rundfunk-mitbestimmen.git
```

Install dependencies and run migrations:
```sh
bundle

cd frontend
npm install
bower install

cd ../backend
bundle
bin/rails db:create db:migrate
cd ..
```

If you want, you can create some seed data
```
cd backend
bin/rails db:seed
cd ..
```


## Usage

Start the backend:
```sh
cd backend && bin/rails s
```

Open another terminal and start the frontend:
```sh
cd frontend && ember serve
```

If you are lazy, you can run both frontend and backend through foreman:
```sh
gem install foreman
foreman start
```

App is running on [localhost:4200](http://localhost:4200/)

## Full stack testing

Run:
```sh
foreman start -f ProcfileTesting
```

Open another terminal and run:
```sh
bundle exec cucumber
```

If you want to run firefox instead of chrome, you can set an environment
variable:
```sh
BROWSER=selenium bundle exec cucumber
```

### Frontend tests

```sh
cd frontend && ember test --serve
```

### Backend tests

```sh
cd backend && bin/rspec
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :heart:


## Useful Links

* [ember.js](http://emberjs.com/)
* [ember-cli](http://ember-cli.com/)
* Development Browser Extensions
  * [ember inspector for chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi)
  * [ember inspector for firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)


## License

See the [LICENSE](LICENSE.md) file for license rights and limitations
(MIT).
