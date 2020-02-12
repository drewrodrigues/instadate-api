# frozen_string_literal: true

json.extract! conversation,
              :id,
              :messages_left,
              :accepting_user_id,
              :requesting_user_id,
              :created_at,
              :updated_at
