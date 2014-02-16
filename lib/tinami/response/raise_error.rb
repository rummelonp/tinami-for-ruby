# coding: utf-8

require 'faraday'
require 'tinami/error'

module TINAMI
  # @private
  module Response
    # @private
    class RaiseError < Faraday::Response::Middleware
      def on_complete(env)
        body = env[:body]
        return unless body
        response = env[:body]['rsp']
        return unless response
        if response['stat'] != 'ok' || response['err']
          message = response['err'] ? response['err']['msg'] : nil
          case response['stat'].to_sym
          when :fail
            raise FailError, message
          when :user_only
            raise UserOnlyError, message
          when :bookmark_user_only
            raise BookmarkUserOnlyError, message
          else
            raise Error, message
          end
        end
      end
    end
  end
end
