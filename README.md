## About

This is an etude application for file fetching.

## Requirements & Setups

You need to be able to run Ruby 2.7 and bundler.

```

```

## Usage

Usage:

```
$ bundle install --path vendor/bundle
$ ./fetch [--metadata] URL [URLs]
```

The `--metadata` option will show you the metadata of the URL.

## Running on Docker

Docker environment is also provided.

```
$ docker build -t fetcher .
$ docker run -v run:/usr/src/app/run -i -t fetcher
# ./fetch [--metadata] URL [URLs]
```

## Testing

On the root directory, run ruby test files.

```
ruby ./test/test_parser.rb
```
