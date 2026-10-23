# vrtx-rails_demo

Demo Rails application running on JRuby with Vert.x (vrtx@rails). It shows a classic Rails 4.2 app served through the Vert.x/JRuby stack instead of a traditional Ruby app server.

## Stack

- Rails 4.2.7.1 (see `Gemfile`)
- JRuby on the JDK, from the `jruby:9.1.2.0-jdk` image in `Dockerfile.vertx.dev`
- Vert.x with Hazelcast clustering options in `config_host.rb` and `aws-default-cluster.xml`
- PostgreSQL via `activerecord-jdbcpostgresql-adapter` on JRuby, plus a local Redis server in the dev image

## Run with Docker

The dev image exposes port 3000:

```bash
docker build -f Dockerfile.vertx.dev -t vrtx-rails-demo .
docker run -p 3000:3000 vrtx-rails-demo
```

Then open http://localhost:3000.

## Run locally

You need JRuby with a JDK, Bundler, PostgreSQL, and Redis:

```bash
bundle install
bundle exec rails server
```

## Tests

The Rails test suite lives under `test/` (controllers, fixtures, helpers, and integration). Run it with:

```bash
bundle exec rake test
```

## Notes

- `README.rdoc` is the stock Rails readme template.
- Cluster host settings are generated in `config_host.rb`; adjust them before any clustered or AWS deployment.
