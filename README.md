![docker](https://github.frapsoft.com/top/docker-security.jpg)

# alpine-cloud-custodian
 [![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg)](https://github.com/einyx/open-source-badges/) [![Gitter Chat](https://badges.gitter.im/frapsoft/frapsoft.svg)](https://gitter.im/frapsoft/frapsoft/)

## What is it?

Cloud Custodian is a tool that unifies the dozens of tools and scripts most organizations use for managing their AWS accounts into one open source tool. It’s a stateless rules engine for policy definition and enforcement, with metrics and detailed reporting for AWS.

Organizations can use Custodian to manage their AWS environments by ensuring compliance to security policies, tag policies, garbage collection of unused resources, and cost management via off-hours resource management, all from the same place. Custodian policies are written in simple YAML configuration files that specify given resource types and are constructed from a vocabulary of filters and actions.

Please go for further information to the [official documentation](http://www.capitalone.io/cloud-custodian/docs/index.html).

## Installation

`docker pull einyx/cloud-custodian`


### aws-cli

If you have the [aws-cli](https://github.com/aws/aws-cli) configured your ready to run.  
We can mapp your `~/.aws` folder in readOnly mode inside the Container.

```
#!/usr/bin/env bash

function main () {
  docker run \
    -it \
    -v "${HOME}/.aws:/custodian/.aws:ro" \
    -v "${PWD}/logs:/tmp" \
    -v "${PWD}/.cache:/custodian/.cache" \
    -v "${PWD}/policies:/custodian/policies:ro" \
  einyx/cloud-custodian run --output-dir=/tmp \
    policies/my-policy.yml
}

main
```
### Environment Variables

Export `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` so that we can pass them on in the next step inside the Container.

```
#!/usr/bin/env bash

export AWS_ACCESS_KEY_ID="your-key-here"
export AWS_SECRET_ACCESS_KEY="your-sec-key-here"
```

```
#!/usr/bin/env bash

function main () {
  docker run \
    -it \
    -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
    -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
    -v "${PWD}/logs:/tmp" \
    -v "${PWD}/.cache:/custodian/.cache" \
    -v "${PWD}/policies:/custodian/policies:ro" \
  einyx/cloud-custodian run --output-dir=/tmp \
    policies/my-policy.yml
}

main
```

## Folder Structure

`policies`: here is the place to store your policies and run them like in the example with your name.

`logs`: all output logs get's stored there

`.cache`: is needed by the program

## Links

- [Cloud Custodian Website](https://developer.capitalone.com/opensource-projects/cloud-custodian)
- [Cloud Custodian Docs](http://www.capitalone.io/cloud-custodian/docs/index.html)
- [Github Repository](https://github.com/capitalone/cloud-custodian)# cloud-custodian
