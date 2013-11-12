module ActiveSupport
  module Cache
    class Entry
      attr_reader :expires_in
    end

    # A cache store implementation which stores data using uWSGI Caching
    # Framework (http://uwsgi-docs.readthedocs.org/en/latest/Caching.html)
    class UwsgiStore < Store
      attr_reader :cache_name

      # Creates a new UwsgiStore object, with the given cache name.
      # The name must match with the one passed to the uwsgi instance.
      # For example:
      #
      #   $ uwsgi --cache2 name=test,items=100
      #
      #   ActiveSupport::Cache::UwsgiStore.new({cache_name: 'test'})
      #
      # The cache_name option can be omitted, in which case, the default one
      # will be used.
      def initialize(options = nil)
        options ||= {}
        @cache_name = options.delete(:cache_name)
        super(options)
      end

      def clear(options = nil)
        uwsgi_cache(:cache_clear)
      end

      protected
      def read_entry(key, options)
        deserialize_entry(uwsgi_cache(:cache_get, key))
      end

      def write_entry(key, entry, options = nil)
        value = Marshal.dump(entry)
        expires_in = entry.expires_in.to_i
        if exist?(key)
          uwsgi_cache(:cache_update, key, value, expires_in)
        else
          uwsgi_cache(:cache_set, key, value, expires_in)
        end
      end

      def delete_entry(key, options = nil)
        uwsgi_cache(:cache_del, key)
      end

      private
      def uwsgi_cache(method, *args)
        args << @cache_name if @cache_name
        UWSGI.send(method, *args)
      end

      def deserialize_entry(raw_value)
        if raw_value
          entry = Marshal.load(raw_value) rescue raw_value
          entry.is_a?(Entry) ? entry : Entry.new(entry)
        else
          nil
        end
      end
    end
  end
end
