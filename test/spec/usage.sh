#!/usr/bin/env bash
describe "help and usage"
  allow_diff "\/home\/[^\/]*"
  approve "repli --help"
  approve "repli"
