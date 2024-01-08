# bitcoin-fee-notifier

Receive a notification when Bitcoin transaction fees are cheap.

## Requirements

You should install [Nushell](https://www.nushell.sh/) if you want to run it standalone, a standard Docker installation
is required otherwise.

You'll need a [ntfy.sh](https://ntfy.sh/) topic to receive the notifications.

## Configuration

Configuration is done through the following environment variables.

### NTFY_TOPIC

The [ntfy topic](https://docs.ntfy.sh/publish/) which will receive these notifications.

Required.

Example:

```
NTFY_TOPIC=nzmJdHAjFgVw8DOm
```

### CHEAP_FEE

The sat/vB lower limit which will enable sending the cheap fees notification.

Defaults to 35.

Example:

```
CHEAP_FEE=10
```

## Usage (standalone)

```bash
NTFY_TOPIC=nzmJdHAjFgVw8DOm CHEAP_FEE=10 ./bitcoin-fee-notifier.nu
```

## Usage (Docker)

```bash
docker build -t bitcoin-fee-notifier .
docker run -d --rm --name bitcoin-fee-notifier -e "NTFY_TOPIC=nzmJdHAjFgVw8DOm" bitcoin-fee-notifier
```

## License

[The Unlicense](https://choosealicense.com/licenses/unlicense/)
