#!/usr/bin/env nu

use std log

if "NTFY_TOPIC" not-in $env {
    log error "You must define a ntfy.sh topic as NTFY_TOPIC"
    exit 1
}

const last_fee = '/tmp/last_cheap_fee'

if not ($last_fee | path exists) {
    '65535' | save $last_fee
}

let fee = (http get https://mempool.space/api/v1/fees/recommended).hourFee
let cheap = $env.CHEAP_FEE? | default 15 | into int
let last = open $last_fee | into int
let rising_trigger = $env.RISING_TRIGGER? | default 1.5 | into float

if $fee < $cheap {
    if $fee < $last {
        http post --headers [Title 'Cheap transaction fees!' Tags partying_face] $'https://ntfy.sh/($env.NTFY_TOPIC)' $'($fee) sat/vB'
        $fee | save -f $last_fee
        log debug $'Notified cheap transaction fees at ($fee) sat/vB'
    } else if $fee > $last * $rising_trigger {
        http post --headers [Title 'Transaction fees rising!' Tags facepalm] $'https://ntfy.sh/($env.NTFY_TOPIC)' $'($fee) sat/vB'
        $fee | save -f $last_fee
        log debug $'Notified transaction fees rising to ($fee) sat/vB'
    } else {
        log debug $'Already notified transaction fees at ($fee) sat/vB'
    }
} else {
    log debug $'Transaction fees too high at ($fee) sat/vB'
}
