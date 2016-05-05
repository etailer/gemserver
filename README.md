# Geminabox Docker S3fs

Private RubyGems Gem server with optional auth.

Uses [Geminabox](https://github.com/geminabox/geminabox) in a Docker container with the gem directory backed by Amazon S3. Run the [Puma](https://github.com/puma/puma) webserver.

## Usage

`ENV['TOKEN']` can be used to provide basic authentication. If omitted no auth will be used.

Other ENV variables are required to S3fs to work correctly:

```
S3_BUCKET=
AWS_REGION=
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
MOUNT_POINT=/var/geminabox-data
TOKEN= # optional
```

`docker run --env-file=.env -d etailer/gemserver`

```ruby
source 'https://x:secrect_token@gemserver.example.com:9292/' # note the username - this can be anything but must be present.
```
