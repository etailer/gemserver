# Gemstash Docker S3fs

Private RubyGems gem server.

Uses [Gemstash](https://github.com/bundler/gemstash) in a Docker container with the gem directory backed by Amazon S3.

## Usage

ENV variables are required to S3fs to work correctly:

```
S3_BUCKET=
AWS_REGION=
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
```

`docker run --env-file=.env -d etailer/gemserver`

```ruby
# Gemfile
source 'https://gemserver.example.com:9292/'
```
