# coding: utf-8

require 'faraday'
require 'tinami/response/raise_error'

Faraday.register_middleware :response,
  raise_error: -> { TINAMI::Response::RaiseError }
