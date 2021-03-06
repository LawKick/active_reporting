# frozen_string_literal: true

module ActiveReporting
  module FunctionAdapters
    module Postgresql
      # The list of available datetime values.
      #
      # @return [Array<Symbol>]
      #
      def self.datetime_precision_values
        %i[microseconds milliseconds second minute hour day week month quarter year decade
           century millennium].freeze
      end

      # Whether the arg value is supported as a viable datetime
      # value for performing datetime functions.
      #
      def self.valid_datetime_precision_value?(value)
        datetime_precision_values.include?(value.to_sym)
      end

      # Generate a date truncation statement in PostgreSQL
      # See https://www.postgresql.org/docs/10/static/functions-datetime.html#FUNCTIONS-DATETIME-TRUNC
      #
      # @param [String, Symbol] datetime_precision_value
      # @param [String] quoted_table_name
      # @param [String] column_name
      #
      def self.date_truncate(datetime_precision_value, quoted_table_name, column_name)
        _active_reporting_date_trunc(datetime_precision_value, "#{quoted_table_name}.#{column_name}")
      end

      def self._active_reporting_date_trunc(datetime_precision_value, value)
        unless valid_datetime_precision_value?(datetime_precision_value)
          raise ArgumentError,
                "Interval value #{datetime_precision_value} is not valid for Postgres"
        end
        "DATE_TRUNC('#{datetime_precision_value}', #{value})"
      end
    end
  end
end
