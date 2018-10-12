#!/bin/sh

exec puma -b "ssl://0.0.0.0:$PORT?key=self_signed.key&cert=self_signed.cert"
