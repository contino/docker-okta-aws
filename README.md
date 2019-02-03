# Docker Okta
Containerised Okta CLI with Python AWS sdks installed.

## Usage
Run as a command:

```
docker run --rm -v ~/.aws:/root/.aws contino/okta-aws
```

Using docker-compose:

```
okta:
  image: contino/okta-aws
  env_file: .env
  volumes:
    - ~/.aws:/root/.aws
```

And run `docker-compose run okta` to be prompted with username and password.

Can also set as a bash function and placed in your `~/.bashrc` or equivalent
for quick access:

```
function okta { docker run --rm -it -v ~/.aws:/root/.aws contino/okta-aws; }
```

Then run `okta` on your terminal to be prompted.

## Extra Configuration
Please see [okta](https://github.com/oktadeveloper/okta-aws-cli-assume-role)
for further detail on Okta related configuration. Here are some quick
environment variables to get you started:

- `OKTA_ORG` - Name of your organisation in Okta settings. Must be set.
- `OKTA_AWS_APP_URL` - Your unique application URL. Must be set.
- `OKTA_AWS_ROLE_TO_ASSUME` - The initial role to assume if found, otherwise will prompt  with list (default: '')
- `OKTA_AWS_DEFAULT_REGION` - The region your Okta login is to take place in (default: 'ap-southeast-2')

If requiring an assume role after your primary Okta login, these variables
can be used to automatically assume into the role desired:

- `AWS_ASSUME_ROLE_ARN` - The full ARN of the account and role you wish to assume into after Okta authentication
- `AWS_ASSUME_SESSION_NAME` - Custom session name to be used in assuming (default: 'OktaAssumeRole')

## Build
Update the `OKTA_VERSION` in both `Makefile` and `DockerFile`. The run:

    make build

Docker Hub will automatically triger a new build.

## Related Projects
- [hashicorp/terraform](https://hub.docker.com/r/hashicorp/terraform/)
- [docker-aws-cli](https://github.com/contino/docker-aws-cli)
