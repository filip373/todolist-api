# frozen_string_literal: true

module APIRequestHelper
  def auth_get(path, **args)
    auth_enriched(args) { |enriched| get path, enriched }
  end

  def auth_post(path, **args)
    auth_enriched(args) { |enriched| post path, enriched }
  end

  def auth_put(path, **args)
    auth_enriched(args) { |enriched| put path, enriched }
  end

  def auth_delete(path, **args)
    auth_enriched(args) { |enriched| delete path, enriched }
  end

  private

  def auth_enriched(**args, &block)
    args[:headers] ||= {}
    args[:headers].merge! auth_header
    block.call args
  end

  def auth_header
    { authorization: "Bearer #{JWTHelper.valid_jwt}" }
  end
end
