module V1
  module Admin
    class UsersController < V1::AdminController
      def index
        return forbidden unless params[:token]

        id = JsonWebToken.new(params[:token]).decode[:user_id]
        user = User.find(id)
        return forbidden if user.nil?

        json = UserSerializer.new(user).serialized_json
        render status: 200, json: json
      end

      def show
        forbidden
      end

      def create
        forbidden
      end

      def update
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def resource_klass
        User
      end

      def serializer_klass
        V1::Admin::UserSerializer
      end

      def creatable_attributes
        %[]
        # %i[
        #   name
        #   company
        #   email
        #   mobile
        #   message
        #   purpose
        #   source
        #   ip
        #   ip_region
        #   ip_city
        # ]
      end

      def creatable_relationships
        %[]
        # %i[
        #  country
        #  ip_country
        # ]
      end

      def permitted_filters
        %[]
        # %i[
        #  main_group_id
        #  sub_group_id
        # ]
      end

      def permanent_filters
        {}
        # {
        #   public: true
        # }
      end

      def permitted_includes
        %[]
        # %i[
        #   related_articles
        #   related_products
        #   related_products.main_group
        #   translations
        # ]
      end

      # def after_create(lead)
      #   PostLeadToSlackJob.perform_later lead
      # end
    end
  end
end
