module Concerns
  module Commentable
    def commenting(by, content)
      Comment.create(
          creator_id: by,
          content: content,
          commentable: self
      )
    end
  end
end