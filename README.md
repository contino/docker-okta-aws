# Docker Okta
Containerised Okta CLI with Python AWS sdks installed.

## Usage
The below 2 examples assume that you will be utilising environment
variables within a .env file. A configuration file can be bind mounted instead.

### Docker
Run as a command:

```bash
docker run --rm -v ~/.aws:/root/.aws contino/okta-aws
```

### Docker-Compose
Using docker-compose:

```yaml
okta:
  image: contino/okta-aws
  env_file: .env
  volumes:
    - ~/.aws:/root/.aws
```

And run `docker-compose run okta` to be prompted with username and password.

### Bash
Can also set as a bash function and placed in your `~/.bashrc` or equivalent
for quick access, with a configuration file:

```bash
function okta() {
  docker run --rm -it -v ~/.okta/config.properties:/root/.okta/config.properties -v ~/.aws:/root/.aws contino/okta-aws;
}
```

Then run `okta` on your terminal to be prompted.

## Configuration
Please see [Okta](https://github.com/oktadeveloper/okta-aws-cli-assume-role)
for further details.

### Environment Variables
Here are some quick environment variables to get you started:

- `OKTA_ORG` - Name of your organisation in Okta settings. Must be set.
- `OKTA_AWS_APP_URL` - Your unique application URL. Must be set.
- `OKTA_AWS_ROLE_TO_ASSUME` - The initial role to assume if found, otherwise will prompt  with list (default: '')
- `OKTA_AWS_DEFAULT_REGION` - The region your Okta login is to take place in (default: 'ap-southeast-2')
- `OKTA_USERNAME` - Your personal Okta username, if not set will be prompted to enter in manually
- `OKTA_AWS_PROFILE` - Custom name for the okta profile to use (default: 'default')

If requiring an assume role after your primary Okta login, these variables
can be used to automatically assume into the role desired:

- `AWS_ASSUME_ROLE_ARN` - The full ARN of the account and role you wish to assume into after Okta authentication
- `AWS_ASSUME_SESSION_NAME` - Custom session name to be used in assuming (default: 'OktaAssumeRole')

### Configuration File
If wanting to store all configuration for Okta in a static file instead, you
have the functionality to bind mount a configuration file directly into the
container. See below example of what it can look like.

Save below contents in a file located `~/.okta/config.properties`:

```
OKTA_ORG=my-org.okta.com
OKTA_AWS_APP_URL=https://my-org.okta.com/home/amazon_aws/123456789
```

## Build
Update the `OKTA_VERSION` in both `Makefile` and `Dockerfile`. The run:

    make build

Docker Hub will automatically trigger a new build.

## Related Projects
- [hashicorp/terraform](https://hub.docker.com/r/hashicorp/terraform/)
- [docker-aws-cli](https://github.com/contino/docker-aws-cli)
