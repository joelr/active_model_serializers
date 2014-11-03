module ActiveModel
  class Serializer
    class ArraySerializer
      include Enumerable
      delegate :each, to: :@objects

      def initialize(objects, options = {})
        @objects = objects.map do |object|
          serializer_class = ActiveModel::Serializer.serializer_for(object)
          serializer_class.new(object, options)
        end
      end

      def json_key
        @objects.first.json_key if @objects.first
      end

      def root=(root)
        @objects.first.root = root if @objects.first
      end
    end
  end
end
