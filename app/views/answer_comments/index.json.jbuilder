json.array!(@answer_comments) do |answer_comment|
  json.extract! answer_comment, :id
  json.url answer_comment_url(answer_comment, format: :json)
end
